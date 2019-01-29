" ALE
let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace']}
let g:ale_fixers.python = ['black']
let g:ale_fixers.rust = ['rustfmt']

" asyncomplete
let g:asyncomplete_remove_duplicates = 1
let g:asyncomplete_smart_completion = 1
let g:asyncomplete_auto_popup = 1

" autopairs
let g:AutoPairsMapCR=0

" nerdtree
let NERDTreeIgnore=['\.pyc$','\.pyo$','__pycache__','\.o$']

" LanguageClient-neovim
let g:LanguageClient_serverCommands = {}
let g:LanguageClient_serverCommands.python = ['pyls']
let g:LanguageClient_serverCommands.rust = ['rustup', 'run', 'stable', 'rls']

" supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

" vim-airline
let g:airline_powerline_fonts=1

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

" vim-airline-themes
let g:airline_theme='papercolor'
