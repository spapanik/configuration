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

stty stop '' -ixoff
stty stop '' -ixon

bindkey -v
typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}
key[CtrlRight]="^[[1;5C"
key[CtrlLeft]="^[[1;5D"

bindkey "${key[Home]}"        beginning-of-line
bindkey "${key[End]}"         end-of-line
bindkey "${key[Insert]}"      overwrite-mode
bindkey "${key[Delete]}"      delete-char
bindkey "${key[Up]}"          history-beginning-search-backward
bindkey "${key[Down]}"        history-beginning-search-forward
bindkey "${key[Left]}"        backward-char
bindkey "${key[Right]}"       forward-char
bindkey "${key[PageUp]}"      beginning-of-buffer-or-history
bindkey "${key[PageDown]}"    end-of-buffer-or-history
bindkey "${key[CtrlRight]}"   forward-word
bindkey "${key[CtrlLeft]}"    backward-word
