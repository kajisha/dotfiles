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
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
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
      require('Comment').setup {}
    end
  }
  use {
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup {}
    end
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
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'

  -- LSP, Linter, Formatter, etc.
  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'

  use {
    'folke/trouble.nvim',
    requires = { 'nvim-tree/nvim-web-devicons' },
  }

  -- Completion
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'

  -- Telescope.nvim
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    requires = {
      { 'nvim-lua/plenary.nvim' },
    },
  }
  use {
    'nvim-telescope/telescope-file-browser.nvim',
    requires = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim',
    },
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
