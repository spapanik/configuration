add_to_fpath -p "${HOME}"/.config/zsh/completions
setopt completealiases
zstyle ':completion:*' rehash true
zstyle ':completion:*' menu select
autoload -U compinit
compinit
