return {
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<CR>',                       mode = 'n', noremap = true, silent = true, desc = 'Diagnostics (project)' },
      { '<leader>xd', '<cmd>Trouble diagnostics toggle filter.buf=0<CR>',          mode = 'n', noremap = true, silent = true, desc = 'Diagnostics (buffer)' },
      { '<leader>xl', '<cmd>Trouble loclist toggle<CR>',                            mode = 'n', noremap = true, silent = true, desc = 'Location list' },
      { '<leader>xq', '<cmd>Trouble qflist toggle<CR>',                            mode = 'n', noremap = true, silent = true, desc = 'Quickfix' },
      { '<leader>xr', '<cmd>Trouble lsp_references toggle<CR>',                    mode = 'n', noremap = true, silent = true, desc = 'LSP references (Trouble)' },
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
    opts = {},
  },
}
