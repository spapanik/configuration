autoload colors; colors;
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

source .zsh/alias.zsh
source .zsh/export.zsh
source .zsh/git.zsh
source .zsh/history.zsh
source .zsh/keybinding.zsh
source .zsh/completion.zsh
source .zsh/theme.zsh


source `which virtualenvwrapper.sh`

cd $HOME
fortune -s | cowsay -f tux
