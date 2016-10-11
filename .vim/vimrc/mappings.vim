" mappings
let mapleader = '\'

" make yank work like C & D
nnoremap Y y$

" select pasted text
nnoremap gp `[V`]

" yank entire buffer to clipboard
nnoremap ya ggVG"*y

" continuous indent in visual mode
vmap < <gv
vmap > >gv

" easy window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" scroll through buffers
:nnoremap <C-n> :bnext<CR>
:nnoremap <C-p> :bprevious<CR>

" plugins
vmap <leader>c :TComment<CR>
map <leader>t :NERDTreeToggle<CR>
" fzf
map <leader>f :Files<CR>

" unmap surround weirdness
let g:surround_no_insert_mappings=1

" folding
nnoremap <Space> za

" disable ex mode
map Q <Nop>
