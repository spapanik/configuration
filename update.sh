#/usr/bin/bash
FILES=".pyrc
.tmux.conf
.vim
.vimrc
.Xmodmap
.zsh
.zshrc
"

filepath=${0:a}
dirpath=`dirname $filepath`
cd $dirpath
for FILE in ${FILES}; do
    cp -vR ${FILE} ${HOME}
done
