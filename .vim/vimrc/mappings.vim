" Mappings
let mapleader = ','
" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Toggle search highlighting
nmap ; :set invhlsearch<CR> 

" Change indent continuously
vmap < <gv
vmap > >gv

" Window navigation
map <leader><Left> h
map <leader><Right> l
map <leader><Up> k
map <leader><Down> j

" Plugins
map <leader>n :NERDTreeToggle<CR>
nmap <C-t> :CommandT<CR>

" Taglist
let tlist_php_settings = 'php;c:class;f:function'

