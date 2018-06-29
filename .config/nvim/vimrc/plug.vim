call plug#begin()
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'tomtom/tcomment_vim'
Plug 'vim-scripts/AutoComplPop'
Plug 'airblade/vim-gitgutter'

Plug 'fatih/vim-go'
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'junegunn/fzf', { 'dir': '~/Code/fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'vimwiki/vimwiki'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
call plug#end()