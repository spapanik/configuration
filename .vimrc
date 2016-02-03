set history=700
"syntax"

syntax on
filetype plugin on

"UI"
set ruler
set number
set wildmenu
set background=dark
set t_Co=256
color molokai

"tabs"
set smarttab
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

"indentation"
filetype indent on
set ai
set si

set autoread
set lazyredraw
set magic
set noerrorbells
set novisualbell
set encoding=utf8

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

"remapping keys"
"move lines"
nnoremap <M-S-Up> :m .-2<CR>==
nnoremap <M-S-Down> :m .+1<CR>==
inoremap <M-S-Up> <Esc>:m .-2<CR>==gi
inoremap <M-S-Down> <Esc>:m .+1<CR>==gi
vnoremap <M-S-Up> :m '<-2<CR>gv=gv
vnoremap <M-S-Down> :m '>+1<CR>gv=gv
