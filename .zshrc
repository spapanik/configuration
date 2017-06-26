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
if [[ -a $HOME/.zsh/local.zsh ]]; then
    . .zsh/local.zsh
fi
. $(which virtualenvwrapper.sh)

fortune -s | cowsay -f tux
