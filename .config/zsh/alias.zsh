alias mc="mc -x"
alias mcr="\mc"
alias e="$EDITOR"
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
alias extip="https ipinfo.io/ip"
