local neotest = require('neotest')

neotest.setup {
  adapters = {
    require('neotest-rspec'),
  }
}

vim.keymap.set('n', '<leader>tt', neotest.run.run(), { noremap = true, silent = true })
vim.keymap.set('n', '<leader>tT', neotest.run.run(vim.fn.expand('%')), { noremap = true, silent = true })
vim.keymap.set('n', '<leader>tS', neotest.run.run(vim.fn.getcwd()), { noremap = true, silent = true })
