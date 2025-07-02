return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',
      { 'olimorris/neotest-rspec', lazy = true, commit = 'a7910019d723a214d95400dd59317cf15561dba1' },
      'marilari88/neotest-vitest',
    },
    config = function()
      local neotest = require('neotest')

      neotest.setup {
        adapters = {
          require('neotest-rspec') {
            rspec_cmd = function()
              return vim.tbl_flatten {
                'docker',
                'compose',
                'exec',
                'app',
                'bin/rspec',
              }
            end,
            transform_spec_path = function(path)
              local prefix = require('neotest-rspec').root(path)
              return string.sub(path, string.len(prefix) + 2, -1)
            end,
            results_path = function()
              return 'tmp/rspec.output'
            end,
          },
          require('neotest-vitest') {
            vitestCommand = 'npx vitest -w',
          },
        },
        quickfix = {
          open = false,
          enabled = true,
        },
        status = {
          enabled = true,
          sign = true,
          virtual_text = false,
        },
        floating = {
          border = 'rounded',
          max_height = 0.9,
          max_width = 0.9,
          options = {}
        },
        summary = {
          open = 'botright vsplit | vertical resize 60'
        },
      }

      local keymap_ops = { noremap = true, silent = true, nowait = true }

      vim.keymap.set('n', 'ta',
      function()
        neotest.run.attach()
      end, keymap_ops)
      vim.keymap.set('n', 'tt',
      function()
        neotest.run.run()
      end, keymap_ops)
      vim.keymap.set('n', 'tT',
      function()
        neotest.run.run(vim.fn.expand("%"))
      end, keymap_ops)
      vim.keymap.set('n', 'tS',
      function()
        neotest.run.run(vim.fn.getcwd())
        neotest.output.open({ last_run = true, enter = true })
      end, keymap_ops)
      vim.keymap.set('n', 'ts',
      function()
        neotest.summary.toggle()
      end, keymap_ops)
      vim.keymap.set('n', 'to',
      function()
        neotest.output.open({ last_run = true, enter = true, auto_close = true })
      end, keymap_ops)
    end,
  },
}
