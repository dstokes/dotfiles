set nocompatible
syntax enable
filetype plugin on

call plug#begin()
Plug 'tpope/vim-surround'
Plug 'scrooloose/syntastic'
Plug 'tomtom/tcomment_vim'
Plug 'vim-scripts/AutoComplPop'
Plug 'airblade/vim-gitgutter'

Plug 'fatih/vim-go', { 'for': 'golang' }
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'junegunn/fzf', { 'dir': '~/Code/fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-fugitive'
call plug#end()

source $HOME/.vim/vimrc/settings.vim
source $HOME/.vim/vimrc/mappings.vim
source $HOME/.vim/vimrc/misc.vim

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
