#!/usr/bin/env zsh

zmodload zsh/zutil
zparseopts -D -F -K -- {f,-force}=FORCE  || return 1

if [[ $# -eq 0 ]]; then
    echo No arguments found, aborting...
    exit 1
fi

for arg in "${@}"; do
    SOURCE="${CONF}/${arg}"
    if [[ ! -e ${SOURCE} ]]; then
        echo "${SOURCE}" doesn\'t exist, aborting...
        exit 1
    fi

    TARGET="${HOME}/${arg}"
    if (( $#FORCE )); then
        rm -rf "${TARGET}"
    elif [[ -e ${TARGET} ]]; then
        echo "${TARGET}" already exists, and removal isn\'t forced, aborting...
        exit 1
    fi

    ln -s "${SOURCE}" "${TARGET}"
done
