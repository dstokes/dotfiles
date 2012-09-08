" Misc Settings

inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" Centralize backups & swap files
set directory=~/.vim/swp
set backupdir=~/.vim/backup

" Autocomplete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" Highlight end-of-line whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * redraw!

" Switch between dark and light backgrounds
nmap \ :call ToggleBG()<CR>
function! ToggleBG()
   if &background == 'light'
     set background=dark
   else
     set background=light
   endif
 endfunction
