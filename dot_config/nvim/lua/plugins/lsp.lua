return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      -- blink.cmp capabilities を全サーバーに適用 (Neovim 0.11+)
      vim.lsp.config('*', {
        capabilities = require('blink.cmp').get_lsp_capabilities(),
      })

      -- See https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

      vim.lsp.config('ruby_lsp', {
        init_options = {
          formatter = 'standard',
          linters = { 'rubocop' },
        }
      })

      vim.lsp.config('ts_ls', {
        on_init = function(client)
          client.notify('workspace/didChangeConfiguration', {
            settings = {
              typescript = {
                tsdk = 'node_modules/typescript/lib',
                format = {
                  enable = true,
                  import = {
                    code = 'import { $1 } from "$2";',
                    default = 'import $1 from "$2";',
                    named = 'import { $1 } from "$2";',
                  },
                },
                suggest = {
                  autoImports = true,
                },
              },
            },
          })
        end,
      })

      vim.lsp.config('yamlls', {
        settings = {
          yamlls = {
            schemas = {
              ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*'
            }
          }
        }
      })

      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
            },
            hint = { enable = true },
          },
        }
      })

      -- mason-lspconfig が ensure_installed サーバーを自動 enable するが、
      -- ts_ls は ensure_installed に含まれていないため手動で enable する
      vim.lsp.enable('ts_ls')

      -- diagnostic 表示設定
      vim.diagnostic.config({
        virtual_text = {
          prefix  = '●',
          source  = 'if_many',
          spacing = 4,
        },
        signs = true,
        underline = true,
        float = {
          border = 'rounded',
          source = true,
        },
      })

      -- LSP keymaps (LspAttach で設定)
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(ev)
          local opts = { noremap = true, silent = true, buffer = ev.buf }
          vim.keymap.set('n', 'K',           vim.lsp.buf.hover,                                    opts)
          vim.keymap.set('n', 'gr',          vim.lsp.buf.references,                               opts)
          vim.keymap.set('n', 'gi',          vim.lsp.buf.implementation,                           opts)
          vim.keymap.set('n', 'gd',          vim.lsp.buf.definition,                               opts)
          vim.keymap.set('n', 'gD',          function() vim.cmd('split') vim.lsp.buf.definition() end, opts)
          vim.keymap.set('n', 'ga',          vim.lsp.buf.code_action,                              opts)
          vim.keymap.set('n', 'ge',          vim.diagnostic.open_float,                            opts)
          vim.keymap.set('n', 'gn',          function() vim.diagnostic.jump({ count = 1,  float = true }) end, opts)
          vim.keymap.set('n', 'gp',          function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
          vim.keymap.set('n', '<leader>rn',  vim.lsp.buf.rename,                                   opts)
          vim.keymap.set('n', '<leader>to',  '<cmd>AerialToggle<CR>',                              opts)
        end,
      })
    end,
  },
  {
    'mason-org/mason.nvim',
    dependencies = {
      'mason-org/mason-lspconfig.nvim',
    },
    config = function()
      require('mason').setup {
        ui = {
          icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗'
          }
        }
      }

      require('mason-lspconfig').setup {
        ensure_installed = {
          'clangd',
          -- Docker
          'dockerls',
          'docker_compose_language_service',
          -- Lua
          'lua_ls',
          -- Ruby
          'ruby_lsp',
          -- TypeScript
          'biome',
          'prismals',
          -- Go
          'gopls',
          -- YAML
          'yamlls',
          -- GraphQL
          'graphql',
          -- OpenAPI
          'vacuum',
        }
      }
    end,
  },

  -- フォーマット
  {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    cmd = 'ConformInfo',
    opts = {
      formatters_by_ft = {
        javascript      = { 'biome' },
        javascriptreact = { 'biome' },
        typescript      = { 'biome' },
        typescriptreact = { 'biome' },
        json            = { 'biome' },
        jsonc           = { 'biome' },
        css             = { 'biome' },
      },
      format_on_save = {
        timeout_ms = 2000,
        lsp_fallback = true,
      },
    },
  },
}
