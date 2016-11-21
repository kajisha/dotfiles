" vim:ft=vim
" quickrun for rspec
let g:quickrun_config = {}
let g:quickrun_config._ = {'runner' : 'vimproc', "runner/vimproc/updatetime" : 10}
let g:quickrun_config['ruby.rspec'] = {'command': 'rspec', 'exec': 'bundle exec %c', 'cmdopt': '-cfd'}

augroup QRunRSpec
  autocmd!
  autocmd BufWinEnter,BufNewFile *_spec.rb set filetype=ruby.rspec
augroup END

nnoremap [quickrun] <Nop>
nmap <Leader>k [quickrun]
nnoremap <silent> [quickrun]r :call QRunRspecCurrentLine()<CR>

fun! QRunRspecCurrentLine()
  let line = line(".")
  exe ":QuickRun -exec '$HOME/.rbenv/shims/bundle exec %c %s%o' -cmdopt ':" . line . " -cfp --fail-fast'"
endfun

" unite-rails
nnoremap [unite]x :<C-u>Unite rails/
nnoremap [unite]xa :<C-u>Unite rails/asset<CR>
nnoremap [unite]xd :<C-u>Unite rails/db<CR>
nnoremap [unite]xj :<C-u>Unite rails/javascript<CR>
nnoremap [unite]xm :<C-u>Unite rails/model<CR>
nnoremap [unite]xs :<C-u>Unite rails/spec<CR>
nnoremap [unite]xc :<C-u>Unite rails/controller<CR>
nnoremap [unite]xv :<C-u>Unite rails/view<CR>

" vim-tags
let g:vim_tags_gems_tags_command = "/usr/bin/ctags -f Gemfile.lock.tags -R `bundle show --paths` 2>/dev/null"
set tags+=Gemfile.lock.tags,composer.lock.tags
