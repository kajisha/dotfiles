let test#strategy = 'neovim'
let test#ruby#rspec#executable = filereadable('docker-compose.yml') ? 'docker-compose run --rm $APP_NAME bundle exec rspec' : 'bundle exec rspec'
let g:test#preserve_screen = 1

nnoremap [vim-test] <Nop>
nmap <Leader>t [vim-test]

nnoremap <silent> [vim-test]t :TestNearest<CR>
nnoremap <silent> [vim-test]T :TestFile<CR>
nnoremap <silent> [vim-test]a :TestSuite<CR>
nnoremap <silent> [vim-test]l :TestLast<CR>
nnoremap <silent> [vim-test]g :TestVisit<CR>
