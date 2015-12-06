cd $HOME

source $HOME/.zsh/options.zsh
source $HOME/.zsh/alias.zsh
source $HOME/.zsh/export.zsh
source $HOME/.zsh/git.zsh
source $HOME/.zsh/history.zsh
source $HOME/.zsh/keybinding.zsh
source $HOME/.zsh/completion.zsh
source $HOME/.zsh/theme.zsh
source `which virtualenvwrapper.sh`

fortune -s | cowsay -f tux
