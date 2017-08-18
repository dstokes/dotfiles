set nocompatible
syntax enable
filetype plugin on

source $HOME/.vim/vimrc/plug.vim
source $HOME/.vim/vimrc/settings.vim
source $HOME/.vim/vimrc/mappings.vim
source $HOME/.vim/vimrc/misc.vim

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
