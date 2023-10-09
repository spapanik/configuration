alias mc="mc -x"
alias mcr="\mc"
if [[ -f ${HOME}/.editor && $(cat "${HOME}"/.editor) == "emacs" ]]; then
    alias e="emacs -nw"
else
    alias e="nvim"
fi
if [[ $(uname) == 'Darwin' ]]; then
    alias ls="gls --color=auto --group-directories-first -N"
else
    alias ls="ls --color=auto --group-directories-first -N"
fi
alias la="ls -A"
alias ll="ls -lG"
alias llh="ls -lGh"
alias lla="ls -lGA"
alias llah="ls -lGAh"
alias extip="curl ipinfo.io/ip"
