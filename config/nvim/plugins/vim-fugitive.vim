let g:github_enterprise_urls = ['https://git.pepabo.com']

nnoremap [fugitive] <Nop>
nmap <Leader>g [fugitive]

nnoremap <silent> [fugitive]s  :Gstatus<CR>
nnoremap <silent> [fugitive]b  :Gblame<CR>
nnoremap <silent> [fugitive]B  :Gbrowse<CR>
nnoremap <silent> [fugitive]ca :Gcommit --ammend<CR>
nnoremap <silent> [fugitive]c  :Gcommit -v -q<CR>
nnoremap <silent> [fugitive]d  :Gdiff<CR>
nnoremap <silent> [fugitive]a  :Gwrite<CR>
nnoremap <silent> [fugitive]r  :Gread<CR>
nnoremap <silent> [fugitive]p  :Gpush<CR>
nnoremap <silent> [fugitive]l  :Glog -- %<CR>
