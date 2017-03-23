" Misc Settings
inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" centralize swap files
set directory=~/.vim/swp

" show hidden files in NerdTree
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['\.DS_Store$', '\.git$', '\.vagrant', '\.idea', 'node_modules', '.1$']

let g:go_list_type = "quickfix"
let g:syntastic_go_checkers = ['golint', 'errcheck']
"let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

" autocomplete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType go set noexpandtab

autocmd BufRead,BufNewFile *.e,*.es6 set filetype=Javascript
autocmd BufNewFile,BufReadPost *.coffee setl foldmethod=indent
autocmd BufNewFile,BufReadPost *.rb,*.rake,Vagrantfile setl foldmethod=indent
autocmd BufNewFile,BufRead *.py setl tabstop=2 shiftwidth=2 softtabstop=2
autocmd BufNewFile,BufRead Dockerfile* setl filetype=Dockerfile

" salt syntax highlighting
autocmd BufRead,BufNewFile *.jinja set filetype=jinja
autocmd BufRead,BufNewFile *.template set filetype=json
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile Vagrantfile set filetype=ruby

" highlight end-of-line whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * redraw!

" Remove eol whitespace
autocmd BufWritePre *.coffee,*.js,*.json,*.template,*.sls :%s/\s\+$//e
