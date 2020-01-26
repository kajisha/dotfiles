let g:fzf_buffers_jump = 1

nnoremap <silent> <C-p> :Files<CR>

command! -bang Colors
\ call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'}, <bang>0)

command! -bang -nargs=? -complete=dir Files
\ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
