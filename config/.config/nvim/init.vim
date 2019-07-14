" vim:foldmethod=marker:foldlevel=0:foldenable
syntax enable
filetype plugin on

" General {{{
set autoindent
set autoread
set backspace=indent,eol,start " allow backspace in insert mode
set encoding=utf-8
set hidden                     " persist buffer changes without write
set modeline
set modelines=5
set nobackup                   " don't keep backup files
set noerrorbells
set nowrap
set scrolloff=3
set smartindent
set synmaxcol=200              " prevent UI from locking up on long lines
set t_Co=256
" }}}

" UI {{{
set background=light
set colorcolumn=80
set completeopt=longest,menuone
set laststatus=2
set list                             " highlight whitespace
set listchars=tab:▸\ 
set mouse=a
set mousefocus
set noruler
set number
set numberwidth=3
set omnifunc=syntaxcomplete#Complete
set signcolumn=yes
set splitbelow
set splitright
set statusline=\ %f
set updatetime=300
set visualbell
" }}}

" Folding & Indentation {{{
set expandtab
set foldlevel=20
set foldmethod=syntax
set nofoldenable
set shiftwidth=2
set softtabstop=2
set tabstop=2
" }}}

" Search {{{
set hlsearch
set incsearch
set path+=**                     " search recursively with :find
set smartcase
set wildignore+=*/node_modules/*
set wildmenu                     " show all auto-complete file name options
set wildmode=list:longest        " emulate shell auto-completion
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

" Color {{{
colorscheme solarized
let g:solarized_visibility = "low"
highlight CocErrorSign ctermfg=1 ctermbg=7
highlight CocErrorVirtualText ctermfg=9 guifg=#ff0000
highlight CocHintSign ctermbg=7
highlight CocHintVirtualText ctermfg=5
highlight CocInfoSign ctermbg=7
highlight CocInfoVirtualText ctermfg=5
highlight CocWarningSign ctermbg=7
highlight CocWarningVirtualText ctermfg=5
highlight Search ctermfg=7 ctermbg=6
highlight TrailingWhitespace ctermbg=red guibg=red
match TrailingWhitespace /\s\+\%#\@<!$/ " highlight trailing whitespace
" }}}

" Plugins {{{
call plug#begin()
Plug 'airblade/vim-gitgutter'                                         " git diff sign symbols
Plug 'hashivim/vim-terraform', { 'for': 'terraform' }                 " terraform support
Plug 'junegunn/fzf', { 'dir': '~/Code/fzf', 'do': './install --all' } " fuzzy find
Plug 'junegunn/fzf.vim'                                               " fuzzy find in vim
Plug 'junegunn/vim-easy-align', { 'on': 'EasyAlign' }                 " easy and flexbile text alignment
Plug 'junegunn/vim-peekaboo'                                          " visualize registers in a sidebar
Plug 'neoclide/coc.nvim', {'branch': 'release'}                       " intellisense engine
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }                " file browser
Plug 'tomtom/tcomment_vim'                                            " better comment manipulation
Plug 'tpope/vim-fugitive'                                             " git functionality in vim
Plug 'tpope/vim-rhubarb'                                              " vim-fugitive extension for Github
Plug 'tpope/vim-surround'                                             " easily manipulate surrounds
Plug 'vimwiki/vimwiki'                                                " wikis in vim
call plug#end()

" plugin configuration
let g:NERDTreeIgnore = ['\.DS_Store$', '\.git$', '\.vagrant', '\.idea', 'node_modules']
let g:NERDTreeShowHidden = 1
let g:gitgutter_sign_added = '┃'
let g:gitgutter_sign_modified = '┃'
let g:gitgutter_sign_removed = '┃'
let g:surround_no_insert_mappings = 1 " unmap surround weirdness
let g:vimwiki_global_ext = 0
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
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
nmap <silent> gd <Plug>(coc-definition)
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" folding
nnoremap <Space> zA

" disable ex mode
map Q <Nop>
" }}}

" Auto Commands {{{
autocmd BufWritePre *.go,*.rb :call CocAction('format') " gofmt on save
autocmd BufWritePre *.json :%s/\s\+$//e                 " remove eol whitespace
autocmd InsertLeave * redraw!                           " render eol whitespace when leaving insert mode
" }}}

" Miscellaneous {{{
if &term =~ '^screen'
  " tmux will send xterm-style keys when its xterm-keys option is on
  execute "set <xUp>=\e[1;*A"
  execute "set <xDown>=\e[1;*B"
  execute "set <xRight>=\e[1;*C"
  execute "set <xLeft>=\e[1;*D"
endif

let g:python2_host_prog = '/usr/local/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python3'
" }}}

" Commands {{{
command! Conf :tabedit $MYVIMRC
" }}}

runtime! local.vim " import untracked local config
