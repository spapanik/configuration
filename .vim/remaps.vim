"move lines
nnoremap <C-up>   :m .-2<CR>==
nnoremap <C-down> :m .+1<CR>==
inoremap <C-up>   <Esc>:m .-2<CR>==gi
inoremap <C-down> <Esc>:m .+1<CR>==gi
vnoremap <C-up>   :m '<-2<CR>gv=gv
vnoremap <C-down> :m '>+1<CR>gv=gv

"move cursor
nnoremap <M-S-up>   gk
nnoremap <M-S-down> gj
inoremap <M-S-up>   <C-O>gk
inoremap <M-S-down> <C-O>gj
vnoremap <M-S-up>   gk
vnoremap <M-S-down> gj

"move in splits
nnoremap <S-left>  <C-w><C-h>
nnoremap <S-down>  <C-w><C-j>
nnoremap <S-up>    <C-w><C-k>
nnoremap <S-right> <C-w><C-l>
inoremap <S-left>  <Esc><C-w><C-h>
inoremap <S-down>  <Esc><C-w><C-j>
inoremap <S-up>    <Esc><C-w><C-k>
inoremap <S-right> <Esc><C-w><C-l>
vnoremap <S-left>  <Esc><C-w><C-h>
vnoremap <S-down>  <Esc><C-w><C-j>
vnoremap <S-up>    <Esc><C-w><C-k>
vnoremap <S-right> <Esc><C-w><C-l>

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
