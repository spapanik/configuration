#!/usr/bin/env bash

CLEAR=false
while getopts c name; do
	case $name in
		c)
			CLEAR=true;;
	esac
done

dirpath=$(dirname $(realpath ${0}))

for arg in $@; do
	SOURCE=${dirpath}/${arg}
	TARGET=${HOME}/${arg}
	if [[ -r "${SOURCE}" ]]; then
		if ( ${CLEAR} ); then
			rm -rf ${HOME}/${arg}
		fi
		ln -s ${dirpath}/${arg} ${HOME}/${arg}
	fi
done
