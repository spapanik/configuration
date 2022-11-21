export LC_COLLATE=C

if [[ -f ${HOME}/.editor && $(cat "${HOME}"/.editor) == "emacs" ]]; then
    export VISUAL='emacs -nw'
else
    export VISUAL='nvim'
fi
export EDITOR="$VISUAL"

export LESS='-FRXK'
export PAGER="less -S"
export RIPGREP_CONFIG_PATH="${HOME}"/.config/ripgrep/rgrc
export GPG_TTY=$(tty)
export PYENV_SHELL=zsh
export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export TIMEFMT=$'
%J
================
userspace  %*U
kernel     %*S
wall       %*E
----------------
CPU        %P
----------------
space      %K KB
----------------
memory     %M KB
'
