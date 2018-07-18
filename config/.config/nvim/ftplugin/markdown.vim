setl conceallevel=2
setl suffixesadd=.md       " open local links without suffixes
setl spell spelllang=en_us " turn on spell checking

" enter opens local markdown links
nnoremap <buffer> <ENTER> gf

" backspace goes to the previous markdown file
nnoremap <buffer> <BS> <C-O>
