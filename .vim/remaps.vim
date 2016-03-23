"move lines
nnoremap <C-Up> :m .-2<CR>==
nnoremap <C-Down> :m .+1<CR>==
inoremap <C-Up> <Esc>:m .-2<CR>==gi
inoremap <C-Down> <Esc>:m .+1<CR>==gi
vnoremap <C-Up> :m '<-2<CR>gv=gv
vnoremap <C-Down> :m '>+1<CR>gv=gv

"move cursor
nnoremap <M-S-up> gk
nnoremap <M-S-down> gj
inoremap <M-S-up> <C-O>gk
inoremap <M-S-down> <C-O>gj
vnoremap <M-S-up> gk
vnoremap <M-S-down> gj

"move in splits
nnoremap <C-h> <C-w><C-h>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>

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
