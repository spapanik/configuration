#!/usr/bin/env bash

OPTIONS=f
LONG_OPTIONS=force
GET_OPT=getopt
if [[ $(uname) == 'Darwin' ]]; then
    GET_OPT=/opt/homebrew/opt/gnu-getopt/bin/getopt
    if [[ ! -r GETOPT ]]; then
        GET_OPT=/usr/local/opt/gnu-getopt/bin/getopt
    fi
fi
PARSED=$($GET_OPT --options=$OPTIONS --longoptions=$LONG_OPTIONS --name "$0" -- "$@")
eval set -- "$PARSED"

FORCE=false
while true; do
    case "$1" in
        -f|--force)
            FORCE=true
            shift
            ;;
        --)
            shift
            break
            ;;
    esac
done

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
    if [[ ${FORCE} = true ]]; then
        rm -rf "${TARGET}"
    elif [[ -e ${TARGET} ]]; then
        echo "${TARGET}" already exists, and removal isn\'t forced, aborting...
        exit 1
    fi

    ln -s "${SOURCE}" "${TARGET}"
done
