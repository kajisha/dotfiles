return {
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { mode = 'n', '<leader>xx', ':Trouble diagnostics toggle<CR>',    noremap = true, silent = true },
      { mode = 'n', '<leader>xw', ':Trouble workspace_diagnostics<CR>', noremap = true, silent = true },
      { mode = 'n', '<leader>xd', ':Trouble document_diagnostics<CR>',  noremap = true, silent = true },
      { mode = 'n', '<leader>xl', ':Trouble loclist<CR>',               noremap = true, silent = true },
      { mode = 'n', '<leader>xq', ':Trouble quickfix<CR>',              noremap = true, silent = true },
      { mode = 'n', 'gR',         ':Trouble lsp_references<CR>',        noremap = true, silent = true },
    },
    config = function()
      require('trouble').setup {
        auto_preview = true,
        modes = {
          preview_float = {
            mode = "diagnostics",
            preview = {
              type = "float",
              relative = "editor",
              border = "rounded",
              title = "Preview",
              title_pos = "center",
              position = { 0, -2 },
              size = { width = 0.3, height = 0.3 },
              zindex = 200,
            },
          },
        },
      }
    end,
  },

  {
    'dgagn/diagflow.nvim',
    opts = {
    },
  },
}
