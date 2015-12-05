source .zsh/git.zsh

autoload colors; colors;
export LSCOLORS="Gxfxcxdxbxegedabagacad"

setopt auto_cd
setopt multios
setopt cdablevarS

if [[ x$WINDOW != x ]]
then
    SCREEN_NO="%B$WINDOW%b "
else
    SCREEN_NO=""
fi

setopt prompt_subst

alias ls="ls --color"
alias ll="ls --color -l"
alias manage="python manage.py"
alias grepc="grep --color=auto"

export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history

setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt inc_append_history
setopt share_history

typeset -A key

source .zsh/keybinding.zsh

if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

source .zsh/completion.zsh
source .zsh/theme.zsh

cd $HOME
fortune -s | cowsay -f tux

source `which virtualenvwrapper.sh`

export PYTHONSTARTUP="$HOME/.pyrc"
