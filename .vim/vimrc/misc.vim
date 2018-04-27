" Misc Settings
inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" centralize swap files
set directory=~/.vim/swp

" show hidden files in NerdTree
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['\.DS_Store$', '\.git$', '\.vagrant', '\.idea', 'node_modules']

let g:go_list_type = "quickfix"
"let g:syntastic_go_checkers = ['golint', 'errcheck']
"let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

let g:python2_host_prog = '/usr/local/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python3'

" autocomplete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" highlight end-of-line whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * redraw!

" Remove eol whitespace
autocmd BufWritePre *.json :%s/\s\+$//e
