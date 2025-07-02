return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        biome = {},
        prismals = {},
      }
    },
    config = function()
      local lspconfig = require('lspconfig')

      -- See https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

      lspconfig.ruby_lsp.setup {
        init_options = {
          formatter = 'standard',
          linters = { 'rubocop' },
        }
      }

      lspconfig.ts_ls.setup {
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
      }

      lspconfig.biome.setup {
        cmd = { 'biome', 'lsp' },
        on_new_config = function(new_config)
          local pnpm = lspconfig.util.root_pattern("pnpm-lock.yml", "pnpm-lock.yaml")(vim.api.nvim_buf_get_name(0))
          local cmd = { "npx", "biome", "lsp-proxy" }
          if pnpm then
            cmd = { "pnpm", "biome", "lsp-proxy" }
          end
          new_config.cmd = cmd
        end,
      }

      lspconfig.yamlls.setup {
        settings = {
          yamlls = {
            schemas = {
              ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*'
            }
          }
        }
      }

      lspconfig.lua_ls.setup {
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
            },
            hint = { enable = true },
          },
        }
      }
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
          -- 'rubocop',
          -- 'standardrb',
          -- TypeScript
          'sorbet',
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

      -- require('mason-lspconfig').setup_handlers {
      --   function(server_name)
      --     vim.diagnostic.config({
      --       underline = true,
      --       signs = true,
      --       virtual_text = false,
      --       float = {
      --         show_header = true,
      --         source = 'always',
      --         border = 'rounded',
      --         focusable = true,
      --         focus = true,
      --         scope = 'line',
      --         format = function(diagnostic)
      --           if diagnostic.severity == vim.diagnostic.severity.ERROR then
      --             return string.format("%s (%s: s)", diagnostic.message, diagnostic.source, diagnostic.code)
      --           end
      --           return diagnostic.message
      --         end
      --       },
      --     })
      --
      --     require('lspconfig')[server_name].setup {
      --       capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
      --       on_attach = function(_, bufnr)
      --         local bufopts = { noremap = true, silent = true, buffer = bufnr }
      --
      --         vim.keymap.set('n', '<leader>fm', vim.lsp.buf.format, bufopts)
      --       end
      --     }
      --   end
      -- }
    end,
  },
  {
    'nvimdev/lspsaga.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    event = 'LspAttach',
    config = function()
      require('lspsaga').setup {
        border_style = 'single',
        ui = {
          code_action = '',
        },
        symbol_in_winbar = {
          enable = false,
        },
        outline = {
          win_width = 50,
          auto_preview = false,
        },
      }

      vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>')
      vim.keymap.set('n', 'gr', '<cmd>Lspsaga finder<CR>')
      vim.keymap.set('n', 'gi', '<cmd>Lspsaga finder imp<CR>')
      -- vim.keymap.set('n', 'gd', '<cmd>Lspsaga peek_definition<CR>')
      vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
      vim.keymap.set('n', 'gD', '<cmd>Lspsaga peek_definition<CR>')
      vim.keymap.set('n', 'ga', '<cmd>Lspsaga code_action<CR>')
      vim.keymap.set('n', 'ge', '<cmd>Lspsaga show_line_diagnostics<CR>')
      vim.keymap.set('n', 'gn', '<cmd>Lspsaga diagnostic_jump_next<CR>')
      vim.keymap.set('n', 'gp', '<cmd>Lspsaga diagnostic_jump_prev<CR>')
      vim.keymap.set('n', 'gt', '<cmd>Lspsaga term_toggle<CR>')
      vim.keymap.set('n', '<leader>rn', '<cmd>Lspsaga rename<CR>')
      vim.keymap.set('n', '<leader>to', '<cmd>Lspsaga outline<CR>')
    end
  },
  {
    'nvimtools/none-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = function(_, opts)
      local biome = require('null-ls').builtins.formatting.biome.with({
        command = 'biome',
      })
      opts.sources = vim.list_extend(opts.sources or {}, {
        biome
      })
    end,
    config = function()
      local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
      local null_ls = require('null-ls')

      null_ls.setup {
        on_attach = function(client, bufnr)
          if client.supports_method('textDocument/formatting') then
            vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format { bufnr = bufnr }
              end
            })
          end
        end,
        sources = {
        },
      }
    end,
  },
  -- {
  --   'j-hui/fidget.nvim',
  --   tag = 'legacy',
  --   event = 'LspAttach',
  --   config = function()
  --     require('fidget').setup {}
  --   end,
  -- },
  -- {
  --   'pmizio/typescript-tools.nvim',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     'neovim/nvim-lspconfig',
  --   },
  --   opts = {},
  --   config = function()
  --     require('typescript-tools').setup {
  --       settings = {
  --         tsserver_locale = 'ja',
  --         publish_diagnostic_on = 'change',
  --         tsserver_file_preferences = {
  --           includeCompletionsForModuleExports = true,
  --           includeInlayEnumMemberValueHints = true,
  --           includeInlayFunctionLikeReturnTypeHints = true,
  --           includeInlayFunctionParameterTypeHints = true,
  --           includeInlayParameterNameHints = 'all',
  --           includeInlayPropertyDeclarationTypeHints = true,
  --           includeInlayVariableTypeHints = true,
  --           quotePreference = 'auto',
  --         },
  --         tsserver_format_optiosn = {
  --           allowIncompleteCompletions = false,
  --           allowRenameOfImportPath = false,
  --         },
  --       },
  --     }
  --   end,
  -- },
}
