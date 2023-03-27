local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  {
    'ojroques/nvim-osc52',
    config = function()
      local osc52 = require('osc52')
      local copy = function(lines, _) osc52.copy(table.concat(lines, '\n')) end
      local paste = function() return { vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('') } end

      vim.g.clipboard = {
        name = 'OSC52',
        copy = {
          ['+'] = copy,
          ['*'] = copy,
        },
        paste = {
          ['+'] = paste,
          ['*'] = paste,
        },
      }
    end
  },

  {
    'sainnhe/gruvbox-material',
    config = function()
      vim.opt.background = 'dark'

      vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_material_background = 'hard'

      vim.cmd [[colorscheme gruvbox-material]]
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'gruvbox-material',
        }
      }
    end,
  },
  {
    'editorconfig/editorconfig-vim',
    event = 'InsertEnter',
  },

  {
    'nvim-treesitter/nvim-treesitter',
    event = 'InsertEnter',
    build = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/nvim-treesitter-context',
      'RRethy/nvim-treesitter-endwise',
    },
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          'bash',
          'c',
          'cpp',
          'dart',
          'diff',
          'dockerfile',
          'fish',
          'go',
          'graphql',
          'json',
          'lua',
          'markdown',
          'python',
          'ruby',
          'tsx',
          'vim',
          'yaml',
        },
        endwise = {
          enable = true,
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = true,
        },
      }
    end,
  },

  {
    'andymass/vim-matchup',
    event = 'InsertEnter',
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = 'popup' }
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup {}
    end,
  },
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup {}
    end,
  },
  {
    'kylechui/nvim-surround',
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup {}
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('indent_blankline').setup {
        context_patterns = {
          'body', 'class', 'function', 'method', 'block', 'list_literal', 'selector',
          '^if', '^table', 'if_statement', 'while', 'for', 'type', 'var',
          'import', 'declaration', 'expression', 'pattern', 'primary_expression',
          'statement', 'switch_body', 'do_block', 'tuple', 'element',
          'dictionary', 'arguments', 'argument_list',
        },
        space_char_blankline = ' ',
        show_current_context = true,
        show_current_context_start = true,
        use_treesitter_scope = true,
      }
    end,
  },

  -- Git plugins
  'lewis6991/gitsigns.nvim',
  {
    'tpope/vim-fugitive',
    dependencies = { 'tpope/vim-rhubarb' },
    keys = {
      { mode = 'n', '<leader>gs',  ':Gstatus<CR>',            noremap = true },
      { mode = 'n', '<leader>gb',  ':Git blame<CR>',          noremap = true },
      { mode = 'n', '<leader>gB',  ':GBrowse<CR>',            noremap = true },
      { mode = 'n', '<leader>gca', ':Git commit --amend<CR>', noremap = true },
      { mode = 'n', '<leader>gc',  ':Git commit -v -q<CR>',   noremap = true },
      { mode = 'n', '<leader>gd',  ':Gdiffsplit<CR>',         noremap = true },
      { mode = 'n', '<leader>ga',  ':Gwrite<CR>',             noremap = true },
      { mode = 'n', '<leader>gr',  ':Gread<CR>',              noremap = true },
      { mode = 'n', '<leader>gp',  ':Git push<CR>',           noremap = true },
      { mode = 'n', '<leader>gl',  ':Glog -- %<CR>',          noremap = true },
    },
  },

  -- LSP, Linter, Formatter, etc.
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require('lspconfig')

      -- See https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

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
            }
          },
        }
      }

      lspconfig.solargraph.setup {
        settings = {
          diagnostics = false
        }
      }

      lspconfig.pyright.setup {
        settings = {
          python = {
            venvpath = '.',
            pythonPath = './.venv/bin/python',
            analysis = {
              extraPaths = { '.' },
            },
          }
        }
      }

      lspconfig.graphql.setup {}

      lspconfig.docker_compose_language_service.setup {
        root_dir = lspconfig.util.root_pattern('docker-compose.yml', 'docker-compose.yaml')
      }

      lspconfig.dockerls.setup {}
      lspconfig.terraformls.setup {}
    end,
  },
  {
    'williamboman/mason.nvim',
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
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup_handlers {
        function(server_name)
          vim.diagnostic.config({
            underline = true,
            signs = true,
            virtual_text = false,
            float = {
              show_header = true,
              source = 'always',
              border = 'rounded',
              focusable = true,
              focus = true,
              scope = 'line',
              format = function(diagnostic)
                if diagnostic.severity == vim.diagnostic.severity.ERROR then
                  return string.format("%s (%s: s)", diagnostic.message, diagnostic.source, diagnostic.code)
                end
                return diagnostic.message
              end
            },
          })

          vim.keymap.set('n', 'ge', vim.diagnostic.open_float, { noremap = true, silent = true })
          vim.keymap.set('n', 'gp', vim.diagnostic.goto_prev, { noremap = true, silent = true })
          vim.keymap.set('n', 'gn', vim.diagnostic.goto_next, { noremap = true, silent = true })

          require('lspconfig')[server_name].setup {
            on_attach = function(_, bufnr)
              local bufopts = { noremap = true, silent = true, buffer = bufnr }

              vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
              vim.keymap.set('n', 'gD', vim.lsp.buf.type_definition, bufopts)
              vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
              vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
              vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
              vim.keymap.set('n', '<leader>fm', vim.lsp.buf.format, bufopts)
            end
          }
        end
      }
    end,
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
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
          -- rubocop
          null_ls.builtins.diagnostics.rubocop.with {
            prefer_local = 'bundle exec rubocop',
            condition = function(utils)
              return utils.root_has_file { '.rubocop.yml' }
            end
          },
          null_ls.builtins.formatting.rubocop.with {
            prefer_local = 'bundle exec rubocop',
            condition = function(utils)
              return utils.root_has_file { '.rubocop.yml' }
            end
          },
        }
      }
    end,
  },

  {
    'folke/trouble.nvim',
    lazy = true,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { mode = 'n', '<leader>xx', ':TroubleToggle<CR>',                       noremap = true, silent = true },
      { mode = 'n', '<leader>xw', ':TroubleToggle workspace_diagnostics<CR>', noremap = true, silent = true },
      { mode = 'n', '<leader>xd', ':TroubleToggle document_diagnostics<CR>',  noremap = true, silent = true },
      { mode = 'n', '<leader>xl', ':TroubleToggle loclist<CR>',               noremap = true, silent = true },
      { mode = 'n', '<leader>xq', ':TroubleToggle quickfix<CR>',              noremap = true, silent = true },
      { mode = 'n', 'gR',         ':TroubleToggle lsp_references<CR>',        noremap = true, silent = true },
    },
  },

  -- Completion
  {
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
    },
    config = function()
      local cmp = require('cmp')

      cmp.setup({
        windows = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
        }, {
          { name = 'buffer' },
        }),
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })
    end,
  },

  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
      'otavioschwanck/telescope-alternate.nvim',
    },
    config = function()
      require('telescope').setup {
        extensions = {
          file_browser = {
            theme = 'ivy',
            hijack_netrw = true,
          },
          ['telescope-alternate'] = {
            presets = { 'rails', 'rspec' }
          },
        }
      }

      require('telescope').load_extension 'file_browser'
      require('telescope').load_extension 'telescope-alternate'
    end,
    cmd = {
      'Telescope',
    },
    keys = {
      { mode = 'n', '<leader>ff', ':Telescope find_file<CR>' },
      { mode = 'n', '<leader>fg', ':Telescope grep_string<CR>' },
      { mode = 'n', '<leader>fB', ':Telescope buffers<CR>' },
      { mode = 'n', '<leader>fb', ':Telescope file_browser<CR>',                       noremap = true },
      { mode = 'n', '<leader>fa', ':Telescope telescope-alternate alternate_file<CR>', noremap = true },
      { mode = 'n', '<leader>fk', ':Telescope keymaps<CR>',                            noremap = true },
    },
  },
  {
    'nvim-neotest/neotest',
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',
      'olimorris/neotest-rspec',
    },
    config = function()
      local neotest = require('neotest')

      neotest.setup {
        adapters = {
          require('neotest-rspec'),
        },
        quickfix = {
          open = false,
          enabled = false,
        },
        status = {
          enabled = true,
          sign = true,
          virtual_text = false,
        },
        icons = {
          child_indent = '│',
          child_prefix = '├',
          collapsed = '─',
          expanded = '╮',
          failed = '✘',
          final_child_indent = ' ',
          final_child_prefix = '╰',
          non_collapsible = '─',
          passed = '✓',
          running = '',
          running_animated = { '/', '|', '\\', '-', '/', '|', '\\', '-' },
          skipped = '↓',
          unknown = ''
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

      vim.keymap.set('n', 'tt',
        function()
          neotest.run.run()
          neotest.summary.open()
          -- neotest.output.open({ last_run = true, enter = true })
        end, keymap_ops)
      vim.keymap.set('n', 'tT',
        function()
          neotest.run.run(vim.fn.expand("%"))
          neotest.output.open({ last_run = true, enter = true })
        end, keymap_ops)
      vim.keymap.set('n', 'tS',
        function()
          neotest.run.run(vim.fn.getcwd())
          neotest.output.open({ last_run = true, enter = true })
        end, keymap_ops)
      vim.keymap.set('n', 'ts',
        function()
          neotest.summary.toggle()
        end, keymap_opts)
      vim.keymap.set('n', 'to',
        function()
          neotest.output.open({ last_run = true, enter = true })
        end, keymap_ops)
    end,
  }
}
