" set completeopt-=preview

let g:asyncomplete_remove_duplicates = 1
let g:asyncomplete_smart_completion = 1
let g:asyncomplete_auto_popup = 1

function! asyncomplete#check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~ '\s'
endfunction

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
