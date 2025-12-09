key[Ctrl-Right]="^[[1;5C"
key[Ctrl-Left]="^[[1;5D"
key[Ctrl-U]="^U"
key[Ctrl-P]="^P"
key[Ctrl-N]="^N"

bindkey "${key[Home]}" beginning-of-line
bindkey "${key[End]}" end-of-line
bindkey "${key[Insert]}" overwrite-mode
bindkey "${key[Delete]}" delete-char
bindkey "${key[Up]}" history-beginning-search-backward
bindkey "${key[Down]}" history-beginning-search-forward
bindkey "${key[Left]}" backward-char
bindkey "${key[Right]}" forward-char
bindkey "${key[PageUp]}" beginning-of-buffer-or-history
bindkey "${key[PageDown]}" end-of-buffer-or-history
bindkey "${key[Ctrl-Right]}" forward-word
bindkey "${key[Ctrl-Left]}" backward-word
bindkey "${key[Ctrl-U]}" backward-kill-line
bindkey "${key[Ctrl-P]}" history-beginning-search-backward
bindkey "${key[Ctrl-N]}" history-beginning-search-forward
