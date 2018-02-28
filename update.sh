#!/usr/bin/env bash
FILES=".pyrc
.vim
.zsh
.zshrc
.emacs.d
.gitconfig
"

filepath=${0:a}
dirpath=$(dirname ${filepath})
cd ${dirpath}
for FILE in ${FILES}; do
    cp -vR ${FILE} ${HOME}
done
