# antigen start
if [[ `uname` == 'Darwin' ]]; then
    . $(brew --prefix)/share/antigen/antigen.zsh
else
    . /usr/share/zsh/scripts/antigen/antigen.zsh
fi
antigen use oh-my-zsh
antigen bundle pip
antigen bundle git
antigen apply
# antigen end

cd $HOME
. .zsh/options.zsh
. .zsh/alias.zsh
. .zsh/constants.zsh
. .zsh/functions.zsh
. .zsh/history.zsh
. .zsh/keybinding.zsh
. .zsh/completion.zsh
. .zsh/theme.zsh
if [[ -a $HOME/.zsh/local.zsh ]]; then
    . .zsh/local.zsh
fi
. `which virtualenvwrapper.sh`

fortune -s | cowsay -f tux
