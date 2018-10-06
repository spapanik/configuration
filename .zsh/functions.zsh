function pb {
	curl -F "c=@${1:--}" https://ptpb.pw/
}

function inenv {
	if [[ -z "${_OLD_PATH+1}" ]]; then
		_OLD_PATH=${PATH}
		PATH=${1}:${PATH}
	else
		PATH=${1}:${_OLD_PATH}
	fi
}

function outenv {
	if [[ -z "${_OLD_PATH+1}" ]]; then
		return 1
	fi
	PATH=${_OLD_PATH}
	unset _OLD_PATH
}

function upypi {
	pip install -U twine
	rm -r build dist
	python setup.py sdist bdist_wheel
	twine upload dist/*
}

function cvenv {
	VENV_BASE=~/.local/share/virtualenvs
	CD=false
	VENV_DIR=${VENV_BASE}/${PWD##*/}
	PYTHON=$(which python)
	while getopts an:p: opt; do
		case $opt in
			a)
				CD=true;;
			n)
				VENV_DIR=${VENV_BASE}/${OPTARG};;
			p)
				PYTHON=${OPTARG};;
		esac
	done
	if [[ -d ${VENV_DIR} ]]; then
		echo Virtualenv ${1} already exist, aborting...
		unset VENV_BASE VENV_DIR CD PYTHON
		return 1
	fi
	virtualenv ${VENV_DIR} -p ${PYTHON}
	if ( ${CD} ); then
		echo ${PWD} >> ${VENV_DIR}/.project
	fi
	. ${VENV_DIR}/bin/activate
	unset VENV_BASE VENV_DIR CD PYTHON
}

function avenv {
	VENV_BASE=~/.local/share/virtualenvs
	VENV_DIR=${VENV_BASE}/${1}
	if [[ ! -d ${VENV_DIR} ]]; then
		echo Virtualenv ${1} doesn\'t exist, aborting...
		unset VENV_BASE VENV_DIR
		return 1
	fi
	if [[ -r ${VENV_DIR}/.project ]]; then
		cd $(cat ${VENV_DIR}/.project)
	fi
	. ${VENV_DIR}/bin/activate
	unset VENV_BASE VENV_DIR
}

function dvenv {
	VENV_BASE=~/.local/share/virtualenvs
	VENV_DIR=${VENV_BASE}/${1}
	if [[ ! -d ${VENV_DIR} ]]; then
		echo Virtualenv ${1} doesn\'t exist, aborting...
		unset VENV_BASE VENV_DIR
		return 1
	fi
	if [[ -w ${VENV_DIR} ]]; then
		rm -rf ${VENV_DIR}
	fi
	unset VENV_BASE VENV_DIR
}
