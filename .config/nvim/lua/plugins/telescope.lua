require('telescope').setup {
  extensions = {
    file_browser = {
      theme = 'ivy',
      hijack_netrw = true,
      -- mappings = {
      --   ['i'] = {
      --     -- insert mode mappings
      --   },
      --   ['n'] = {
      --     -- normal mode mappings
      --   },
      -- }
    }
  }
}

require('telescope').load_extension 'file_browser'

vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>', {})
vim.keymap.set('n', '<leader>fg', ':Telescope grep_string<CR>', {})
vim.keymap.set('n', '<leader>fB', ':Telescope buffers<CR>', {})
vim.keymap.set('n', '<leader>fb', ':Telescope file_browser<CR>', { noremap = true })
