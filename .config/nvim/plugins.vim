" ALE
let g:ale_sign_column_always = 1
let g:ale_sign_error = '🔴'
let g:ale_sign_warning = '⚠'
let g:ale_sign_info = 'i'
let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace']}
let g:ale_fixers.python = ['black']
let g:ale_fixers.rust = ['rustfmt']

" autopairs
let g:AutoPairsMapCR=0

" deoplete
let g:deoplete#enable_at_startup = 1
call deoplete#custom#source('LanguageClient', 'min_pattern_length', 2)

" nerdtree
let NERDTreeIgnore=['\.pyc$','\.pyo$','__pycache__','\.o$']

" LanguageClient-neovim
let g:LanguageClient_diagnosticsEnable = 0
let g:LanguageClient_serverCommands = {}
let g:LanguageClient_serverCommands.c = ['clangd']
let g:LanguageClient_serverCommands.cpp = ['clangd']
let g:LanguageClient_serverCommands.python = ['pyls']
let g:LanguageClient_serverCommands.rust = ['rustup', 'run', 'stable', 'rls']

" suda
let g:suda_smart_edit = 1

" supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

" vim-airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" omnicompletion
let g:loaded_sql_completion = 0
let g:omni_sql_no_default_maps = 1

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

" vim-airline-themes
let g:airline_theme='solarized'

" vim-lsp
let g:lsp_diagnostics_enabled = 0
