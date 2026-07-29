return {
  'folke/neoconf.nvim',
  lazy = false,
  priority = 950,
  config = function()
    require('neoconf').setup {}
  end,
}
