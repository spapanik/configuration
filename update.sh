#!/usr/bin/env bash
if [[ $(uname) == 'Darwin' ]]; then
	copy=gcp
else
	copy=cp
fi
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
	echo Updating ${FILE}...
	${copy} -R ${FILE} ${HOME}
done
