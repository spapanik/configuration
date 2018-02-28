#!/usr/bin/env bash
FILES=".zshrc
.zsh
.gitconfig
.vim
.emacs.d
"

filepath=${0:a}
dirpath=$(dirname ${filepath})
cd ${dirpath}
for FILE in ${FILES}; do
    cp -vR ${FILE} ${HOME}
done
