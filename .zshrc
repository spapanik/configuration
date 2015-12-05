source .zsh/options.zsh
source .zsh/alias.zsh
source .zsh/export.zsh
source .zsh/git.zsh
source .zsh/history.zsh
source .zsh/keybinding.zsh
source .zsh/completion.zsh
source .zsh/theme.zsh
source `which virtualenvwrapper.sh`

cd $HOME
fortune -s | cowsay -f tux
