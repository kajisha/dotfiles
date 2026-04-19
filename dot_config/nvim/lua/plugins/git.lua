return {
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {}
    end
  },
  {
    'tpope/vim-fugitive',
    keys = {
      { mode = 'n', '<leader>gb',  ':Git blame<CR>',          noremap = true },
      { mode = 'n', '<leader>gca', ':Git commit --amend<CR>', noremap = true },
      { mode = 'n', '<leader>gc',  ':Git commit -v -q<CR>',   noremap = true },
      { mode = 'n', '<leader>gd',  ':Gdiffsplit<CR>',         noremap = true },
      { mode = 'n', '<leader>gw',  ':Gwrite<CR>',             noremap = true },
      { mode = 'n', '<leader>gr',  ':Gread<CR>',              noremap = true },
      { mode = 'n', '<leader>gp',  ':Git push<CR>',           noremap = true },
      { mode = 'n', '<leader>gl',  ':Glog -- %<CR>',          noremap = true },
    },
  },
}
