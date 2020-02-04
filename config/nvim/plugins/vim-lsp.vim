let g:lsp_diagnostics_enabled = 0

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
