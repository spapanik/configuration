set nocompatible  " no vi complatibility

" install plugins
call plug#begin()
runtime plug.vim
runtime local.plug.vim
call plug#end()

" source config
runtime core.vim
runtime plugins.vim
runtime autocommands.vim
runtime functions.vim
runtime commands.vim
runtime remaps.vim

" source local config
runtime local.vim

" source project config
if filereadable(".local.vim")
    source .local.vim
endif
