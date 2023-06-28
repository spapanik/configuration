add_to_fpath -p "${HOME}"/.config/zsh/completions
setopt completealiases
zstyle ':completion:*' rehash true
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
autoload -U compinit
compinit
