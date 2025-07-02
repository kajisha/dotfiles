return {
  'ibhagwan/fzf-lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('fzf-lua').setup {}
  end,
  keys = {
    { mode = 'n', '<leader>ff', '<cmd>FzfLua files<CR>' },
    { mode = 'n', '<leader>fg', '<cmd>FzfLua grep_cword<CR>' },
    { mode = 'n', '<leader>fb', '<cmd>FzfLua buffers<CR>' },
    { mode = 'n', '<leader>fo', '<cmd>FzfLua oldfiles<CR>' },
    { mode = 'n', '<leader>fs', '<cmd>FzfLua git_status<CR>' },
  }
}
