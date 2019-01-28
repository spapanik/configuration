set nocompatible  " no vi complatibility

" install plugins
call plug#begin()
" Main plugins
Plug 'jiangmiao/auto-pairs'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --bin'}
Plug 'scrooloose/nerdtree'
Plug 'NLKNguyen/papercolor-theme'
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'vim-airline/vim-airline'
Plug 'moll/vim-bbye'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'prabirshrestha/vim-lsp'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

" Plugin extras
Plug 'vim-airline/vim-airline-themes'
Plug 'honza/vim-snippets'
Plug 'junegunn/fzf.vim'
runtime local.plug.vim
call plug#end()

" source config
runtime core.vim
runtime lsp.vim
runtime plugins.vim
runtime functions.vim
runtime commands.vim
runtime remaps.vim

" source local config
runtime local.vim

" source project config
if filereadable(".vimlocal")
	source .vimlocal
endif
