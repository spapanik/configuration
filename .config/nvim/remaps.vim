" space as leader
let mapleader = "\<Space>"

" easier reach escape
map <C-q> <Esc>:noh<CR>
imap <C-q> <Esc>`^:noh<CR>

" move to beginning/end
nnoremap <C-k> 0
inoremap <C-k> <C-o>0
vnoremap <C-k> 0
nnoremap <M-k> $
inoremap <M-k> <C-o>$
vnoremap <M-k> $

" bigger movement
nnoremap <C-up>    {
nnoremap <C-down>  }
nnoremap <C-left>  b
nnoremap <C-right> w
inoremap <C-up>    <C-o>{
inoremap <C-down>  <C-o>}
inoremap <C-left>  <C-o>b
inoremap <C-right> <C-o>w
vnoremap <C-up>    {
vnoremap <C-down>  }
vnoremap <C-left>  b
vnoremap <C-right> w

" move in buffer
nnoremap <M-PageUp>   :bp<CR>
nnoremap <M-PageDown> :bn<CR>
inoremap <M-PageUp>   <Esc>:bp<CR>
inoremap <M-PageDown> <Esc>:bn<CR>
vnoremap <M-PageUp>   <Esc>:bp<CR>
vnoremap <M-PageDown> <Esc>:bn<CR>

" visual line movement
nnoremap <C-PageUp>   gk
nnoremap <C-PageDown> gj
inoremap <C-PageUp>   <C-o>gk
inoremap <C-PageDown> <C-o>gj
vnoremap <C-PageUp>   gk
vnoremap <C-PageDown> gj

" move lines
nnoremap <M-S-up>   :m .-2<CR>==
nnoremap <M-S-down> :m .+1<CR>==
inoremap <M-S-up>   <Esc>:m .-2<CR>==gi
inoremap <M-S-down> <Esc>:m .+1<CR>==gi
vnoremap <M-S-up>   :m '<-2<CR>gv=gv
vnoremap <M-S-down> :m '>+1<CR>gv=gv

" select with shift
nmap <S-up>      v<up>
nmap <S-down>    v<down>
nmap <S-left>    v<left>
nmap <S-right>   v<right>
vmap <S-up>      <up>
vmap <S-down>    <down>
vmap <S-left>    <left>
vmap <S-right>   <right>
imap <S-up>      <Esc>`^v<up>
imap <S-down>    <Esc>`^v<down>
imap <S-left>    <Esc>`^v<left>
imap <S-right>   <Esc>`^v<right>

" bigger selects
nmap <C-S-up>    v<C-up>
nmap <C-S-down>  v<C-down>
nmap <C-S-left>  v<C-left>
nmap <C-S-right> v<C-right>
vmap <C-S-up>    <C-up>
vmap <C-S-down>  <C-down>
vmap <C-S-left>  <C-left>
vmap <C-S-right> <C-right>
imap <C-S-up>    <Esc>`^v<C-up>
imap <C-S-down>  <Esc>`^v<C-down>
imap <C-S-left>  <Esc>`^v<C-left>
imap <C-S-right> <Esc>`^v<C-right>

" move in splits
nnoremap <M-left>  <C-w><C-h>
nnoremap <M-down>  <C-w><C-j>
nnoremap <M-up>    <C-w><C-k>
nnoremap <M-right> <C-w><C-l>
inoremap <M-left>  <Esc><C-w><C-h>
inoremap <M-down>  <Esc><C-w><C-j>
inoremap <M-up>    <Esc><C-w><C-k>
inoremap <M-right> <Esc><C-w><C-l>
vnoremap <M-left>  <Esc><C-w><C-h>
vnoremap <M-down>  <Esc><C-w><C-j>
vnoremap <M-up>    <Esc><C-w><C-k>
vnoremap <M-right> <Esc><C-w><C-l>

" delete and paste
vnoremap <leader>d "_d
nnoremap <leader>p "0p
nnoremap <leader>P "0P
vnoremap <C-c> "+y

" comments
nmap <C-_> gcc
imap <C-_> <C-o>gcc
vmap <C-_> gc

" yank without cursor moving
vmap y ygv<Esc>

" save
nnoremap <silent> <C-s> :update<CR>
inoremap <silent> <C-s> <Esc>`^:update<CR>
vnoremap <silent> <C-s> <Esc>:update<CR>

" save and quit
nnoremap <silent> <M-s> :wq<CR>
inoremap <silent> <M-s> <Esc>:wq<CR>
vnoremap <silent> <M-s> <Esc>:wq<CR>

" ALE
nnoremap <silent> <F8> :ALEFix<CR>
inoremap <silent> <F8> <Esc>:ALEFix<CR>
vnoremap <silent> <F8> <Esc>:ALEFix<CR>

" bbye
nnoremap <silent> <C-l> :Bdelete<CR>
inoremap <silent> <C-l> <Esc>:Bdelete<CR>
vnoremap <silent> <C-l> <Esc>:Bdelete<CR>

" fzf
nnoremap <C-f> :Files<CR>
nnoremap <M-f> :Rg<CR>

" LanguageClient-neovim
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap gd :call LanguageClient#textDocument_definition()<CR>
nnoremap gr :call LanguageClient#textDocument_references()<CR>
nnoremap <F2> :call LanguageClient#textDocument_rename()<CR>
nnoremap <F4> :call LanguageClient#textDocument_hover()<CR>

" NERDTree
nnoremap <silent> <F3> :NERDTreeToggle<CR>
inoremap <silent> <F3> <Esc>:NERDTreeToggle<CR>
vnoremap <silent> <F3> <Esc>:NERDTreeToggle<CR>
