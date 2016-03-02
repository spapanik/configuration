. $HOME/.zsh/options.zsh
. $HOME/.zsh/alias.zsh
. $HOME/.zsh/constants.zsh
. $HOME/.zsh/functions.zsh
. $HOME/.zsh/git.zsh
. $HOME/.zsh/history.zsh
. $HOME/.zsh/keybinding.zsh
. $HOME/.zsh/completion.zsh
. $HOME/.zsh/theme.zsh
if [[ -a $HOME/.zsh/local.zsh ]]; then
    . $HOME/.zsh/local.zsh
fi
. `which virtualenvwrapper.sh`

fortune -s | cowsay -f tux
