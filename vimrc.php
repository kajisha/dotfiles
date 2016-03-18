" vim: ft=vim

" syntastics
" let g:syntastic_mode_map = {'mode': 'passive', 'active_filetypes': ['php']}
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_php_checkers = ['phpcs']
let g:syntasitc_php_phpcs_args='--standard=symfony'

" vim-php-cs-fixter
let g:php_cs_fixer_level = "symfony"
let g:php_cs_fixer_config = "default"
let g:php_cs_fixer_php_path = "php"
let g:php_cs_fixer_fixers_list = ""
let g:php_cS_fixer_enable_default_mapping = 1
let g:php_cS_fixer_dry_run = 0
let g:php_cS_fixer_verbose = 0

" vim-php/vim-composer
function! GenerateCtagsForComposer()
    exec ':silent !ctags -a -R -f composer.lock.tags vendor/'
endfunction
let g:composer_install_callback = "GenerateCtagsForComposer"
set tags+=composer.lock.tags

nnoremap <silent><leader>pcd :call PhpCsFixerFixDirectory()<CR>
nnoremap <silent><leader>pcf :call PhpCsFixerFixFile()<CR>

set ft=php ts=4 sw=4 et
