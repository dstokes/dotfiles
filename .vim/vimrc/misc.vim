" Misc Settings

inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" centralize swap files
set directory=~/.vim/swp

" show hidden files in NerdTree
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['\.DS_Store$', '\.git$', 'lib-cov']

" autocomplete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

autocmd BufNewFile,BufReadPost *.coffee setl foldmethod=indent
autocmd BufNewFile,BufReadPost *.rb,*.rake setl foldmethod=indent

" salt syntax highlighting
autocmd BufRead,BufNewFile *.template set filetype=JavaScript
autocmd BufRead,BufNewFile *.md set filetype=markdown

" highlight end-of-line whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * redraw!

" Remove eol whitespace
autocmd BufWritePre *.coffee,*.js,*.json,*.template,*.sls :%s/\s\+$//e

" switch between dark and light backgrounds
nmap <leader>s :call ToggleBG()<CR>
function! ToggleBG()
   if &background == 'light'
     set background=dark
   else
     set background=light
   endif
 endfunction
