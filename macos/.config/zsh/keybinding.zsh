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

key[up]="${terminfo[kcuu1]}"
key[down]="${terminfo[kcud1]}"
key[C-up]="^U"
key[M-left]="^[[1;5D"
key[M-right]="^[[1;5C"

bindkey "${key[up]}" up-line-or-beginning-search
bindkey "${key[down]}" down-line-or-beginning-search
bindkey "${key[C-up]}" backward-kill-line
bindkey "${key[M-left]}" backward-word
bindkey "${key[M-right]}" forward-word
