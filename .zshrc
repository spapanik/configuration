cd $HOME
. .zsh/alias.zsh
. .zsh/pip.zsh
. .zsh/git.zsh
. .zsh/constants.zsh
. .zsh/functions.zsh
. .zsh/history.zsh
. .zsh/keybinding.zsh
. .zsh/completion.zsh
. .zsh/theme.zsh
if [[ -r $HOME/.zsh/local.zsh ]]; then
    . .zsh/local.zsh
fi

if [ -z "${NOVENVWRAPPER+1}" ]; then
	. $(which virtualenvwrapper.sh)
fi

if [ -z "${NOFORTUNE+1}" ]; then
	fortune -s | cowsay -f tux
fi
