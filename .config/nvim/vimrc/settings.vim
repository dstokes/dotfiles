" vim:foldmethod=marker:foldlevel=0

" General {{{
set encoding=utf-8
set wildignore+=*/node_modules/*
set autoread
set nobackup
set noerrorbells
set hidden                     " Persist buffer changes without write
set autoindent
set smartindent
set nowrap
set modeline
set modelines=5
set t_Co=256
set scrolloff=3
set wildmenu                   " show all auto-complete file name options
set wildmode=list:longest      " emulate shell auto-completion
set backspace=indent,eol,start " Allow backspace in insert mode
set synmaxcol=200              " Prevent UI from locking up on long lines
" }}}

" UI {{{
set background=light
set colorcolumn=80
set completeopt=longest,menuone
set laststatus=0
set list
set listchars=tab:▸\ 
set mouse=a
set mousefocus
set number
set numberwidth=3
set omnifunc=syntaxcomplete#Complete
set splitbelow
set splitright
set updatetime=100
set visualbell
" }}}

" Indentation {{{
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
" }}}

" Folding {{{
set foldmethod=syntax
set nofoldenable
set foldlevel=20
" }}}

" Color {{{
colorscheme solarized
highlight Search ctermfg=7 ctermbg=6
let g:solarized_visibility = "low"
" }}}

" Search {{{
set hlsearch
set ignorecase
set incsearch
set smartcase
" }}}

" Files / Buffers {{{
" Persistent undo - http://amix.dk/blog/post/19548
if version >= 703
  set undofile
  set undodir=~/.vim/undo
  set undolevels=1000
  set undoreload=10000
endif
" }}}

if &term =~ '^screen'
  " tmux will send xterm-style keys when its xterm-keys option is on
  execute "set <xUp>=\e[1;*A"
  execute "set <xDown>=\e[1;*B"
  execute "set <xRight>=\e[1;*C"
  execute "set <xLeft>=\e[1;*D"
endif
