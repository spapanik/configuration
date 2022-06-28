fpath=("${HOME}"/.config/zsh/completions ${fpath})
setopt completealiases
zstyle ':completion:*' rehash true
zstyle ':completion:*' menu select
autoload -U compinit
compinit
