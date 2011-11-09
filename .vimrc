" User Vim settings instead of vi
set nocompatible

filetype on
syntax on
set hlsearch

" Softtabs, 2 spaces
set tabstop=2 
set shiftwidth=2
set expandtab
set nowrap

" Numbers
set number
set numberwidth=5

" Indents
set autoindent
set smartindent

" Autocomplete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
