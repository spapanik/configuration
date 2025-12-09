key[Ctrl-U]="^U"
key[M-Left]="^[[1;5D"
key[M-Right]="^[[1;5C"

bindkey "${key[Up]}" up-line-or-beginning-search
bindkey "${key[Down]}" down-line-or-beginning-search
bindkey "${key[Ctrl-U]}" backward-kill-line
bindkey "${key[M-Left]}" backward-word
bindkey "${key[M-Right]}" forward-word
