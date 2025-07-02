autocmd BufRead,BufNewFile Appraisals set filetype=ruby
autocmd BufRead,BufNewFile Dangerfile set filetype=ruby
autocmd BufRead,BufNewFile Schemafile set filetype=ruby
autocmd BufRead,BufNewFile *.json.jb set filetype=ruby
autocmd BufRead,BufNewFile *.schema set filetype=ruby
autocmd BufRead,BufNewFile *.thor set filetype=ruby
autocmd BufRead,BufNewFile Thorfile set filetype=ruby
autocmd BufRead,BufNewFile *.rbi set filetype=ruby

augroup frozenstring
  autocmd!
  autocmd FileType ruby iabbrev fsl # frozen_string_literal: true<CR>
augroup END
