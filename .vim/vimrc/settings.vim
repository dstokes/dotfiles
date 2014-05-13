" General settings
set encoding=utf-8
set wildignore+=*/node_modules/*
set autoread
set nobackup
set visualbell
set noerrorbells

" Alignment
set autoindent
set smartindent
set nowrap

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
"set background=dark
set background=light
colorscheme solarized
set colorcolumn=80
set splitright
set splitbelow
set laststatus=2
set statusline=%F%=%l/%L,%c\ %P\ 
set hlsearch
set ignorecase
set incsearch
set smartcase
set t_Co=256
set mouse=a
set mousefocus
set ttymouse=xterm2
set scrolloff=3
set wildmenu                   " show all auto-complete file name options
set wildmode=list:longest      " emulate shell auto-completion
set backspace=indent,eol,start " Allow backspace in insert mode
set hidden                     " Persist buffer changes without write
set modeline
set modelines=5
set synmaxcol=120              " Prevent UI from locking up on long lines
highlight Search ctermfg=7 ctermbg=6

" Folding
set foldmethod=syntax
set nofoldenable
set foldlevel=20

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

if &term =~ '^screen'
  " tmux will send xterm-style keys when its xterm-keys option is on
  execute "set <xUp>=\e[1;*A"
  execute "set <xDown>=\e[1;*B"
  execute "set <xRight>=\e[1;*C"
  execute "set <xLeft>=\e[1;*D"
endif

"autocmd InsertEnter * :set number
"autocmd InsertLeave * :set relativenumber
