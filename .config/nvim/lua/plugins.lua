local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  require('plugins.nvim-osc52'),
  require('plugins.lualine'),
  require('plugins.colorscheme'),

  require('plugins.editor'),
  require('plugins.grep'),

  require('plugins.treesitter'),
  require('plugins.telescope'),

  -- require('plugins.autopairs'),
  require('plugins.surround'),

  require('plugins.git'),

  require('plugins.lsp'),
  require('plugins.diagnostics'),
  require('plugins.completion'),
  require('plugins.refactoring'),

  require('plugins.fzf'),
  require('plugins.filer'),

  require('plugins.neotest'),
  require('plugins.dap'),

  require('plugins.filetype.csv'),
  require('plugins.filetype.ruby'),

  require('plugins.copilot'),
}
