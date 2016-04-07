. $HOME/.zsh/options.zsh
. $HOME/.zsh/alias.zsh
. $HOME/.zsh/constants.zsh
. $HOME/.zsh/functions.zsh
. $HOME/.zsh/git.zsh
. $HOME/.zsh/history.zsh
if [[ -a $HOME/.zsh/.use_vim_mode ]]; then
    . $HOME/.zsh/vim_keybinding.zsh
else
    . $HOME/.zsh/keybinding.zsh
fi
. $HOME/.zsh/completion.zsh
. $HOME/.zsh/theme.zsh
if [[ -a $HOME/.zsh/local.zsh ]]; then
    . $HOME/.zsh/local.zsh
fi
. `which virtualenvwrapper.sh`

fortune -s | cowsay -f tux
