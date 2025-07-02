return {
  {
    'echasnovski/mini.notify',
    version = false,
    config = function()
      local notify = require('mini.notify')

      notify.setup {}

      vim.notify = notify.make_notify {
        ERROR = { duration = 8000 },
        WARN = { duration = 5000 },
        INFO = { duration = 3000 },
      }
    end,
  },

  {
    'editorconfig/editorconfig-vim',
    event = 'InsertEnter',
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
    config = function()
      require('ibl').setup {}
    end,
  },

  {
    'andymass/vim-matchup',
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = 'popup' }
    end,
  },
}
