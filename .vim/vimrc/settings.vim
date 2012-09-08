" General settings
set encoding=utf-8
set wildignore+=*/node_modules/*

" Alignment
set autoindent
set smartindent

" Line Numering
set number
set numberwidth=5

" Tabs
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

" UI
set list
set listchars=tab:▸\ 
set background=dark
colorscheme solarized
set colorcolumn=80
set splitright
set splitbelow
set laststatus=2
set statusline=%F%=%l/%L,%c\ %P\ 
set hlsearch
set ignorecase
set incsearch
set t_Co=256
set mouse=a
set scrolloff=3

" Omnicomplete
set ofu=syntaxcomplete#Complete
set completeopt=longest,menuone

" Persistent undo - http://amix.dk/blog/post/19548
if version >= 703
  set undofile
  set undodir=~/.vim/undo
  set undolevels=1000
  set undoreload=10000
endif
