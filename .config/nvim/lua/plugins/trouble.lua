require('trouble').setup {}

vim.keymap.set('n', '<leader>xx', ':TroubleToggle<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>xw', ':TroubleToggle workspace_diagnostics<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>xd', ':TroubleToggle document_diagnostics<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>xl', ':TroubleToggle loclist<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>xq', ':TroubleToggle quickfix<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'gR', ':TroubleToggle lsp_references<CR>', { noremap = true, silent = true })
