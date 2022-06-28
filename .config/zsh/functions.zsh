command pyenv rehash 2>/dev/null
pyenv() {
  local command
  command="${1:-}"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  rehash|shell)
    eval "$(pyenv "sh-$command" "$@")";;
  *)
    command pyenv "$command" "$@";;
  esac
}

function show_term_colours {
	tput setaf 0
	echo -e "Black"
	tput bold
	echo -e "Black bold"
	tput sgr0
	tput setaf 1
	echo -e "Red"
	tput bold
	echo -e "Red bold"
	tput sgr0
	tput setaf 2
	echo -e "Green"
	tput bold
	echo -e "Green bold"
	tput sgr0
	tput setaf 3
	echo -e "Yellow"
	tput bold
	echo -e "Yellow bold"
	tput sgr0
	tput setaf 4
	echo -e "Blue"
	tput bold
	echo -e "Blue bold"
	tput sgr0
	tput setaf 5
	echo -e "Magenta"
	tput bold
	echo -e "Magenta bold"
	tput sgr0
	tput setaf 6
	echo -e "Cyan"
	tput bold
	echo -e "Cyan bold"
	tput sgr0
	tput setaf 7
	echo -e "White"
	tput bold
	echo -e "White bold"
	tput sgr0
}

function pb {
	curl -F 'f:1=<-' ix.io
}

function clc {
	printf "$(tail -n2 ~/.zsh_history | head -n1)" | xsel -b
}


function docker_supernuke {
	docker system prune -af
	docker container rm -f $(docker container ls -aq)
	docker image rm -f $(docker image ls -aq)
	docker volume rm -f $(docker volume ls -q)
	docker network rm $(docker network ls -q)
}

function ws {
	if [[ ! -s $1 ]]; then
		return 0
	fi
	if [[ $(tail -c 1 $1 | wc -l) -eq 0 ]]; then
		echo >> $1
	elif [[ $(tail -c 2 $1 | head -c 1 | wc -l) -eq 1 ]]; then
		while [[ $(tail -c 2 $1 | head -c 1 | wc -l) -eq 1 ]]; do
			truncate -s -1 $1
		done
	fi
}

function inenv {
	local VAR_NAME
	for file in "$@"; do
		while read line; do
			if [[ $line != '#'* ]]; then
				VAR_NAME=$(echo $line | cut -d= -f1)
				if [[ -n "${VAR_NAME+1}" ]]; then
					export _OLD_${VAR_NAME}=${(P)VAR_NAME}
				fi
				export ${(e)line}
			fi
		done < $file
	done
}

function outenv {
	local VAR_NAME
	local TEMP_NAME
	for file in "$@"; do
		while read line; do
			if [[ $line != '#'* ]]; then
				VAR_NAME=$(echo $line | cut -d= -f1)
				TEMP_NAME=_OLD_${VAR_NAME}
				if [[ -n "${TEMP_NAME+1}" ]]; then
					export ${VAR_NAME}=${(P)TEMP_NAME}
				else
					unset VAR_NAME
				fi
				unset $_OLD_${VAR_NAME}
			fi
		done < $file
	done
}

