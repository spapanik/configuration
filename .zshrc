cd $HOME

. $HOME/.zsh/options.zsh
. $HOME/.zsh/alias.zsh
. $HOME/.zsh/export.zsh
. $HOME/.zsh/git.zsh
. $HOME/.zsh/history.zsh
. $HOME/.zsh/keybinding.zsh
. $HOME/.zsh/completion.zsh
. $HOME/.zsh/theme.zsh
. `which virtualenvwrapper.sh`

fortune -s | cowsay -f tux
