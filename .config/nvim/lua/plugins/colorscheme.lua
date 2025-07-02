return {
  'sainnhe/everforest',
  config = function()
    vim.opt.background = 'dark'

    vim.g.everforest_better_performance = 1
    vim.g.everforest_background = 'hard'

    vim.cmd [[colorscheme everforest]]
  end,
}
