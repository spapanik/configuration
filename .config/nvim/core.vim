" syntax
filetype plugin indent on
syntax on

" choose background
if filereadable($HOME . "/.light")
	set background=light
else
	set background=dark
endif

set history=700
set backspace=indent,eol,start
set clipboard+=unnamedplus
set mouse=a
set number
set tabstop=4
set shiftwidth=4
set softtabstop=4
set pastetoggle=<F12>
set ignorecase
set smartcase
set autoindent
set smartindent
set list
set showbreak=↪\
set listchars=tab:»\ ,trail:·,nbsp:␣
set splitright
set splitbelow
set spelllang=en_gb
set foldmethod=syntax
set nofoldenable
set autoread
set lazyredraw
set magic
set notimeout
set suffixesadd=.js,.tex
set whichwrap+=<,>,[,]
set wildignore+=*.pyc,*.pyo,*/__pycache__/*,*.o,*/out/*

" colorscheme
color solarized
