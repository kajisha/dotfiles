return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    bigfile    = { enabled = true },
    gitbrowse  = { enabled = true },
    lazygit    = { enabled = true },
    indent     = { enabled = true },
    input      = { enabled = true },
    notifier   = {
      enabled = true,
      timeout = 3000,
      level   = vim.log.levels.INFO,
      style   = 'compact',
    },
    picker   = { enabled = true },
    words    = { enabled = true },
    terminal = { enabled = true },
  },
  keys = {
    -- バッファ・通知
    { '<leader>bd', function() Snacks.bufdelete() end,            desc = 'Delete buffer' },
    { '<leader>un', function() Snacks.notifier.hide() end,        desc = 'Dismiss notifications' },
    { '<leader>sn', function() Snacks.picker.notifications() end, desc = 'Notification history' },
    { 'gt',         function() Snacks.terminal.toggle() end,      desc = 'Toggle terminal' },

    -- ファイル検索
    { '<leader>ff', function() Snacks.picker.files() end,         desc = 'Find files' },
    { '<leader>fo', function() Snacks.picker.recent() end,        desc = 'Recent files' },
    { '<leader>fb', function() Snacks.picker.buffers() end,       desc = 'Buffers' },

    -- テキスト検索
    { '<leader>fg', function() Snacks.picker.grep() end,          desc = 'Live grep' },
    { '<leader>fw', function() Snacks.picker.grep_word() end,     desc = 'Grep word under cursor', mode = { 'n', 'v' } },
    { '<leader>f/', function() Snacks.picker.lines() end,         desc = 'Search buffer lines' },

    -- LSP picker
    { '<leader>fs', function() Snacks.picker.lsp_symbols() end,   desc = 'LSP symbols' },

    -- Git
    { '<leader>gg', function() Snacks.lazygit() end,              desc = 'Lazygit' },

    -- Git picker
    { '<leader>gs', function() Snacks.picker.git_status() end,    desc = 'Git status (picker)' },
    { '<leader>gL', function() Snacks.picker.git_log() end,       desc = 'Git log' },

    -- その他
    { '<leader>fk', function() Snacks.picker.keymaps() end,       desc = 'Keymaps' },
    { '<leader>fz', function() Snacks.picker.zoxide() end,        desc = 'Zoxide' },
    { '<leader>fG', function() Snacks.picker.grep_buffers() end,  desc = 'Grep open buffers' },

    -- gitbrowse (vim-rhubarb の代替)
    { '<leader>gB', function() Snacks.gitbrowse() end,            desc = 'Git browse', mode = { 'n', 'v' } },
  },
  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        -- vim.notify のみラップ。Snacks.notifier.notify は触らず history 記録を維持
        local orig_notify = vim.notify
        vim.notify = function(msg, level, opts)
          opts = opts or {}
          if level == vim.log.levels.ERROR and not opts.timeout then
            opts.timeout = 8000
          elseif level == vim.log.levels.WARN and not opts.timeout then
            opts.timeout = 5000
          end
          return orig_notify(msg, level, opts)
        end
      end,
    })
  end,
}
