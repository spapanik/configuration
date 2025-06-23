source "$HOME"/.config/zsh/constants.zsh
source "$HOME"/.config/zsh/alias.zsh
source "$HOME"/.config/zsh/pip.zsh
source "$HOME"/.config/zsh/git.zsh
source "$HOME"/.config/zsh/functions.zsh
source "$HOME"/.config/zsh/path.zsh
source "$HOME"/.config/zsh/history.zsh
source "$HOME"/.config/zsh/keybinding.zsh
source "$HOME"/.config/zsh/completion.zsh
source "$HOME"/.config/zsh/autocorrect.zsh
source "$HOME"/.config/zsh/theme.zsh
source "$HOME"/.config/zsh/eval.zsh

if [[ -r "$HOME"/.config/zsh/local.zsh ]]; then
    . "$HOME"/.config/zsh/local.zsh
fi

if [ -z "${NOFORTUNE+1}" ]; then
    fortune -s | cowsay -f tux
fi
