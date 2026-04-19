return {
  'stevearc/oil.nvim',
  lazy = false,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('oil').setup({
      default_file_explorer = true,
      columns = { 'icon' },
      view_options = {
        show_hidden = false,
        natural_order = true,
        sort = {
          { 'type', 'asc' },
          { 'name', 'asc' },
        },
      },
      float = {
        padding = 2,
        border = 'rounded',
      },
      preview = {
        border = 'rounded',
      },
      keymaps = {
        ['g?'] = 'actions.show_help',
        ['<CR>'] = 'actions.select',
        ['<C-s>'] = { 'actions.select', opts = { vertical = true } },
        ['<C-h>'] = { 'actions.select', opts = { horizontal = true } },
        ['<C-t>'] = { 'actions.select', opts = { tab = true } },
        ['<C-p>'] = 'actions.preview',
        ['<C-c>'] = 'actions.close',
        ['<C-l>'] = 'actions.refresh',
        ['-'] = 'actions.parent',
        ['_'] = 'actions.open_cwd',
        ['g.'] = 'actions.toggle_hidden',
      },
      use_default_keymaps = false,
    })
  end,
  keys = {
    { '-', '<CMD>Oil<CR>', desc = 'Open parent directory' },
    { '<leader>ft', function() require('oil').toggle_float() end, desc = 'Toggle oil (float)' },
  },
}
