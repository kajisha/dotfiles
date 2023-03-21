vim.g.mapleader = ','

vim.keymap.set('i', 'C-[', '<Esc>')
vim.keymap.set('n', ';', ':')
vim.keymap.set('n', '<C-c><C-c>', ':<C-u>nohlsearch<CR><Esc>', {silent = true})
vim.keymap.set('n', '<leader><leader>', '<C-^>', {silent = true})
