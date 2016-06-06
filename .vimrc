" vundle start
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'blueshirts/darcula'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'jiangmiao/auto-pairs'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'majutsushi/tagbar'
Plugin 'davidhalter/jedi-vim'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'ervandew/supertab'
Plugin 'lervag/vimtex'
Plugin 'moll/vim-bbye'
filetype plugin indent on
"vundle end

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
color darcula

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
source $HOME/.vim/remaps.vim

if filereadable($HOME . "/.vim/local.vim")
     source $HOME/.vim/local.vim
endif
