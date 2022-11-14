FPATH="${HOME}"/.config/zsh/completions:${FPATH}
setopt completealiases
zstyle ':completion:*' rehash true
zstyle ':completion:*' menu select
autoload -U compinit
compinit
