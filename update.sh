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

dirpath=$(dirname $(realpath ${0}))

cd ${dirpath}
for FILE in ${FILES}; do
	echo Updating ${FILE}...
	${copy} -R ${FILE} ${HOME}
done
