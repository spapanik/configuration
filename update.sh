#/usr/bin/bash
FILES=".pyrc
.tmux.conf
.vim
.vimrc
.Xmodmap
.zsh
.zshrc
"

for FILE in ${FILES}; do
    cp -vR ${FILE} ${HOME}
done
