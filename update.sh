#/usr/bin/bash
FILES=".pyrc
.tmux.conf
.vim
.zsh
.zshrc
.emacs.d
.evrouterrc
.gitconfig
"

filepath=${0:a}
dirpath=$(dirname $filepath)
cd $dirpath
for FILE in ${FILES}; do
    cp -vR ${FILE} ${HOME}
done
