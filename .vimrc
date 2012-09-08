set nocompatible
call pathogen#infect()
filetype plugin on
syntax enable

source $HOME/.vim/vimrc/settings.vim
source $HOME/.vim/vimrc/mappings.vim
source $HOME/.vim/vimrc/misc.vim

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
