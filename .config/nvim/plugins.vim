" ack.vim
let g:ackprg = 'rg --vimgrep'

" autopairs
let g:AutoPairsMapCR=0

" deoplete
let g:deoplete#enable_at_startup = 1
call deoplete#custom#source('LanguageClient', 'min_pattern_length', 2)

" nerdtree
let NERDTreeIgnore=['\.pyc$','\.pyo$','__pycache__','\.o$']

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

" LanguageClient-neovim
let g:LanguageClient_serverCommands = {}
let g:LanguageClient_serverCommands.python = ['/usr/bin/pyls']
let g:LanguageClient_serverCommands.rust = ['/usr/bin/rustup', 'run', 'stable', 'rls']
