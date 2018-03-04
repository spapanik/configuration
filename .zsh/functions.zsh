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

function cvenv {
	BASE_DIR=~/.virtualenvs
	CD=false
	VENV_DIR=${BASE_DIR}/${PWD##*/}
	PYTHON=$(which python)
	while getopts an:p: opt; do
		case $opt in
			a)
				CD=true;;
			n)
				VENV_DIR=${BASE_DIR}/${OPTARG};;
			p)
				PYTHON=${OPTARG};;
		esac
	done
	virtualenv ${VENV_DIR} -p ${PYTHON}
	if ( ${CD} ); then
		echo ${PWD} >> ${VENV_DIR}/.project
	fi
}

function avenv {
	VENV_DIR=~/.virtualenvs/${1}
	echo ${VENV_DIR}
	if [[ -r ${VENV_DIR}/.project ]]; then
		cd $(cat ${VENV_DIR}/.project)
	fi
	. ${VENV_DIR}/bin/activate
}
