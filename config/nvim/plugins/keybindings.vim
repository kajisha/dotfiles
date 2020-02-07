" Leader
let mapleader = ","
noremap \ ,

imap <C-[> <Esc>
noremap ; :
nnoremap <C-c><C-c> :<C-u>nohlsearch<cr><Esc>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" ale <Leader>a
nnoremap [ale] <Nop>
nmap <Leader>a [ale]
nnoremap <silent> [ale]f :ALEFix<CR>

" asyncomplete
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ asyncomplete#check_back_space() ? "\<TAB>" :
  \ asyncomplete#force_refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"


" fzf <Leader>f
nnoremap [fzf] <Nop>
nmap <Leader>f [fzf]
nnoremap <silent> <C-p>  :GFiles<CR>
nnoremap <silent> [fzf]b :Buffers<CR>
nnoremap <silent> [fzf]c :Colors<CR>
nnoremap <silent> [fzf]g :Ag <C-R><C-W><CR>
nnoremap <silent> [fzf]l :BLines<CR>
nnoremap <silent> [fzf]L :Lines<CR>

" neoterm <Leader>n
nnoremap [neoterm] <Nop>
nmap <Leader>n [neoterm]
vnoremap [neoterm]e :TREPLSendSelection<CR>
nnoremap [neoterm]f :TREPLSendFile<CR>
nnoremap [neoterm]e :TREPLSendLine<CR>
nnoremap [neoterm]t :Ttoggle<CR>

" fugitive <Leader>g
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

" vim-lsp <Leader>l
nnoremap [vim-lsp] <Nop>
nmap <Leader>l [vim-lsp]
nnoremap <silent> [vim-lsp]c :LspCodeAction<CR>
nnoremap <silent> [vim-lsp]d :LspDefinition<CR>
nnoremap <silent> [vim-lsp]p :LspPeekDefinition<CR>
nnoremap <silent> [vim-lsp]D :LspDeclaration<CR>
nnoremap <silent> [vim-lsp]P :LspPeekDeclaration<CR>
nnoremap <silent> [vim-lsp]f :LspDocumentFormat<CR>
nnoremap <silent> [vim-lsp]h :LspHover<CR>
nnoremap <silent> [vim-lsp]i :LspImplementation<CR>
nnoremap <silent> [vim-lsp]r :LspReferences<CR>
nnoremap <silent> [vim-lsp]R :LspRename<CR>
nnoremap <silent> [vim-lsp]t :LspTypeDefinition<CR>
nnoremap <silent> [vim-lsp]T :LspTypeHierarchy<CR>

" vim-rails <Leader>r
nnoremap [vim-rails] <Nop>
nmap <Leader>r [vim-rails]
nnoremap <silent> [vim-rails]a :AV<CR>
nnoremap <silent> [vim-rails]r :RV<CR>

" vim-test <Leader>t
nnoremap [vim-test] <Nop>
nmap <Leader>t [vim-test]
nnoremap <silent> [vim-test]t :TestNearest<CR>
nnoremap <silent> [vim-test]T :TestFile<CR>
nnoremap <silent> [vim-test]a :TestSuite<CR>
nnoremap <silent> [vim-test]l :TestLast<CR>
nnoremap <silent> [vim-test]g :TestVisit<CR>
