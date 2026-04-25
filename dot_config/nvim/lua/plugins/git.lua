return {
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {}
    end,
    keys = {
      { '<leader>gb', function() require('gitsigns').blame_line({ full = true }) end, desc = 'Blame line' },
      { '<leader>gd', function() require('gitsigns').diffthis() end,                  desc = 'Diff this' },
      { '<leader>gw', function() require('gitsigns').stage_buffer() end,              desc = 'Stage buffer' },
      { '<leader>gr', function() require('gitsigns').reset_buffer() end,              desc = 'Reset buffer' },
    },
  },
}
