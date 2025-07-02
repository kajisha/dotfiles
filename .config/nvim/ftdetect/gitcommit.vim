augroup gitabbr
  autocmd!
  autocmd FileType gitcommit iabbrev add add:
  autocmd FileType gitcommit iabbrev fix fix:
  autocmd FileType gitcommit iabbrev feat feat:
  autocmd FileType gitcommit iabbrev chore chore:
  autocmd FileType gitcommit iabbrev ci ci:
  autocmd FileType gitcommit iabbrev docs docs:
  autocmd FileType gitcommit iabbrev test test:
  autocmd FileType gitcommit iabbrev refactor refactor:
augroup END
