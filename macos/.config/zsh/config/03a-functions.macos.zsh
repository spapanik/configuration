function clc {
    printf "$(tail -n2 ~/.zsh_history | head -n1)" | pbcopy
}
