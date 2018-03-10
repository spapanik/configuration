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

function proj {
	BASE_DIR=~/.config/projects
	mkdir -p ${BASE_DIR}
	CREATE=false
	ACTIVATE=true
	CD=true
	NAME=${PWD##*/}
	while getopts acgn: opt; do
		case $opt in
			c)
				CREATE=true;;
			d)
				ACTIVATE=false;;
			n)
				NAME=${OPTARG};;
			s)
				CD=false;;
		esac
	done
	PROJ_FILE=${BASE_DIR}/${NAME}
	if ( ${CREATE} ); then
		echo ${PWD} > ${PROJ_FILE}
		echo $(pipenv --venv) >> ${PROJ_FILE}
		return 0
	fi
	if ( ${CD} ); then
		cd $(sed -n '1p' ${PROJ_FILE})
	fi
	if ( ${ACTIVATE} ); then
		. $(sed -n '2p' ${PROJ_FILE})/bin/activate
	fi
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
