return {
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {}
    end
  },

  {
    'nvim-mini/mini-git',
    version = false,
    keys = {
      { mode = 'n', '<leader>gd',  ':Git diffthis<CR>',       noremap = true },
      { mode = 'n', '<leader>gb',  ':Git blame<CR>',          noremap = true },
      -- { mode = 'n', '<leader>gca', ':Git commit --amend<CR>', noremap = true },
      -- { mode = 'n', '<leader>gc',  ':Git commit -v -q<CR>',   noremap = true },
      -- { mode = 'n', '<leader>gd',  ':Gdiffsplit<CR>',         noremap = true },
      -- { mode = 'n', '<leader>ga',  ':Gwrite<CR>',             noremap = true },
      -- { mode = 'n', '<leader>gr',  ':Gread<CR>',              noremap = true },
      -- { mode = 'n', '<leader>gp',  ':Git push<CR>',           noremap = true },
      { mode = 'n', '<leader>gl',  ':Git show_commit<CR>',      noremap = true },
    },
  },

  -- {
  --   'tpope/vim-fugitive',
  --   dependencies = { 'tpope/vim-rhubarb' },
  --   keys = {
  --     { mode = 'n', '<leader>gs',  ':Gstatus<CR>',            noremap = true },
  --     { mode = 'n', '<leader>gb',  ':Git blame<CR>',          noremap = true },
  --     { mode = 'n', '<leader>gB',  ':GBrowse<CR>',            noremap = true },
  --     { mode = 'n', '<leader>gca', ':Git commit --amend<CR>', noremap = true },
  --     { mode = 'n', '<leader>gc',  ':Git commit -v -q<CR>',   noremap = true },
  --     { mode = 'n', '<leader>gd',  ':Gdiffsplit<CR>',         noremap = true },
  --     { mode = 'n', '<leader>ga',  ':Gwrite<CR>',             noremap = true },
  --     { mode = 'n', '<leader>gr',  ':Gread<CR>',              noremap = true },
  --     { mode = 'n', '<leader>gp',  ':Git push<CR>',           noremap = true },
  --     { mode = 'n', '<leader>gl',  ':Glog -- %<CR>',          noremap = true },
  --   },
  --
  --   {
  --     "3ZsForInsomnia/revman.nvim",
  --     dependencies = {
  --       "kkharji/sqlite.lua",
  --       "pwntester/octo.nvim",
  --     },
  --     config = function ()
  --       require('revman').setup({
  --         database_path = vim.fn.stdpath('state') .. '/revman/revman.db',
  --         data_retension_days = 30,
  --         background_sync_frequency = 15,
  --         picker = 'telescope',
  --         log_level = 'warn',
  --       })
  --     end,
  --   },
  -- },
}
