return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',
      { 'olimorris/neotest-rspec', lazy = true, commit = 'a7910019d723a214d95400dd59317cf15561dba1', ft = 'ruby' },
      { 'nvim-neotest/neotest-python', lazy = true, ft = 'python' },
      'marilari88/neotest-vitest',
    },
    config = function()
      local neotest = require('neotest')

      neotest.setup {
        adapters = {
          require('neotest-python') {
            dap = { justMyCode = false },
            runner = 'pytest',
            pytest_discover_instances = true,
            -- Override the command to run tests in Docker
            pytest_cmd = function(path)
              -- Convert absolute path to relative path from project root
              local cwd = vim.fn.getcwd()
              local relative_path = path:gsub("^" .. cwd .. "/", "")
              -- Remove 'app/' prefix for Docker container
              relative_path = relative_path:gsub("^app/", "")
              
              return vim.tbl_flatten({
                'docker',
                'compose',
                'exec',
                'fastapi',
                'pytest',
                relative_path,
                '-v',
              })
            end,
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
