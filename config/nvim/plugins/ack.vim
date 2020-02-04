let g:ackprg = 'ag --nogroup --nocolor --column'

nnoremap [ack] <Nop>
nmap <Leader>f [ack]

nnoremap <silent> [ack]g :Ag <C-R><C-W><CR>
