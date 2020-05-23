" Leader
let mapleader = ","
noremap \ ,

imap <C-[> <Esc>
noremap ; :
nnoremap <C-c><C-c> :<C-u>nohlsearch<CR><Esc>
nnoremap <C-s> :w<CR>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" netrw
" j     下に移動
" k     上に移動
" Enter ディレクトリの場合は移動、ファイルの場合はカレントバッファに開く
" o     水平分割で開く
" v     垂直分割で開く
" -     一つ上のディレクトリに移動
" u     undo、１つ前のディレクトリに戻る
" U     redo、uで戻る前のディレクトリに戻る
" d     ディレクトリを作成する
" D     ディレクトリ・ファイルを削除する
" mf    ファイルをマークする
" mt    コピー・移動先のディレクトリをマークする
" mc    mfしたファイルをmtしたディレクトリにコピーする
" mm    mfしたファイルをmtしたディレクトリに移動する
" I     ヘッダの表示トグル
" i     ファイルツリーの表示形式を変更
" p     ファイルをプレビューする

" ale <Leader>a
nnoremap [ale] <Nop>
nmap <Leader>a [ale]
nnoremap <silent> [ale]f :ALEFix<CR>
nnoremap <silent> [ale]s :ALEFixSuggest<CR>

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <CR>    pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
inoremap <expr> <CR>    pumvisible() ? asyncomplete#close_popup() . "\<CR>" : "\<CR>"
imap <c-space> <Plug>(asyncomplete_force_refresh)

" fzf <Leader>f
nnoremap [fzf] <Nop>
nmap <Leader>f [fzf]
nnoremap <silent> [fzf]f :GFiles<CR>
nnoremap <silent> [fzf]b :Buffers<CR>
nnoremap <silent> [fzf]c :Colors<CR>
nnoremap <silent> [fzf]g :Ag <C-R><C-W><CR>
nnoremap <silent> [fzf]l :BLines<CR>
nnoremap <silent> [fzf]L :Lines<CR>
nnoremap <silent> [fzf]h :History<CR>

" neoterm <Leader>n
nnoremap [neoterm] <Nop>
nmap <Leader>n [neoterm]
vnoremap <silent> [neoterm]e :TREPLSendSelection<CR>
nnoremap <silent> [neoterm]f :TREPLSendFile<CR>
nnoremap <silent> [neoterm]e :TREPLSendLine<CR>
nnoremap <silent> [neoterm]t :Ttoggle<CR>

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
nnoremap <silent> [vim-lsp]a  :LspCodeAction<CR>
nnoremap <silent> [vim-lsp]d  :LspDeclaration<CR>
nnoremap <silent> [vim-lsp]D  :LspDefinition<CR>
nnoremap <silent> [vim-lsp]dd :LspDocumentDiagnostics<CR>
nnoremap <silent> [vim-lsp]df :LspDocumentFormat<CR>
nnoremap <silent> [vim-lsp]rf :LspDocumentRangeFormat<CR>
nnoremap <silent> [vim-lsp]ds :LspDocumentSymbol<CR>
nnoremap <silent> [vim-lsp]h  :LspHover<CR>
nnoremap <silent> [vim-lsp]i  :LspImplementation<CR>
nnoremap <silent> [vim-lsp]nd :LspNextDiagnostic<CR>
nnoremap <silent> [vim-lsp]ne :LspNextError<CR>
nnoremap <silent> [vim-lsp]nr :LspNextReference<CR>
nnoremap <silent> [vim-lsp]nw :LspNextWarning<CR>
nnoremap <silent> [vim-lsp]Pd :LspPeekDeclaration<CR>
nnoremap <silent> [vim-lsp]PD :LspPeekDefinition<CR>
nnoremap <silent> [vim-lsp]Pi :LspPeekImplementation<CR>
nnoremap <silent> [vim-lsp]Pt :LspPeekTypeDefinition<CR>
nnoremap <silent> [vim-lsp]pd :LspPreviousDiagnostic<CR>
nnoremap <silent> [vim-lsp]pe :LspPreviousError<CR>
nnoremap <silent> [vim-lsp]pr :LspPreviousReference<CR>
nnoremap <silent> [vim-lsp]pw :LspPreviousWarning<CR>
nnoremap <silent> [vim-lsp]r  :LspReferences<CR>
nnoremap <silent> [vim-lsp]R  :LspRename<CR>
nnoremap <silent> [vim-lsp]td :LspTypeDefinition<CR>
nnoremap <silent> [vim-lsp]th :LspTypeHierarchy<CR>
nnoremap <silent> [vim-lsp]ws :LspWorkspaceSymbol<CR>

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
