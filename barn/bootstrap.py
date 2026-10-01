#!/usr/bin/env python3
"""Install packages from ordered TOML manifests; see README.md for the schema.

Commands are argument arrays. Hooks and bootstrap commands are shell strings.
No commands run until configuration and dependencies have been validated.
"""

import argparse
import json
import os
import platform
import re
import shlex
import subprocess
import sys
from pathlib import Path

try:
    import tomllib  # Python 3.11+
except ModuleNotFoundError:
    tomllib = None

SCRIPT_DIR = Path(__file__).resolve().parent


# TODO: delete the fallback parser below once macOS ships a /usr/bin/python3
# newer than 3.10. stdlib tomllib (used by load_toml when available) covers
# everything, so this whole subset parser can go.
_TOML_ESCAPES = {
    "0": "\0",
    '"': '"',
    "\\": "\\",
    "n": "\n",
    "r": "\r",
    "t": "\t",
}


def _strip_toml_comment(line):
    """Drop a trailing # comment, ignoring hashes inside quoted strings."""
    quote = None
    for i, char in enumerate(line):
        if quote is not None:
            if char == quote:
                quote = None
        elif char in ("'", '"'):
            quote = char
        elif char == "#":
            return line[:i]
    return line


def _toml_bracket_depth(text):
    depth = 0
    quote = None
    escaped = False
    for char in text:
        if quote is not None:
            if escaped:
                escaped = False
            elif char == "\\" and quote == '"':
                escaped = True
            elif char == quote:
                quote = None
        elif char in ("'", '"'):
            quote = char
        elif char == "[":
            depth += 1
        elif char == "]":
            depth -= 1
    return depth


def _toml_strings(text):
    """Return every quoted string found in text (used to read array items)."""
    strings = []
    i = 0
    while i < len(text):
        char = text[i]
        if char in ("'", '"'):
            quote = char
            i += 1
            chars = []
            while i < len(text) and text[i] != quote:
                if quote == '"' and text[i] == "\\" and i + 1 < len(text):
                    chars.append(_TOML_ESCAPES.get(text[i + 1], text[i + 1]))
                    i += 2
                else:
                    chars.append(text[i])
                    i += 1
            strings.append("".join(chars))
            i += 1
        else:
            i += 1
    return strings


def _toml_scalar(value):
    if value and value[0] in ("'", '"'):
        parsed = _toml_strings(value)
        if len(parsed) != 1:
            raise ValueError("invalid TOML scalar: %r" % value)
        return parsed[0]
    raise ValueError("unsupported TOML value: %r" % value)


def _toml_split_items(text):
    """Split text on top-level commas, ignoring quotes and nested brackets."""
    items = []
    depth = 0
    quote = None
    escaped = False
    start = 0
    for i, char in enumerate(text):
        if quote is not None:
            if escaped:
                escaped = False
            elif char == "\\" and quote == '"':
                escaped = True
            elif char == quote:
                quote = None
        elif char in ("'", '"'):
            quote = char
        elif char in "[{":
            depth += 1
        elif char in "]}":
            depth -= 1
        elif char == "," and depth == 0:
            items.append(text[start:i])
            start = i + 1
    items.append(text[start:])
    return items


def _toml_value(item):
    """Parse one quoted string or inline table used as an array entry."""
    item = item.strip()
    if item.startswith(("'", '"')):
        parsed = _toml_strings(item)
        if len(parsed) != 1:
            raise ValueError("invalid array entry: %r" % item)
        return parsed[0]
    if item.startswith("["):
        if not item.endswith("]"):
            raise ValueError("malformed array: %r" % item)
        return _toml_array(item)
    if item.startswith("{"):
        if not item.endswith("}"):
            raise ValueError("malformed inline table: %r" % item)
        table = {}
        for part in _toml_split_items(item[1:-1]):
            part = part.strip()
            if not part:
                continue
            key, equals, value = part.partition("=")
            if not equals:
                raise ValueError("malformed inline table pair: %r" % part)
            table[key.strip()] = _toml_value(value.strip())
        return table
    raise ValueError("unsupported array entry: %r" % item)


def _toml_array(text):
    """Parse a [...] array holding strings and inline tables."""
    return [
        _toml_value(item)
        for item in _toml_split_items(text[1:-1])
        if item.strip()
    ]


