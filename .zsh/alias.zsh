alias enw="emacs -nw"
if [[ ! `uname` == 'Darwin' ]]; then
    alias ls="ls --color"
fi
alias la="ls -A"
alias ll="ls -lG"
alias llh="ls -lGh"
alias lla="ls -lGA"
alias llah="ls -lGAh"
alias manage="python manage.py"
alias dj_server="python manage.py runserver_plus"
alias dj_shell="python manage.py shell_plus"
alias dj_celery="celery worker -c 8 -l info"
alias grep="grep --color=auto"
alias pypi_upload="python setup.py sdist --formats=gztar,zip bdist_wheel upload"
