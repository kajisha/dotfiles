return {
  'ThePrimeagen/refactoring.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('refactoring').setup {}
  end,
  keys = {
    { '<leader>Re', function() require('refactoring').refactor('Extract Function') end,          mode = 'v', desc = 'Extract function' },
    { '<leader>Rf', function() require('refactoring').refactor('Extract Function To File') end,  mode = 'v', desc = 'Extract function to file' },
    { '<leader>Rv', function() require('refactoring').refactor('Extract Variable') end,          mode = 'v', desc = 'Extract variable' },
    { '<leader>Ri', function() require('refactoring').refactor('Inline Variable') end, mode = { 'n', 'v' }, desc = 'Inline variable' },
    { '<leader>Rb', function() require('refactoring').refactor('Extract Block') end,              mode = 'n', desc = 'Extract block' },
    { '<leader>Rr', function() require('refactoring').select_refactor() end,          mode = { 'n', 'v' }, desc = 'Select refactor' },
  },
}
