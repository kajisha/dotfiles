let g:neoterm_autoscoll = '1'
let g:neoterm_size = 24
let g:neoterm_automap_keys = '<F5>'
let neovim_default_mod = 'botright'

let g:neoterm_repl_ruby = 'pry'

tnoremap <silent> <ESC> <C-\><C-n>

nnoremap [neoterm] <Nop>
nmap <Leader>n [neoterm]

vnoremap [neoterm]e :TREPLSendSelection<CR>
nnoremap [neoterm]f :TREPLSendFile<CR>
nnoremap [neoterm]e :TREPLSendLine<CR>
nnoremap [neoterm]t :Ttoggle<CR>
