set history=700
"syntax
syntax on
filetype plugin on

"UI
set ruler
set number
set wildmenu
set background=dark
set t_Co=256
color molokai-stema

"tabs
set smarttab
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set pastetoggle=<F12>

"indentation
filetype indent on
set ai
set si

"problematic characters
set list
set listchars=tab:»\ ,trail:·

"sane split
set splitright
set splitbelow

"jedi options
let g:jedi#popup_on_dot=0
let g:jedi#use_tabs_not_buffers=0
let g:jedi#show_call_signatures="2"

"syntax highlighting
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': []  }

"spell
set spelllang=en_gb

"folding
set foldmethod=syntax
set nofoldenable

set noincsearch
set nohlsearch
set autoread
set lazyredraw
set magic
set noerrorbells
set novisualbell
set encoding=utf8
set notimeout
set omnifunc=syntaxcomplete
set suffixesadd=.js,.tex

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

"commands
command Ssudo silent w !sudo tee  % >/dev/null

"remapping keys
source $HOME/.vim/remaps.vim

if filereadable($HOME . "/.vim/local.vim")
     source $HOME/.vim/local.vim
 endif
