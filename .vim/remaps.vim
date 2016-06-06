"esc
inoremap <C-l> <Esc>
vnoremap <C-l> <Esc>

"yank without cursor moving
vmap y ygv<Esc>

"visual line movement
nnoremap <up>   gk
nnoremap <down> gj
inoremap <up>   <C-O>gk
inoremap <down> <C-O>gj
vnoremap <up>   gk
vnoremap <down> gj

"visual line movement
nnoremap <C-up>   {
nnoremap <C-down> }
inoremap <C-up>   <C-O>{
inoremap <C-down> <C-O>}
vnoremap <C-up>   {
vnoremap <C-down> }

"move lines
nnoremap <M-S-up>   :m .-2<CR>==
nnoremap <M-S-down> :m .+1<CR>==
inoremap <M-S-up>   <Esc>:m .-2<CR>==gi
inoremap <M-S-down> <Esc>:m .+1<CR>==gi
vnoremap <M-S-up>   :m '<-2<CR>gv=gv
vnoremap <M-S-down> :m '>+1<CR>gv=gv

"select with shift
nmap <S-up>      v<up>
nmap <S-down>    v<down>
nmap <S-left>    v<left>
nmap <S-right>   v<right>
nmap <C-S-up>    v<C-up>
nmap <C-S-down>  v<C-down>
nmap <C-S-left>  v<C-left>
nmap <C-S-right> v<C-right>
vmap <S-up>      <up>
vmap <S-down>    <down>
vmap <S-left>    <left>
vmap <S-right>   <right>
vmap <C-S-up>    <C-up>
vmap <C-S-down>  <C-down>
vmap <C-S-left>  <C-left>
vmap <C-S-right> <C-right>
imap <S-up>      <Esc>v<up>
imap <S-down>    <Esc>v<down>
imap <S-left>    <Esc>v<left>
imap <S-right>   <Esc>v<right>
imap <C-S-up>    <Esc>v<C-up>
imap <C-S-down>  <Esc>v<C-down>
imap <C-S-left>  <Esc>v<C-left>
imap <C-S-right> <Esc>v<C-right>

"move in splits
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

"delete and paste
nnoremap <leader>d "_d
nnoremap <leader>D "_D
vnoremap <leader>d "_d
vnoremap <leader>p "_dP

"save
nnoremap <silent> <C-s> :update<CR>
inoremap <silent> <C-s> <Esc>:update<CR>
vnoremap <silent> <C-s> <Esc>:update<CR>

"quit
nnoremap <silent> <C-q> :Bclose<CR>
inoremap <silent> <C-q> <Esc>:Bclose<CR>
vnoremap <silent> <C-q> <Esc>:Bclose<CR>

"taglist
nnoremap <silent> <F8> :TagbarToggle<CR>
inoremap <silent> <F8> <C-O>:TagbarToggle<CR>
vnoremap <silent> <F8> <C-C>:TagbarToggle<CR>

"NERDTree
nnoremap <silent> <F3> :NERDTreeToggle<CR>
inoremap <silent> <F3> <Esc>:NERDTreeToggle<CR>
vnoremap <silent> <F3> <Esc>:NERDTreeToggle<CR>

"syntax check
nnoremap <silent> <F7> :SyntasticCheck<CR>
inoremap <silent> <F7> <Esc>:SyntasticCheck<CR>
vnoremap <silent> <F7> <Esc>:SyntasticCheck<CR>
