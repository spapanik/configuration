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

set incsearch
set autoread
set lazyredraw
set magic
set noerrorbells
set novisualbell
set encoding=utf8

"remapping keys"
"move lines"
nnoremap <A-Up> :m .-2<CR>==
nnoremap <A-Down> :m .+1<CR>==
inoremap <A-Up> <Esc>:m .-2<CR>==gi
inoremap <A-Down> <Esc>:m .+1<CR>==gi
vnoremap <A-Up> :m '<-2<CR>gv=gv
vnoremap <A-Down> :m '>+1<CR>gv=gv
