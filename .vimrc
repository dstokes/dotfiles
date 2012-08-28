" User Vim settings instead of vi
set nocompatible

filetype on
"syntax on
set hlsearch

syntax enable
set background=dark
colorscheme solarized

" Softtabs, 2 spaces
set tabstop=2 
set shiftwidth=2
set softtabstop=2
" set noexpandtab
set expandtab
set nowrap

" Numbers
set number
set numberwidth=5

" Indents
set autoindent
set smartindent

set listchars=tab:>-
set list

" Autocomplete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
