vim.cmd.packadd 'packer.nvim'

require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim', opt = true }
  use 'nvim-tree/nvim-web-devicons'
  use {
    'luisiacc/gruvbox-baby',
    config = function()
      vim.g.gruvbox_baby_background_color = 'dark'
      vim.g.gruvbox_baby_telescope_theme = 1

      vim.cmd [[colorscheme gruvbox-baby]]
    end
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = function()
      require('lualine').setup()
    end
  }

  use 'editorconfig/editorconfig-vim'

  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
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
          'json',
          'lua',
          'markdown',
          'ruby',
          'tsx',
          'vim',
        },
        endwise = {
          enable = true,
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = true,
        },
      }
    end
  }
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    requires = { 'nvim-treesitter/nvim-treesitter' },
  }
  use {
    'RRethy/nvim-treesitter-endwise',
    requires = { 'nvim-treesitter/nvim-treesitter' },
  }
  use {
    'andymass/vim-matchup',
    setup = function()
      vim.g.matchup_matchparen_offscreen = { method = 'popup' }
    end
  }

  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {}
    end
  }
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
  use {
    'kylechui/nvim-surround',
    require('nvim-surround').setup {
      -- Configuration here, or leave empty to use defaults
    }
  }
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require("indent_blankline").setup {
        context_patterns = {
          'body', 'class', 'function', 'method', 'block', 'list_literal', 'selector',
          '^if', '^table', 'if_statement', 'while', 'for', 'type', 'var',
          'import', 'declaration', 'expression', 'pattern', 'primary_expression',
          'statement', 'switch_body'
        },
        space_char_blankline = ' ',
        show_end_of_line = true,
        show_current_context = true,
        show_current_context_start = true,
      }
    end
  }

  -- Git plugins
  use 'lewis6991/gitsigns.nvim'
  use {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>gs', ':Gstatus<CR>', { noremap = true })
      vim.keymap.set('n', '<leader>gb', ':Git blame<CR>', { noremap = true })
      vim.keymap.set('n', '<leader>gB', ':GBrowse<CR>', { noremap = true })
      vim.keymap.set('n', '<leader>gca', ':Git commit --amend<CR>', { noremap = true })
      vim.keymap.set('n', '<leader>gc', ':Git commit -v -q<CR>', { noremap = true })
      vim.keymap.set('n', '<leader>gd', ':Gdiffsplit<CR>', { noremap = true })
      vim.keymap.set('n', '<leader>ga', ':Gwrite<CR>', { noremap = true })
      vim.keymap.set('n', '<leader>gr', ':Gread<CR>', { noremap = true })
      vim.keymap.set('n', '<leader>gp', ':Git push<CR>', { noremap = true })
      vim.keymap.set('n', '<leader>gl', ':Glog -- %<CR>', { noremap = true })
    end
  }
  use 'tpope/vim-rhubarb'

  -- LSP, Linter, Formatter, etc.
  use 'neovim/nvim-lspconfig'
  use {
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
    end
  }
  use {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      local nvim_lsp = require('lspconfig')
      local mason_lspconfig = require('mason-lspconfig')

      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

      mason_lspconfig.setup_handlers {
        function(server_name)
          local opts = {}
          opts.on_attach = function(_, bufnr)
            local bufopts = { noremap = true, silent = true, buffer = bufnr }

            vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
            vim.keymap.set('n', 'gD', vim.lsp.buf.type_definition, bufopts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
            vim.keymap.set('n', 'gf', function()
              vim.lsp.buf.format { async = true }
            end, bufopts)

            vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()]]
          end
          nvim_lsp[server_name].setup(opts)
        end
      }

      nvim_lsp.lua_ls.setup {
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
            }
          }
        }
      }

    end
  }

  use {
    'folke/trouble.nvim',
    requires = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('trouble').setup {}

      vim.keymap.set('n', '<leader>xx', ':TroubleToggle<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>xw', ':TroubleToggle workspace_diagnostics<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>xd', ':TroubleToggle document_diagnostics<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>xl', ':TroubleToggle loclist<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>xq', ':TroubleToggle quickfix<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', 'gR', ':TroubleToggle lsp_references<CR>', { noremap = true, silent = true })
    end
  }

  -- Completion
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use {
    'hrsh7th/nvim-cmp',
    config = function()
      local cmp = require('cmp')
      cmp.setup {
        snippet = {
          expand = function(args)
            vim.fn['vsnip#anonymous'](args.body)
          end
        },
        window = {
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
        sources = cmp.config.sources {
          { name = 'nvim_lsp' },
          { name = 'vsnip' },
        }, {
        { name = 'buffer' },
      }
      }
    end
  }
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'

  -- Telescope.nvim
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    requires = {
      { 'nvim-lua/plenary.nvim' },
    },
    config = function()
      vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>', {})
      vim.keymap.set('n', '<leader>fg', ':Telescope grep_string<CR>', {})
      vim.keymap.set('n', '<leader>fB', ':Telescope buffers<CR>', {})
      vim.keymap.set('n', '<leader>fb', ':Telescope file_browser<CR>', { noremap = true })
    end
  }
  use {
    'nvim-telescope/telescope-file-browser.nvim',
    requires = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('telescope').setup {
        extensions = {
          file_browser = {
            theme = 'ivy',
            hijack_netrw = true,
            -- mappings = {
            --   ['i'] = {
            --     -- insert mode mappings
            --   },
            --   ['n'] = {
            --     -- normal mode mappings
            --   },
            -- }
          }
        }
      }
      require('telescope').load_extension 'file_browser'
    end
  }

  -- neotest
  use {
    'nvim-neotest/neotest',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',
      'olimorris/neotest-rspec',
    },
    config = function()
      require('neotest').setup({
        adapters = {
          require('neotest-rspec'),
        }
      })
    end
  }
end)
