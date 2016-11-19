#/usr/bin/bash
FILES=".pyrc
.tmux.conf
.vim
.vimrc
.zsh
.zshrc
.emacs.d
"

filepath=${0:a}
dirpath=`dirname $filepath`
cd $dirpath
for FILE in ${FILES}; do
    cp -vR ${FILE} ${HOME}
done
