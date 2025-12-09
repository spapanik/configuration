function zle-line-init() {
    printf '%s' "${terminfo[smkx]}"
}

function zle-line-finish() {
    printf '%s' "${terminfo[rmkx]}"
}

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
zle -N zle-line-init
zle -N zle-line-finish

stty stop '' -ixoff
stty stop '' -ixon

bindkey -e
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
