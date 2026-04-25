return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    preset = 'helix',
    delay  = 500,
    spec   = {
      { '<leader>b', group = 'buffer' },
      { '<leader>c', group = 'claude' },
      { '<leader>d', group = 'debug' },
      { '<leader>f', group = 'find' },
      { '<leader>g', group = 'git' },
      { '<leader>r', group = 'refactor' },
      { '<leader>s', group = 'snacks' },
      { '<leader>t', group = 'test' },
      { '<leader>u', group = 'ui' },
      { '<leader>x', group = 'diagnostics' },
    },
  },
}
