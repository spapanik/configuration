" no vi complatibility
set nocompatible

" install plugins
call plug#begin('~/.config/nvim/plugged')
 Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
 Plug 'blueshirts/darcula'
 Plug 'ctrlpvim/ctrlp.vim'
 Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
 Plug 'scrooloose/syntastic'
 Plug 'scrooloose/nerdtree'
 Plug 'tpope/vim-commentary'
 Plug 'tpope/vim-surround'
 Plug 'tpope/vim-fugitive'
 Plug 'jiangmiao/auto-pairs'
 Plug 'majutsushi/tagbar'
 Plug 'davidhalter/jedi-vim'
 Plug 'jlanzarotta/bufexplorer'
 Plug 'ervandew/supertab'
 Plug 'lervag/vimtex'
 Plug 'moll/vim-bbye'
 Plug 'terryma/vim-multiple-cursors'
 Plug 'tmhedberg/SimpylFold'
call plug#end()

set history=700
"syntax
syntax on
filetype plugin indent on

"UI
set ruler
set number
set wildmenu
set background=dark
set t_Co=256
color darcula

"tabs
set smarttab
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set pastetoggle=<F12>

"case insensitive if lowercase
set ignorecase
set smartcase

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
let g:jedi#use_tabs_not_buffers=0
let g:jedi#show_call_signatures="2"

"syntax highlighting
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': []  }

"airline
set laststatus=2
let g:airline_theme='powerlineish'
let g:airline_powerline_fonts = 1

"spell
set spelllang=en_gb

"no mouse
set mouse=

"folding
set foldmethod=syntax
set nofoldenable

"python folding
autocmd BufWinEnter *.py setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr
autocmd BufWinLeave *.py setlocal foldexpr< foldmethod<
autocmd FileType python setlocal foldlevel=2

set noincsearch
set nohlsearch
set autoread
set lazyredraw
set magic
set noerrorbells
set novisualbell
set encoding=utf8
set notimeout
set omnifunc=syntaxcomplete#Complete
let g:SuperTabDefaultCompletionType = "<C-x><C-o>"
set suffixesadd=.js,.tex
set whichwrap+=<,>,[,]

"UltiSnip config
" Trigger configuration. Do not use <tab> if you use YouCompleteMe
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<C-b>"
let g:UltiSnipsJumpBackwardTrigger="<C-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

let NERDTreeIgnore=['\.pyc$','\.pyo$','__pycache__']
set wildignore+=*.pyc,*.pyo,*/__pycache__/*

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

"commands
command Ssudo call SudoSaveFile()

function! SudoSaveFile() abort
  execute (has('gui_running') ? '' : 'silent') 'write !env SUDO_EDITOR=tee sudo -e % >/dev/null'
  let &modified = v:shell_error
endfunction

"remapping keys
source $HOME/~.config/nvim/remaps.vim

if filereadable($HOME . "/.config/nvim/local.vim")
     source $HOME/.config/nvim/local.vim
endif
