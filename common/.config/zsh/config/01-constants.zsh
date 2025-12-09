export LC_COLLATE=C

export EDITOR='nvim'
export VISUAL="$EDITOR"

export RIPGREP_CONFIG_PATH="$HOME"/.config/ripgrep/rgrc
export PTPYTHON_CONFIG_HOME="$HOME"/.config/ptpython

export LESS='-FRXKS'
export PAGER=less
export GPG_TTY=$(tty)
export PYENV_SHELL=zsh
export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export WERKZEUG_DEBUG_PIN=off
export PYTHONPYCACHEPREFIX="$HOME"/.cache/pycache/
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
