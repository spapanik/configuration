function show_term_colours {
    tput setaf 0
    echo -e "Black"
    tput bold
    echo -e "Black bold"
    tput sgr0
    tput setaf 1
    echo -e "Red"
    tput bold
    echo -e "Red bold"
    tput sgr0
    tput setaf 2
    echo -e "Green"
    tput bold
    echo -e "Green bold"
    tput sgr0
    tput setaf 3
    echo -e "Yellow"
    tput bold
    echo -e "Yellow bold"
    tput sgr0
    tput setaf 4
    echo -e "Blue"
    tput bold
    echo -e "Blue bold"
    tput sgr0
    tput setaf 5
    echo -e "Magenta"
    tput bold
    echo -e "Magenta bold"
    tput sgr0
    tput setaf 6
    echo -e "Cyan"
    tput bold
    echo -e "Cyan bold"
    tput sgr0
    tput setaf 7
    echo -e "White"
    tput bold
    echo -e "White bold"
    tput sgr0
}

function show_unicode_support {
    echo "red dot: 🔴"
    echo "greek: ιίϊΐ"
    echo "cjk: 조선글漢嗰"
    echo "cyrillic: Ж ж"
    echo "smiley: 🙂"
    echo "canadian flag: 🇨🇦"
    echo "pride flag: 🏳️‍🌈"
    echo "party head: 🥳"
    echo "star-struck: 🤩"
    echo "guide dog: 🦮"
}

function show_commit_emojis {
    echo "🎨 Improve structure/format of the code"
    echo "⚡ Improve performance"
    echo "🔥 Remove code or files"
    echo "🐛 Fix a bug"
    echo "🚑 Critical hotfix"
    echo "✨ Introduce new features"
    echo "📝 Add or update documentation"
    echo "🚀 Deploy stuff"
    echo "💄 Add or update the UI and style files"
    echo "🎉 Begin a project"
    echo "✅ Add or update tests"
    echo "🔒 Fix security issues"
    echo "🔖 Release / Version tags"
    echo "🔧 Add or update configuration files"
    echo "✏️ Fix typos"
    echo "💩 Write bad code that needs improvement"
    echo "♻️ Refactor code"
    echo "🌐 Update code due to external API changes"
    echo "🚚 Move or rename resources"
    echo "💥 Introduce breaking changes"
    echo "🌍 Internationalization and localization"
    echo "🚧 Work in progress"
    echo "💚 Fix CI Build"
    echo "🐳 Work with Docker"
    echo "🍎 Fix something on macOS"
    echo "🐧 Fix something on Linux"
    echo "🏁 Fix something on Windows"
    echo "🤖 Fix something on Android"
    echo "📚 Write docs"
    echo "📦 Update compiled files or packages"
    echo "🤡 Mock things"
    echo "🥚 Add an easter egg"
    echo "🙈 Add or update .gitignore"
    echo "📸 Add or update snapshots"
    echo "⚗️ Perform experiments"
    echo "🔍 Improve SEO"
    echo "♿ Improve accessibility"
    echo "🏷️ Add or update types"
    echo "🏗️ Make architectural changes"
    echo "🐝 Fix something on iOS"
    echo "🧪 Add a failing test"
    echo "🧱 Infrastructure changes"
    echo "🌀 Add or update animations"
    echo "🚸 Improve user experience / usability"
    echo "🥅 Catch errors"
    echo "🧐 Add or update code reviews"
    echo "⚰️ Remove dead code"
    echo "🧵 Add or update multithreading code"
    echo "🦺 Add or update validation/assertions"
}

function docker_supernuke {
    local RUNNER=
    local RUN_AS_SUDO
    zmodload zsh/zutil
    zparseopts -D -F -K -- {s,-run-as-sudo}=RUN_AS_SUDO  || return 1

    if [[ $# -gt 0 ]]; then
        echo Unexpected arguments, aborting...
        return 1
    fi

    if (( $#RUN_AS_SUDO )); then
        RUNNER=sudo
    fi

    echo "Removing containers..."
    for id in $(${RUNNER} docker container ls -aq); do
        ${RUNNER} docker container rm -f ${id}
    done

    echo "Removing images..."
    for id in $(${RUNNER} docker image ls -aq); do
        ${RUNNER} docker image rm -f ${id}
    done

    echo "Removing volumes..."
    for id in $(${RUNNER} docker volume ls -q); do
        ${RUNNER} docker volume rm -f ${id}
    done

    echo "Removing networks..."
    for id in $(${RUNNER} docker network ls -q); do
        ${RUNNER} docker network rm ${id}
    done

    echo "Pruning the system..."
    ${RUNNER} docker system prune -af
}

function ws {
    if [[ ! -s $1 ]]; then
        return 0
    fi
    if [[ $(tail -c 1 $1 | wc -l) -eq 0 ]]; then
        echo >> $1
    elif [[ $(tail -c 2 $1 | head -c 1 | wc -l) -eq 1 ]]; then
        while [[ $(tail -c 2 $1 | head -c 1 | wc -l) -eq 1 ]]; do
            truncate -s -1 $1
        done
    fi
}

function fh {
    local cmd
    cmd=$(fc -ln 1 | tail -r | fzf)
    if [[ -n $cmd ]]; then
        echo Executing '`'"$cmd"'`'
        eval "$cmd"
        print -s "$cmd"
    fi
}

function add_to_path {
    local PREPEND
    zmodload zsh/zutil
    zparseopts -D -F -K -- {p,-prepend}=PREPEND  || return 1

    if [[ $# -gt 1 ]]; then
        echo Only one directory allowed, aborting...
        return 1
    fi

    if [[ $# -lt 1 ]]; then
        echo Directory undefined, aborting...
        return 1
    fi

    if [[ ${path[(i)$1]} -gt ${#path} ]]; then
        if (( $#PREPEND )); then
            export PATH="$1":"$PATH"
        else
            export PATH="$PATH":"$1"
        fi
    fi
}

function add_to_fpath {
    local PREPEND
    zmodload zsh/zutil
    zparseopts -D -F -K -- {p,-prepend}=PREPEND  || return 1

    if [[ $# -gt 1 ]]; then
        echo Only one directory allowed, aborting...
        return 1
    fi

    if [[ $# -lt 1 ]]; then
        echo Directory undefined, aborting...
        return 1
    fi

    if [[ ${fpath[(i)$1]} -gt ${#fpath} ]]; then
        if (( $#PREPEND )); then
            export FPATH="$1":"$FPATH"
        else
            export FPATH="$FPATH":"$1"
        fi
    fi
}
