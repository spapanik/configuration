. "$HOME"/.config/zsh/alias.zsh
. "$HOME"/.config/zsh/pip.zsh
. "$HOME"/.config/zsh/git.zsh
. "$HOME"/.config/zsh/constants.zsh
. "$HOME"/.config/zsh/functions.zsh
. "$HOME"/.config/zsh/path.zsh
. "$HOME"/.config/zsh/history.zsh
. "$HOME"/.config/zsh/keybinding.zsh
. "$HOME"/.config/zsh/completion.zsh
. "$HOME"/.config/zsh/autocorrect.zsh
. "$HOME"/.config/zsh/theme.zsh

if [[ -r "$HOME"/.config/zsh/local.zsh ]]; then
    . "$HOME"/.config/zsh/local.zsh
fi

if [ -z "${NOFORTUNE+1}" ]; then
	fortune -s | cowsay -f tux
fi