function mkvenv {
	local OPTIONS=iep:
	local LONG_OPTS=independent,environ-only,python:
    local GET_OPT=getopt
    if [[ $(uname) == 'Darwin' ]]; then
        GET_OPT=/opt/homebrew/opt/gnu-getopt/bin/getopt
        if [[ !  -r $GETOPT ]]; then
            GET_OPT=/usr/local/opt/gnu-getopt/bin/getopt
        fi
    fi
	local PARSED=$($GET_OPT --options=$OPTIONS --longoptions=$LONG_OPTS --name "$0" -- "$@")
	eval set -- "$PARSED"

	local VENV_BASE=~/.local/share/virtualenvs
	local ASSOCIATED=true
	local PYTHON_VENV=true
	local VENV_NAME=${PWD##*/}
	local PYTHON
	while true; do
		case "$1" in
			-i|--independent)
				ASSOCIATED=false
				shift
				;;
			-e|--environ-only)
				PYTHON_VENV=false
				shift
				;;
			-p|--python)
				PYTHON="$2"
				shift 2
				;;
			--)
				shift
				break
				;;
		esac
	done

	if [[ $# -gt 1 ]]; then
		echo Ambiguous venv name, aborting...
		return 1
	fi

	if [[ $# -eq 1 ]]; then
		VENV_NAME=$1
	fi

	local VENV_DIR=${VENV_BASE}/${VENV_NAME}
	if [[ -d ${VENV_DIR} ]]; then
		echo Virtualenv ${1} already exist, aborting...
		return 1
	fi
	if ( ${PYTHON_VENV} ); then
		if [ -z "${PYTHON}" ]; then
			python -m venv ${VENV_DIR}
		else
			virtualenv ${VENV_DIR} -p ${PYTHON}
		fi
	else
		mkdir -p ${VENV_DIR}
	fi
	if ( ${ASSOCIATED} ); then
		echo ${PWD} >> ${VENV_DIR}/.project
	fi
	avenv ${VENV_NAME}
	if ( ${PYTHON_VENV} ); then
		pip install --upgrade pip wheel setuptools
	fi
}

function rmvenv {
	local VENV_BASE=~/.local/share/virtualenvs
	for VENV_NAME in $@; do
		local VENV_DIR=${VENV_BASE}/${VENV_NAME}
		if [[ ! -d ${VENV_DIR} ]]; then
			echo Virtualenv ${1} doesn\'t exist, aborting...
			return 1
		fi
		if [[ -w ${VENV_DIR} ]]; then
			rm -rf ${VENV_DIR}
		fi
	done
}

function avenv {
	if [[ -n "${VIRTUAL_ENV+1}" ]]; then
		dvenv
	fi
	local VENV_BASE=~/.local/share/virtualenvs
	local VENV_DIR=${VENV_BASE}/${1}
	if [[ ! -d ${VENV_DIR} ]]; then
		echo Virtualenv ${1} doesn\'t exist, aborting...
		return 1
	fi
	if [[ -r ${VENV_DIR}/.project ]]; then
		cd "$(cat ${VENV_DIR}/.project)"
		if [[ -r $(cat ${VENV_DIR}/.project)/.environ ]]; then
			inenv $(cat ${VENV_DIR}/.project)/.environ
		fi
	fi

	if [[ -r ${VENV_DIR}/bin/activate ]]; then
		. ${VENV_DIR}/bin/activate
	fi
}

function dvenv {
	if [[ -r ${VIRTUAL_ENV}/.project ]]; then
		if [[ -r $(cat ${VIRTUAL_ENV}/.project)/.environ ]]; then
			outenv $(cat ${VIRTUAL_ENV}/.project)/.environ
		fi
	fi

	deactivate
}

function add_to_path {
	local OPTIONS=p
	local LONG_OPTS=prepend
    local GET_OPT=getopt
    if [[ $(uname) == 'Darwin' ]]; then
        GET_OPT=/opt/homebrew/opt/gnu-getopt/bin/getopt
        if [[ !  -r $GETOPT ]]; then
            GET_OPT=/usr/local/opt/gnu-getopt/bin/getopt
        fi
    fi
	local PARSED=$($GET_OPT --options=$OPTIONS --longoptions=$LONG_OPTS --name "$0" -- "$@")
	eval set -- "$PARSED"

	local PREPEND=false
	while true; do
		case "$1" in
			-p|--prepend)
				PREPEND=true
				shift
				;;
			--)
				shift
				break
				;;
		esac
	done

	if [[ $# -gt 1 ]]; then
		echo Only one directory allowed, aborting...
		return 1
	fi

	if [[ -d $1 ]]; then
		if [[ ${path[(i)$1]} -gt ${#path} ]]; then
			if ( $PREPEND ); then
				export PATH=$1:$PATH
			else
				export PATH=$PATH:$1
			fi
		fi
	fi
}
