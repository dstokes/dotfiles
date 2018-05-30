" vim:foldmethod=marker:foldlevel=0:foldenable
syntax enable
filetype plugin on

" General {{{
set autoindent
set autoread
set backspace=indent,eol,start " Allow backspace in insert mode
set encoding=utf-8
set hidden                     " Persist buffer changes without write
set modeline
set modelines=5
set nobackup
set noerrorbells
set nowrap
set scrolloff=3
set smartindent
set synmaxcol=200              " Prevent UI from locking up on long lines
set t_Co=256
set wildignore+=*/node_modules/*
set wildmenu                   " show all auto-complete file name options
set wildmode=list:longest      " emulate shell auto-completion
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
set noruler
set number
set numberwidth=3
set omnifunc=syntaxcomplete#Complete
set splitbelow
set splitright
set updatetime=300
set visualbell
" }}}

" Indentation {{{
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
" }}}

" Folding {{{
set foldlevel=20
set foldmethod=syntax
set nofoldenable
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
set directory=~/.config/nvim/swp
" Persistent undo - http://amix.dk/blog/post/19548
if version >= 703
  set undodir=~/.config/nvim/undo
  set undofile
  set undolevels=1000
  set undoreload=10000
endif
" }}}

" Plugins {{{
call plug#begin()
Plug 'airblade/vim-gitgutter'
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'junegunn/fzf', { 'dir': '~/Code/fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-easy-align', { 'on': 'EasyAlign' }
Plug 'junegunn/vim-peekaboo'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/AutoComplPop'
Plug 'vimwiki/vimwiki'
Plug 'w0rp/ale'
call plug#end()

" Configuration
let g:NERDTreeIgnore = ['\.DS_Store$', '\.git$', '\.vagrant', '\.idea', 'node_modules']
let g:NERDTreeShowHidden = 1
let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
let g:gitgutter_sign_added = '┃'
let g:gitgutter_sign_modified = '┃'
let g:gitgutter_sign_removed = '┃'
let g:surround_no_insert_mappings = 1 " unmap surround weirdness
let g:vimwiki_global_ext = 0
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

highlight ALEErrorSign cterm=bold ctermfg=1 ctermbg=7
highlight ALEWarningSign cterm=bold ctermfg=2 ctermbg=7

function! s:goyo_enter()
  setl scrolloff=999
  setl wrap
  setl linebreak
  AutoComplPopDisable
endfunction

function! s:goyo_leave()
  setl scrolloff=5
  setl wrap
  setl nolinebreak
  AutoComplPopEnable
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
" }}}

" Mappings {{{
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
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>

" plugins
vmap <leader>c :TComment<CR>
map <leader>t :NERDTreeToggle<CR>
map <leader>f :Files<CR>

" folding
nnoremap <Space> zA

" disable ex mode
map Q <Nop>
" }}}

" Miscellaneous {{{
if &term =~ '^screen'
  " tmux will send xterm-style keys when its xterm-keys option is on
  execute "set <xUp>=\e[1;*A"
  execute "set <xDown>=\e[1;*B"
  execute "set <xRight>=\e[1;*C"
  execute "set <xLeft>=\e[1;*D"
endif

inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

let g:go_list_type = "quickfix"
let g:python2_host_prog = '/usr/local/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python3'
let g:markdown_fenced_languages = ['python', 'bash=sh', 'shell=sh', 'sh', 'json']

" autocomplete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS

" highlight end-of-line whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * redraw!

autocmd BufWritePre *.json :%s/\s\+$//e " Remove eol whitespace
" }}}

runtime! local.vim
