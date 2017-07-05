alias emacs="emacs -nw"
alias gemacs="\emacs"
if [[ $(uname) == 'Darwin' ]]; then
	alias ls="gls --color --group-directories-first"
else
	alias ls="ls --color --group-directories-first"
fi
alias la="ls -A"
alias ll="ls -lG"
alias llh="ls -lGh"
alias lla="ls -lGA"
alias llah="ls -lGAh"
alias extip="curl ipinfo.io/ip"
alias manage="python manage.py"
alias dj_server="python manage.py runserver_plus"
alias dj_shell="python manage.py shell_plus"
alias dj_celery="celery worker -c 8 -l info"
alias grep="grep --color=auto"
alias pypi_upload="python setup.py sdist --formats=gztar,zip bdist_wheel upload"
