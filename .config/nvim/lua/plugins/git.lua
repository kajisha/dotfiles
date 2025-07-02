return {
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {}
    end
  },
  {
    'tpope/vim-fugitive',
    dependencies = { 'tpope/vim-rhubarb' },
    keys = {
      { mode = 'n', '<leader>gs',  ':Gstatus<CR>',            noremap = true },
      { mode = 'n', '<leader>gb',  ':Git blame<CR>',          noremap = true },
      { mode = 'n', '<leader>gB',  ':GBrowse<CR>',            noremap = true },
      { mode = 'n', '<leader>gca', ':Git commit --amend<CR>', noremap = true },
      { mode = 'n', '<leader>gc',  ':Git commit -v -q<CR>',   noremap = true },
      { mode = 'n', '<leader>gd',  ':Gdiffsplit<CR>',         noremap = true },
      { mode = 'n', '<leader>ga',  ':Gwrite<CR>',             noremap = true },
      { mode = 'n', '<leader>gr',  ':Gread<CR>',              noremap = true },
      { mode = 'n', '<leader>gp',  ':Git push<CR>',           noremap = true },
      { mode = 'n', '<leader>gl',  ':Glog -- %<CR>',          noremap = true },
    },
  },
}
