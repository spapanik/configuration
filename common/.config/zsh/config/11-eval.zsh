eval "$(zoxide init zsh)"

if (( $+commands[jj] )); then
    eval "$(command jj --init --use-aliases zsh)"
fi
