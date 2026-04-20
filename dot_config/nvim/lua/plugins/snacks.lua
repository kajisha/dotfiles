return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    notifier = { enabled = true, timeout = 3000 },
    quickfile = { enabled = true },
    input = { enabled = true },
    words = { enabled = true },
    indent = { enabled = true },
    terminal = { enabled = true },
    picker = { enabled = true },
    gitbrowse = { enabled = true },
  },
  keys = {
    -- Picker: keymaps that don't conflict with fzf-lua (<leader>ff/fg/fb/fo/fs) or telescope (<leader>fG ghq)
    { '<leader>f/', function() Snacks.picker.lines() end,           desc = 'Buffer lines' },
    { '<leader>fw', function() Snacks.picker.grep_word() end,       desc = 'Grep word',   mode = { 'n', 'x' } },
    { '<leader>fB', function() Snacks.picker.grep_buffers() end,    desc = 'Grep open buffers' },
    { '<leader>fk', function() Snacks.picker.keymaps() end,         desc = 'Keymaps' },
    { '<leader>fz', function() Snacks.picker.zoxide() end,          desc = 'Zoxide' },

    -- Git
    { '<leader>gs', function() Snacks.picker.git_status() end,      desc = 'Git status' },
    { '<leader>gL', function() Snacks.picker.git_log() end,         desc = 'Git log' },
    { '<leader>gB', function() Snacks.gitbrowse() end,              desc = 'Git browse', mode = { 'n', 'v' } },

    -- Terminal
    { 'gt',         function() Snacks.terminal.toggle() end,        desc = 'Toggle terminal', mode = { 'n', 't' } },

    -- Notifications
    { '<leader>n',  function() Snacks.notifier.show_history() end,  desc = 'Notification history' },
    { '<leader>un', function() Snacks.notifier.hide() end,          desc = 'Dismiss notifications' },
  },
  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        -- Replace vim.ui.input / notify with snacks equivalents
        vim.print = _G.dd or vim.print
      end,
    })
  end,
}
