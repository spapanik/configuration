set nocompatible  " no vi complatibility

" install plugins
call plug#begin()
" Main plugins
Plug 'w0rp/ale'
Plug 'jiangmiao/auto-pairs'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
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
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'honza/vim-snippets'
runtime local.plug.vim
call plug#end()

" source config
runtime core.vim
runtime plugins.vim
runtime lsp.vim
runtime functions.vim
runtime commands.vim
runtime remaps.vim

" source local config
runtime local.vim

" source project config
if filereadable(".vimlocal")
	source .vimlocal
endif
