augroup filetypedetect
    au BufRead,BufNewFile *.tmux set filetype=tmux
    au BufRead,BufNewFile *.ssh set filetype=sshconfig
    au BufRead,BufNewFile *.git set filetype=gitconfig
    au BufRead,BufNewFile *.cron set filetype=crontab
    autocmd FileType gitcommit setlocal spell
augroup END
