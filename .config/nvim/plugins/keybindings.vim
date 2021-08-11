" leader
let mapleader = ","
noremap \ ,

imap <C-[> <Esc>
noremap ; :
nnoremap <C-c><C-c> :<C-u>nohlsearch<CR><Esc>
nnoremap <C-s> :w<CR>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

nnoremap gF :e <cfile><CR>

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

" ale <leader>a
nnoremap [ale] <Nop>
nmap <leader>a [ale]
nnoremap <silent> [ale]f :ALEFix<CR>
nnoremap <silent> [ale]s :ALEFixSuggest<CR>

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <CR>    pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
inoremap <expr> <CR>    pumvisible() ? asyncomplete#close_popup() . "\<CR>" : "\<CR>"
imap <c-space> <Plug>(asyncomplete_force_refresh)

" fzf <leader>f
nnoremap [fzf] <Nop>
nmap <leader>f [fzf]
nnoremap <silent> [fzf]f :GFiles<CR>
nnoremap <silent> [fzf]b :Buffers<CR>
nnoremap <silent> [fzf]c :Colors<CR>
nnoremap <silent> [fzf]g :Ag <C-R><C-W><CR>
nnoremap <silent> [fzf]l :BLines<CR>
nnoremap <silent> [fzf]L :Lines<CR>
nnoremap <silent> [fzf]h :History<CR>

" neoterm <leader>n
nnoremap [neoterm] <Nop>
nmap <leader>n [neoterm]
vnoremap <silent> [neoterm]e :TREPLSendSelection<CR>
nnoremap <silent> [neoterm]f :TREPLSendFile<CR>
nnoremap <silent> [neoterm]e :TREPLSendLine<CR>
nnoremap <silent> [neoterm]t :Ttoggle<CR>
tnoremap <silent> <ESC> <C-\><C-n>

" fugitive <leader>g
nnoremap [fugitive] <Nop>
nmap <leader>g [fugitive]
nnoremap <silent> [fugitive]s  :Gstatus<CR>
nnoremap <silent> [fugitive]b  :Git blame<CR>
nnoremap <silent> [fugitive]B  :GBrowse<CR>
nnoremap <silent> [fugitive]ca :Git commit --ammend<CR>
nnoremap <silent> [fugitive]c  :Git commit -v -q<CR>
nnoremap <silent> [fugitive]d  :Gdiffsplit<CR>
nnoremap <silent> [fugitive]a  :Gwrite<CR>
nnoremap <silent> [fugitive]r  :Gread<CR>
nnoremap <silent> [fugitive]p  :Git push<CR>
nnoremap <silent> [fugitive]l  :Glog -- %<CR>

" vim-rails <leader>r
nnoremap [vim-rails] <Nop>
nmap <leader>r [vim-rails]
nnoremap <silent> [vim-rails]a :AV<CR>
nnoremap <silent> [vim-rail]r :RV<CR>

" vim-test <leader>t
nnoremap [vim-test] <Nop>
nmap <leader>t [vim-test]
nnoremap <silent> [vim-test]t :TestNearest<CR>
nnoremap <silent> [vim-test]T :TestFile<CR>
nnoremap <silent> [vim-test]a :TestSuite<CR>
nnoremap <silent> [vim-test]l :TestLast<CR>
nnoremap <silent> [vim-test]g :TestVisit<CR>

" vim-plug <leader>p
nnoremap [vim-plug] <Nop>
nmap <leader>p [vim-plug]
nnoremap <silent> [vim-plug]u :PlugUpdate<CR>
nnoremap <silent> [vim-plug]U :PlugUpgrade<CR>

" coc.nvim
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use K to show documentation in preview window.
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>fmt  <Plug>(coc-format-selected)
nmap <leader>fmt  <Plug>(coc-format-selected)

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"


" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>ca  <Plug>(coc-codeaction-selected)
nmap <leader>ca  <Plug>(coc-codeaction-selected)

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)
