augroup filetypedetect
    au BufRead,BufNewFile *.tmux set filetype=tmux
    au BufRead,BufNewFile *.ssh set filetype=sshconfig
augroup END
