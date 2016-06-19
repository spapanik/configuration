#/usr/bin/bash
FILES=".pyrc
.apvlvrc
.config
.tmux.conf
.vim
.vimrc
.Xmodmap
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
