set nocompatible  " no vi complatibility

" install plugins
call plug#begin()
" Main plugins
Plug 'w0rp/ale'
Plug 'jiangmiao/auto-pairs'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --bin'}
Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}
Plug 'scrooloose/nerdtree'
Plug 'NLKNguyen/papercolor-theme'
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'vim-airline/vim-airline'
Plug 'moll/vim-bbye'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

" Plugin extras
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'honza/vim-snippets'
runtime local.plug.vim
call plug#end()

" source config
runtime core.vim
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
