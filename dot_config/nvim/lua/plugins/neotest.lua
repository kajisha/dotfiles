return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'folke/neoconf.nvim',
      { 'olimorris/neotest-rspec', lazy = true, commit = 'a7910019d723a214d95400dd59317cf15561dba1' },
      'marilari88/neotest-vitest',
    },
    config = function()
      local neotest = require('neotest')

      neotest.setup {
        adapters = {
          require('neotest-rspec') {
            rspec_cmd = function()
              local service = require('neoconf').get('neotest.docker_service')
              if service then
                return { 'docker', 'compose', 'exec', service, 'bin/rspec' }
              end
              return { 'bin/rspec' }
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
        consumers = {
          notify = function(client)
            client.listeners.results = function(_, results, partial)
              if partial then return end
              local failed, passed = 0, 0
              for _, result in pairs(results) do
                if result.status == 'failed' then
                  failed = failed + 1
                elseif result.status == 'passed' then
                  passed = passed + 1
                end
              end
              if failed > 0 then
                vim.notify(('✗ %d failed  ✓ %d passed'):format(failed, passed),
                  vim.log.levels.ERROR, { title = 'Neotest' })
              else
                vim.notify(('✓ %d passed'):format(passed),
                  vim.log.levels.INFO, { title = 'Neotest' })
              end
            end
          end,
          spinner = function(client)
            local frames = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
            local timer = nil
            local frame = 1
            local running = 0

            local function stop()
              if timer then
                timer:stop()
                timer:close()
                timer = nil
              end
              vim.fn.sign_define('neotest_running', { text = '▶', texthl = 'NeotestRunning' })
            end

            local function start()
              if timer then return end
              timer = vim.uv.new_timer()
              timer:start(0, 80, vim.schedule_wrap(function()
                vim.fn.sign_define('neotest_running', { text = frames[frame], texthl = 'NeotestRunning' })
                frame = frame % #frames + 1
              end))
            end

            client.listeners.run = function(_, _)
              running = running + 1
              start()
            end

            client.listeners.results = function(_, _, partial)
              if partial then return end
              running = math.max(0, running - 1)
              if running == 0 then stop() end
            end
          end,
        },
      }

      local opts = { noremap = true, silent = true, nowait = true }
      vim.keymap.set('n', 'ta', function() neotest.run.attach() end, opts)
      vim.keymap.set('n', 'tt', function() neotest.run.run() end, opts)
      vim.keymap.set('n', 'tT', function() neotest.run.run(vim.fn.expand('%')) end, opts)
      vim.keymap.set('n', 'tS', function()
        neotest.run.run(vim.fn.getcwd())
        neotest.output.open({ last_run = true, enter = true })
      end, opts)
      vim.keymap.set('n', 'ts', function() neotest.summary.toggle() end, opts)
      vim.keymap.set('n', 'to', function()
        neotest.output.open({ last_run = true, enter = true, auto_close = true })
      end, opts)
    end,
  },
}
