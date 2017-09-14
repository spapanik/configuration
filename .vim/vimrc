" no vi complatibility
set nocompatible

" install plugins
call plug#begin('~/.vim/plugged')
	Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
	Plug 'NLKNguyen/papercolor-theme'
	Plug 'mileszs/ack.vim'
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
	Plug 'Rip-Rip/clang_complete'
	if filereadable($HOME . "/.vim/local_plugins.vim")
		source $HOME/.vim/local_plugins.vim
	endif
call plug#end()

set history=700
"fortran should be before syntax
let fortran_free_source=1
let fortran_more_precise=1

"syntax
syntax on
filetype plugin indent on

"use system clipboard
if !has('mac')
	 set clipboard=unnamedplus
endif

"UI
set ruler
set number
set wildmenu
set t_Co=256
if filereadable($HOME . "/.light")
	set background=light
else
	set background=dark
endif
color PaperColor

"tabs
set smarttab
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
set showbreak=↪\
set listchars=tab:»\ ,trail:·,nbsp:␣

"sane split
set splitright
set splitbelow

"jedi options
let g:jedi#completions_command="<C-x><C-o>"
let g:jedi#popup_on_dot=0
let g:jedi#popup_select_first=0
let g:jedi#use_tabs_not_buffers=0
let g:jedi#show_call_signatures="2"

"syntax highlighting
let g:syntastic_mode_map={'mode': 'passive', 'active_filetypes': [],'passive_filetypes': []}

"airline
set laststatus=2
let g:airline_theme='papercolor'
let g:airline_powerline_fonts=1

"spell
set spelllang=en_gb

"folding
set foldmethod=syntax
set nofoldenable

"project specific vimrc
set exrc
set secure

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
let g:SuperTabDefaultCompletionType="<C-x><C-o>"
set suffixesadd=.js,.tex
set whichwrap+=<,>,[,]

"UltiSnip config
" Trigger configuration. Do not use <tab> if you use YouCompleteMe
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<C-b>"
let g:UltiSnipsJumpBackwardTrigger="<C-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" fix <CR> with autopairs
let g:AutoPairsMapCR=0

" Ack to use ag
let g:ackprg = 'ag --vimgrep'

let NERDTreeIgnore=['\.pyc$','\.pyo$','__pycache__','\.o$','out']
set wildignore+=*.pyc,*.pyo,*/__pycache__/*,*.o,*/out/*

if &term =~ '256color'
	" disable Background Color Erase (BCE) so that color schemes
	" render properly when inside 256-color tmux and GNU screen.
	" see also http://snk.tuxfamily.org/log/vim-256color-bce.html
	set t_ut=
endif

"commands
command! Ssudo call SudoSaveFile()

function! SudoSaveFile() abort
	execute (has('gui_running') ? '' : 'silent') 'write !env SUDO_EDITOR=tee sudo -e % >/dev/null'
	let &modified = v:shell_error
endfunction

"remapping keys
source $HOME/.vim/remaps.vim

if filereadable($HOME . "/.vim/local.vim")
	source $HOME/.vim/local.vim
endif

if has('mac')
	set backspace=indent,eol,start
endif
