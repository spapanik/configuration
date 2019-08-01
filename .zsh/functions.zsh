function pb {
	curl -F 'f:1=<-' ix.io
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

function pypiver {
	sed -i "/^version =/c\version = \"$1\"" pyproject.toml
	sed -i "/^__version__/c\__version__ = \"$1\"" setup.py
	git add setup.py pyproject.toml
	git commit -m "Bump version"
	git tag -s v$1 -m v$1
	git push --follow-tags
}

function pypiup {
	pip install -U twine
	rm -rf build dist
	python setup.py sdist bdist_wheel
	twine upload dist/*
}

function inenv {
	local VAR_NAME
	for file in $@; do
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
	for file in $@; do
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
	local OPTIONS=ip:
	local LONGOPTS=independent,python:
	if [[ $(uname) == 'Darwin' ]]; then
		local GETOPT=/usr/local/opt/gnu-getopt/bin/getopt
	else
		local GETOPT=getopt
	fi
	local PARSED=$($GETOPT --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@")
	eval set -- "$PARSED"

	local VENV_BASE=~/.local/share/virtualenvs
	local ASSOCIATED=true
	local VENV_NAME=${PWD##*/}
	local PYTHON=$(which python)
	while true; do
		case "$1" in
			-i|--independent)
				ASSOCIATED=false
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
	virtualenv ${VENV_DIR} -p ${PYTHON}
	if ( ${ASSOCIATED} ); then
		echo ${PWD} >> ${VENV_DIR}/.project
	fi
	avenv ${VENV_NAME}
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

	. ${VENV_DIR}/bin/activate
}

function dvenv {
	if [[ -r ${VIRTUAL_ENV}/.project ]]; then
		if [[ -r $(cat ${VIRTUAL_ENV}/.project)/.environ ]]; then
			outenv $(cat ${VIRTUAL_ENV}/.project)/.environ
		fi
	fi

	deactivate
}
