inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

imap <C-[> <Esc>
noremap ; :
nnoremap <C-c><C-c> :<C-u>nohlsearch<cr><Esc>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" tag jump
nnoremap <C-k> :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" vim-fugitive
nnoremap [fugitive] <Nop>
nmap <Leader>g [fugitive]

nnoremap <silent> [fugitive]s  :Gstatus<CR>
nnoremap <silent> [fugitive]ca :Gcommit --ammend<CR>
nnoremap <silent> [fugitive]c  :Gcommit -v -q<CR>
nnoremap <silent> [fugitive]d  :Gdiff<CR>
nnoremap <silent> [fugitive]a  :Gwrite<CR>
nnoremap <silent> [fugitive]r  :Gread<CR>
nnoremap <silent> [fugitive]p  :Gpush<CR>
nnoremap <silent> [fugitive]l  :Glog -- %<CR>

" unite.vim
nmap <Leader>f [unite]

nnoremap [unite]U :<C-u>Unite -no-split<Space>
nnoremap [unite]u :<C-u>Unite<Space>
nnoremap <silent> [unite]f  :<C-u>Unite<Space>buffer<CR>
nnoremap <silent> [unite]b  :<C-u>Unite<Space>bookmark<CR>
nnoremap <silent> [unite]m  :<C-u>Unite<Space>file_mru<CR>
nnoremap <silent> [unite]r  :<C-u>UniteWithBufferDir file<CR>
nnoremap <silent> [unite]ur :UniteResume<CR>

nnoremap <silent> [unite]g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
nnoremap <silent> [unite]gg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W><CR>
nnoremap <silent> [unite]sb :<C-u>UniteResume search-buffer<CR>

" vim-test
nnoremap <silent> <Leader>t :TestFile<CR>
nnoremap <silent> <Leader>s :TestNearest<CR>
nnoremap <silent> <Leader>l :TestLast<CR>
nnoremap <silent> <Leader>a :TestSuite<CR>
nnoremap <silent> <Leader>gt :TestVisit<CR>

" NERDTree
nnoremap <silent><C-e> :NERDTreeToggle<CR>