def _parse_toml_subset(text):
    """Parse the small TOML subset used by paths.toml and manifest.toml.

    Supports [table] headers, string scalars, and arrays spanning multiple
    lines whose entries are strings or inline tables of strings, plus
    # comments and blank lines.
    """
    root = {}
    table = root
    open_key = None
    buffer = ""
    for line_number, raw_line in enumerate(text.splitlines(), start=1):
        line = _strip_toml_comment(raw_line).strip()
        if open_key is not None:
            buffer += line
            if _toml_bracket_depth(buffer) <= 0:
                table[open_key] = _toml_array(buffer)
                open_key = None
                buffer = ""
            continue
        if not line:
            continue
        if line.startswith("["):
            if not line.endswith("]"):
                raise ValueError("line %d: malformed table header" % line_number)
            table = root
            for part in line[1:-1].strip().split("."):
                table = table.setdefault(part.strip(), {})
            continue
        key, equals, value = line.partition("=")
        if not equals:
            raise ValueError("line %d: expected key = value" % line_number)
        key = key.strip()
        value = value.strip()
        if value.startswith("["):
            if _toml_bracket_depth(value) > 0:
                open_key = key
                buffer = value
            else:
                table[key] = _toml_array(value)
        else:
            table[key] = _toml_scalar(value)
    if open_key is not None:
        raise ValueError("unterminated array in TOML input")
    return root


def load_toml(path):
    path = Path(path)
    if tomllib is not None:
        with path.open("rb") as handle:
            return tomllib.load(handle)
    with path.open(encoding="utf-8") as handle:
        return _parse_toml_subset(handle.read())


def announce(message, kind="info"):
    styles = {"info": ("36", "➜"), "phase": ("1;35", "🚀"),
              "skip": ("2", "✓"), "warning": ("33", "⚠"), "error": ("31", "✗")}
    color, icon = styles[kind]
    message = "%s %s" % (icon, message)
    if sys.stdout.isatty() and "NO_COLOR" not in os.environ:
        message = "\033[%sm%s\033[0m" % (color, message)
    print(message, flush=True)


def load_manifests():
    system = {"Darwin": "macos"}.get(platform.system(), platform.system().lower())
    config = load_toml(SCRIPT_DIR / "paths.toml")
    manifests = []
    paths = config.get("paths", [])
    if not isinstance(paths, list) or any(not isinstance(path, str) for path in paths):
        raise ValueError("paths.toml paths must be an array of strings")
    for raw_path in paths:
        path = Path(raw_path.replace("{platform}", system)).expanduser()
        if not path.is_absolute():
            path = (SCRIPT_DIR / path).resolve()
        if not path.is_file():
            raise ValueError("missing manifest: %s" % path)
        if path in manifests:
            announce("%s: duplicate manifest removed" % path, "warning")
            continue
        manifests.append(path)
    return manifests


def entry_id(entry, hooks=False):
    if hooks:
        if not isinstance(entry, (str, dict)):
            raise ValueError("hook must be a string or table: %r" % entry)
        return entry if isinstance(entry, str) else entry.get("id", entry.get("run"))
    return json.dumps(entry, sort_keys=True)


def merge_config(base, extra, source="configuration", trail=()):
    """Merge tables, dedupe collection lists, and replace command arrays."""
    collections = {"packages", "requires", "path", "pre-install", "post-install"}
    for key, value in extra.items():
        location = trail + (key,)
        current = base.get(key)
        if isinstance(value, dict):
            if not isinstance(current, dict):
                current = {}
                base[key] = current
            merge_config(current, value, source, location)
        elif isinstance(value, list) and key in collections:
            if not isinstance(current, list):
                current = []
                base[key] = current
            hooks = key in {"pre-install", "post-install"}
            def identity_of(item):
                return package(item)[0] if key == "packages" else entry_id(item, hooks)

            present = {identity_of(item): item for item in current}
            for item in value:
                identity = identity_of(item)
                if identity in present:
                    if hooks and item != present[identity]:
                        raise ValueError("%s: conflicting hook %r in %s" %
                                         (source, identity, ".".join(location)))
                    if key == "packages" and package(item)[1] != package(present[identity])[1]:
                        raise ValueError("%s: conflicting arguments for package %s in %s" %
                                         (source, identity, ".".join(location)))
                    announce("%s: duplicate %r in %s removed" %
                             (source, item, ".".join(location)), "warning")
                    continue
                current.append(item)
                present[identity] = item
        else:
            base[key] = value
    return base


def load_config(manifests):
    config = {}
    for path in manifests:
        merge_config(config, load_toml(path), str(path))
    return config


def command(argv, label, placeholder=False):
    if (not isinstance(argv, list) or not argv or
            any(not isinstance(arg, str) or not arg for arg in argv)):
        raise ValueError("%s must be a nonempty array of strings" % label)
    if placeholder and not any("{package}" in arg for arg in argv):
        raise ValueError("%s must contain {package}" % label)
    return argv


def package(entry):
    if isinstance(entry, str):
        # A string is a single package, not a shell command.
        name, args = entry, [entry]
    elif isinstance(entry, list):
        args = entry
        name = args[0] if args else None
        if isinstance(name, str) and name.startswith("-"):
            raise ValueError("packages starting with options need {name, args}")
    elif isinstance(entry, dict):
        name, args = entry.get("name"), entry.get("args")
    else:
        raise ValueError("invalid package entry: %r" % entry)
    if not isinstance(name, str) or not name or name.startswith("-"):
        raise ValueError("package must have an explicit name: %r" % entry)
    return name, command(args, "package args")


