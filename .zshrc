# antigen start
. /usr/share/zsh/scripts/antigen/antigen.zsh
antigen use oh-my-zsh
antigen bundle pip
antigen bundle git
antigen apply
# antigen end

. .zsh/options.zsh
. .zsh/alias.zsh
. .zsh/constants.zsh
. .zsh/functions.zsh
. .zsh/history.zsh
. .zsh/keybinding.zsh
. .zsh/completion.zsh
. .zsh/theme.zsh
if [[ -a .zsh/local.zsh ]]; then
    . .zsh/local.zsh
fi
. `which virtualenvwrapper.sh`

fortune -s | cowsay -f tux
