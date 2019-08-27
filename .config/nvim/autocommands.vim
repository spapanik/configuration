augroup filetypedetect
    au BufRead,BufNewFile *.tmux set filetype=tmux
    au BufRead,BufNewFile *.ssh set filetype=sshconfig
    au BufRead,BufNewFile *.git set filetype=gitconfig
augroup END