def package_groups(manager):
    result = []
    if manager.get("packages"):
        result.append(("packages", manager))
    for name, group in manager.get("groups", {}).items():
        if group.get("packages"):
            result.append((name, group))
    return result


def manager_plan(config):
    """Validate the entire config, then order only active managers and dependencies."""
    unknown = set(config) - {"pac-man", "tools", "pre-install", "post-install"}
    if unknown:
        raise ValueError("unknown configuration sections: " + ", ".join(sorted(unknown)))
    managers = {}
    for kind in ("pac-man", "tools"):
        section = config.get(kind, {})
        if not isinstance(section, dict):
            raise ValueError("%s must be a table" % kind)
        for name, manager in section.items():
            ref = "%s.%s" % (kind, name)
            if not isinstance(manager, dict):
                raise ValueError("%s must be a table" % ref)
            managers[ref] = manager
            for key in ("check_command", "install_command", "installed_command",
                        "package_check_command"):
                if key in manager:
                    command(manager[key], ref + "." + key,
                            placeholder=key == "package_check_command")
            for key in ("path", "requires"):
                values = manager.get(key, [])
                if not isinstance(values, list) or any(not isinstance(v, str) for v in values):
                    raise ValueError("%s.%s must be an array of strings" % (ref, key))
            if "bootstrap_command" in manager:
                value = manager["bootstrap_command"]
                if isinstance(value, list):
                    command(value, ref + ".bootstrap_command")
                elif not isinstance(value, str) or not value:
                    raise ValueError("%s.bootstrap_command must be a shell string or command array" % ref)
            groups = manager.get("groups", {})
            if not isinstance(groups, dict) or any(not isinstance(g, dict) for g in groups.values()):
                raise ValueError("%s.groups must contain tables" % ref)
            for group_name, group in [("packages", manager)] + list(groups.items()):
                install_mode = group.get("install_mode", manager.get("install_mode", "individual"))
                if install_mode not in ("individual", "batch"):
                    raise ValueError("%s.install_mode must be individual or batch" % ref)
                entries = group.get("packages", [])
                if not isinstance(entries, list):
                    raise ValueError("%s.%s packages must be an array" % (ref, group_name))
                if entries:
                    command(group.get("install_command", manager.get("install_command")),
                            ref + "." + group_name + ".install_command")
                for key in ("installed_command", "package_check_command"):
                    if key in group:
                        command(group[key], ref + "." + group_name + "." + key,
                                placeholder=key == "package_check_command")
                if "installed_pattern" in group:
                    if not isinstance(group["installed_pattern"], str):
                        raise ValueError("installed_pattern must be a string")
                    try:
                        pattern = re.compile(group["installed_pattern"])
                    except re.error as error:
                        raise ValueError("invalid installed_pattern: %s" % error) from error
                    if pattern.groups < 1:
                        raise ValueError("installed_pattern needs a package-name capture group")
                seen = {}
                unique = []
                for entry in entries:
                    name, args = package(entry)
                    if install_mode == "batch" and args != [name]:
                        raise ValueError("batch installs only accept plain package names")
                    if name in seen:
                        if args != seen[name]:
                            raise ValueError("%s: conflicting arguments for package %s" % (ref, name))
                        announce("%s.%s: duplicate package %s removed" %
                                 (ref, group_name, name), "warning")
                    else:
                        seen[name] = args
                        unique.append(entry)
                if entries:
                    group["packages"] = unique
    visiting, visited, ordered = set(), set(), []

    def visit(ref):
        if ref not in managers:
            raise ValueError("unknown manager dependency: %s" % ref)
        if ref in visiting:
            raise ValueError("manager dependency cycle involving %s" % ref)
        if ref in visited:
            return
        visiting.add(ref)
        for dependency in managers[ref].get("requires", []):
            if ref.startswith("pac-man.") and dependency.startswith("tools."):
                raise ValueError("package managers cannot depend on tools: %s" % ref)
            visit(dependency)
        visiting.remove(ref)
        visited.add(ref)
        ordered.append(ref)

    # Validate even inactive dependency graphs before executing anything.
    for ref in managers:
        visit(ref)
    validated_order = ordered[:]
    ordered, visited = [], set()
    for ref in validated_order:
        if package_groups(managers[ref]):
            visit(ref)
    for ref in ordered:
        command(managers[ref].get("check_command"), ref + ".check_command")
    return managers, ordered


