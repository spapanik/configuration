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

function show_unicode_support {
    echo "red dot: 🔴"
    echo "greek: ιίϊΐ"
    echo "cjk: 조선글漢嗰"
    echo "cyrillic: Ж ж"
    echo "smiley: 🙂"
    echo "canadian flag: 🇨🇦"
    echo "pride flag: 🏳️‍🌈"
    echo "party head: 🥳"
    echo "star-struck: 🤩"
    echo "guide dog: 🦮"
}

function show_commit_emojis {
    echo "🎉 Initial commit"
    echo "🚀 Deployment"
    echo "🔖 Version change"
    echo "📚 Documentation"
    echo "🐛 Bugfix"
    echo "🔧 Configuration"
    echo "♻️ Refactor"
    echo "🎨 Styling"
    echo "🔒 Security"
    echo "🚧 Work in progress"
    echo "👷 CI/CD"
    echo "🔬 Tests"
    echo "🌍 I18n"
    echo "📝 Typo"
    echo "⏫ Upgrade dependencies"
    echo "🧹 Remove code"
    echo "🚫 Deprecation"
    echo "✨ Add functionality"
    echo "🔄 Change functionality"
}

function docker_supernuke {
    local RUNNER=
    local RUN_AS_SUDO
    zmodload zsh/zutil
    zparseopts -D -F -K -- {s,-run-as-sudo}=RUN_AS_SUDO  || return 1

    if [[ $# -gt 0 ]]; then
        echo Unexpected arguments, aborting...
        return 1
    fi

    if (( $#RUN_AS_SUDO )); then
        RUNNER=sudo
    fi

    echo "Removing containers..."
    for id in $(${RUNNER} docker container ls -aq); do
        ${RUNNER} docker container rm -f ${id}
    done

    echo "Removing images..."
    for id in $(${RUNNER} docker image ls -aq); do
        ${RUNNER} docker image rm -f ${id}
    done

    echo "Removing volumes..."
    for id in $(${RUNNER} docker volume ls -q); do
        ${RUNNER} docker volume rm -f ${id}
    done

    echo "Removing networks..."
    for id in $(${RUNNER} docker network ls -q); do
        ${RUNNER} docker network rm ${id}
    done

    echo "Pruning the system..."
    ${RUNNER} docker system prune -af
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

function fh {
    local cmd
    cmd=$(fc -ln 1 | tail -r | fzf)
    if [[ -n $cmd ]]; then
        echo Executing '`'"$cmd"'`'
        eval "$cmd"
        print -s "$cmd"
    fi
}

function add_to_path {
    local PREPEND
    zmodload zsh/zutil
    zparseopts -D -F -K -- {p,-prepend}=PREPEND  || return 1

    if [[ $# -gt 1 ]]; then
        echo Only one directory allowed, aborting...
        return 1
    fi

    if [[ $# -lt 1 ]]; then
        echo Directory undefined, aborting...
        return 1
    fi

    if [[ ${path[(i)$1]} -gt ${#path} ]]; then
        if (( $#PREPEND )); then
            export PATH="$1":"$PATH"
        else
            export PATH="$PATH":"$1"
        fi
    fi
}

function add_to_fpath {
    local PREPEND
    zmodload zsh/zutil
    zparseopts -D -F -K -- {p,-prepend}=PREPEND  || return 1

    if [[ $# -gt 1 ]]; then
        echo Only one directory allowed, aborting...
        return 1
    fi

    if [[ $# -lt 1 ]]; then
        echo Directory undefined, aborting...
        return 1
    fi

    if [[ ${fpath[(i)$1]} -gt ${#fpath} ]]; then
        if (( $#PREPEND )); then
            export FPATH="$1":"$FPATH"
        else
            export FPATH="$FPATH":"$1"
        fi
    fi
}
