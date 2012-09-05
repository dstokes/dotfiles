" User Vim settings instead of vi
set nocompatible
call pathogen#infect()

filetype on
syntax enable
set hlsearch
set incsearch
set colorcolumn=80
set background=dark
colorscheme solarized

set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set number numberwidth=5
set autoindent smartindent
set nowrap
set ignorecase
set laststatus=2
set title

" Centralize backups & swap files
set directory=~/.vim/swp
set backupdir=~/.vim/backup

set listchars=tab:▸\ 
set list

" Highlight end-of-line whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * redraw!

" Toggle search highlighting
nmap ; :set invhlsearch<CR>

let mapleader = ','

if version >= 703
  " Toggle search highlighting
  nmap ; :set invhlsearch<CR>
  " Persistent undo - http://amix.dk/blog/post/19548
  set undofile
  set undodir=~/.vim/undo
  set undolevels=1000
  set undoreload=10000
endif

" Window navigation
map <leader><Left> h
map <leader><Right> l
map <leader><Up> k
map <leader><Down> j

" Nerd
map <leader>n :NERDTreeToggle<CR>

" Change indent continuously
vmap < <gv
vmap > >gv

" Command-T
nmap <C-t> :CommandT<CR>
set wildignore+=*/node_modules/*

" Autocomplete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