def validate_hooks(config):
    ids = set()
    for label in ("pre-install", "post-install"):
        entries = config.get(label, [])
        if not isinstance(entries, list):
            raise ValueError("%s must be an array" % label)
        for entry in entries:
            if isinstance(entry, str):
                if not entry:
                    raise ValueError("empty hook command")
                continue
            if not isinstance(entry, dict) or not isinstance(entry.get("run"), str) or not entry["run"]:
                raise ValueError("%s hooks need a run command" % label)
            if "mode" in entry:
                raise ValueError("hook mode is unsupported; use unless")
            if "unless" in entry and not isinstance(entry["unless"], str):
                raise ValueError("hook unless must be a shell string")
            identity = entry.get("id")
            if identity is not None:
                if not isinstance(identity, str) or not identity or identity in ids:
                    raise ValueError("invalid or repeated hook id: %r" % identity)
                ids.add(identity)


def shell_argv(value):
    if platform.system() == "Windows":
        return [os.environ.get("COMSPEC", "cmd.exe"), "/c", value]
    return ["/bin/bash", "-c", value]


def run_shell(value):
    announce("$ " + value)
    subprocess.run(shell_argv(value), check=True)


def succeeds(argv):
    try:
        return subprocess.run(argv, stdout=subprocess.DEVNULL,
                              stderr=subprocess.DEVNULL).returncode == 0
    except FileNotFoundError:
        return False


def run_hook(label, entries):
    if not entries:
        return
    announce(label, "phase")
    for entry in entries:
        if isinstance(entry, str):
            run_shell(entry)
            continue
        value = entry["run"]
        name = entry.get("id", value)
        guard = entry.get("unless")
        if guard is not None:
            if succeeds(shell_argv(guard)):
                announce("%s: condition satisfied, skipped" % name, "skip")
                continue
        run_shell(value)


def add_paths(manager):
    paths = [str(Path(path).expanduser()) for path in manager.get("path", [])]
    current = os.environ.get("PATH", "").split(os.pathsep)
    os.environ["PATH"] = os.pathsep.join(dict.fromkeys(paths + current))


def bootstrap(ref, manager):
    add_paths(manager)
    if succeeds(manager["check_command"]):
        announce("%s: available" % ref, "skip")
        return
    value = manager.get("bootstrap_command")
    if not value:
        raise ValueError("%s is unavailable; install it or configure bootstrap_command" % ref)
    announce("Bootstrapping " + ref)
    if isinstance(value, str):
        run_shell(value)
    else:
        announce("$ " + shlex.join(value))
        subprocess.run(value, check=True)
    add_paths(manager)
    if not succeeds(manager["check_command"]):
        raise ValueError("%s is still unavailable after bootstrap; check its path configuration" % ref)


def installed_packages(settings):
    argv = settings.get("installed_command")
    if argv is None:
        return set()
    result = subprocess.run(argv, check=True, capture_output=True, text=True)
    # Preserve indentation; capture group 1 is the canonical package name.
    pattern = re.compile(settings.get("installed_pattern", r"^(\S+)$"))
    return {match.group(1) for line in result.stdout.splitlines()
            for match in [pattern.fullmatch(line)] if match is not None}


def install_packages(ref, manager):
    for group_name, group in package_groups(manager):
        settings = dict(manager)
        settings.update(group)
        installed = installed_packages(settings)
        pending = []
        for entry in group["packages"]:
            name, args = package(entry)
            check = settings.get("package_check_command")
            if name in installed or (check and succeeds([arg.replace("{package}", name) for arg in check])):
                announce("%s/%s: %s already installed" % (ref, group_name, name), "skip")
                continue
            pending.append(args)
            installed.add(name)
        if settings.get("install_mode") == "batch" and pending:
            pending = [[arg for args in pending for arg in args]]
        for args in pending:
            argv = [*settings["install_command"], *args]
            announce("$ " + shlex.join(argv))
            subprocess.run(argv, check=True)


def main(check_only=False):
    config = load_config(load_manifests())
    managers, ordered = manager_plan(config)
    validate_hooks(config)
    if check_only:
        announce("Configuration valid; active managers: " + (", ".join(ordered) or "none"), "skip")
        return
    run_hook("pre-install", config.get("pre-install", []))
    for kind, label in (("pac-man", "Package managers"), ("tools", "Tools")):
        active = [ref for ref in ordered if ref.startswith(kind + ".")]
        if not active:
            continue
        announce("Bootstrap " + label.lower(), "phase")
        for ref in active:
            bootstrap(ref, managers[ref])
        announce("Install " + label.lower() + " packages", "phase")
        for ref in active:
            install_packages(ref, managers[ref])
    run_hook("post-install", config.get("post-install", []))
    announce("Installation complete", "phase")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--check", action="store_true", help="validate configuration without running commands")
    args = parser.parse_args()
    try:
        main(check_only=args.check)
    except (ValueError, OSError, subprocess.CalledProcessError) as error:
        announce(str(error), "error")
        sys.exit(1)
