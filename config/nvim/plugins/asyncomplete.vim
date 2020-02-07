let g:asynccomplete_auto_popup = 0
set completeopt-=preview

function! asyncomplete#check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~ '\s'
endfunction

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
