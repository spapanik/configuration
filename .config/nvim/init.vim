set nocompatible  " no vi complatibility

" install plugins
call plug#begin()
Plug 'mileszs/ack.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'NLKNguyen/papercolor-theme'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'moll/vim-bbye'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
runtime local.plug.vim
call plug#end()

" source config
runtime core.vim
runtime plugins.vim
runtime functions.vim
runtime remaps.vim

" source local config
runtime local.vim

" source project config
if filereadable(".vimlocal")
	source .vimlocal
endif
