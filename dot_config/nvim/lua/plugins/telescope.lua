return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
      'otavioschwanck/telescope-alternate.nvim',
      'nvim-telescope/telescope-ghq.nvim',
      'nvim-telescope/telescope-github.nvim',
      'jvgrootveld/telescope-zoxide',
    },
    config = function()
      require('telescope').setup {
        defaults = {
          mappings = {
            i = { ['<C-t>'] = require('trouble.sources.telescope').open },
            n = { ['<C-t>'] = require('trouble.sources.telescope').open },
          },
        },
        extensions = {
          file_browser = {
            theme = 'ivy',
            hijack_netrw = true,
          },
          ['telescope-alternate'] = {
            presets = { 'rails', 'rspec' },
            mappings = {
              {
                pattern = 'app/graphql/**/(.*).rb',
                targets = {
                  { template = 'spec/graphql/**/[1]_spec.rb',           label = 'Mutation Spec', enable_new = true },
                  { template = 'spec/graphql/types/query_type_spec.rb', label = 'Query Spec' },
                },
              },
              {
                pattern = 'app/interactors/(.*)_context.rb',
                targets = {
                  { template = 'app/interactors/[1].rb', label = 'Interactor' }
                },
              },
              {
                pattern = 'app/interactors/(.*).rb',
                targets = {
                  { template = 'app/interactors/[1]_context.rb', label = 'Context', enable_new = false }
                },
              },
              {
                pattern = 'app/models/user_tasks/(.*).rb',
                targets = {
                  { template = 'db/schemas/main/user_tasks.schema', label = 'Schema' }
                },
              },
              {
                pattern = 'app/models/(.*).rb',
                targets = {
                  { template = 'spec/models/**/[1]_spec.rb',         label = 'Model Spec' },
                  { template = 'db/schemas/**/[1:pluralize].schema', label = 'Schema' },
                  { template = 'db/schema.rb',                       label = 'Schema' },
                  { template = 'spec/factories/**/[1:pluralize].rb', label = 'FactoryBot' },
                },
              },
              {
                pattern = 'spec/factories/**/(.*).rb',
                targets = {
                  { template = 'app/models/**/[1:singularize].rb',       label = 'Model' },
                  { template = 'spec/models/**/[1:singularize]_spec.rb', label = 'Model Spec' },
                  { template = 'db/schemas/**/[1].schema',               label = 'Schema' },
                  { template = 'db/schema.rb',                           label = 'Schema' },
                },

              },
              {
                pattern = 'db/schemas/**/(.*).schema',
                targets = {
                  { template = 'app/models/*[1:singularize]*.rb', label = 'Model' }
                },
              },
              {
                pattern = 'app/services/**/(.*).rb',
                targets = {
                  { template = 'spec/services/**/[1]_spec.rb', label = 'Service Spec', enable_new = true }
                },
              },
              {
                pattern = 'app/entities/**/*.rb',
                targets = {
                  { template = 'spec/entities/**/*.rb', label = 'Entity Spec' }
                },
              },
              {
                pattern = 'app/controllers(.*)/(.*)_controller.rb',
                targets = {
                  { template = 'app/views/**/[2]/*.html.slim', label = 'View' },
                  { template = 'spec/requests/**/[2]_spec.rb', label = 'Request Spec' }
                }
              },
            },
            telescope_mappings = {
              i = {
                open_horizontal = '<CR>',
              },
              n = {
                open_horizontal = '<CR>',
              },
            },
          },
        }
      }

      require('telescope').load_extension 'file_browser'
      require('telescope').load_extension 'telescope-alternate'
      require('telescope').load_extension 'ghq'
      require('telescope').load_extension 'textcase'
      require('telescope').load_extension 'zoxide'
    end,
    cmd = {
      'Telescope',
    },
    keys = {
      -- { mode = 'n', '<leader>ff', ':Telescope find_files<CR>' },
      -- { mode = 'n', '<leader>fg', ':Telescope grep_string<CR>' },
      -- { mode = 'n', '<leader>fB', ':Telescope buffers<CR>' },
      -- { mode = 'n', '<leader>fb', ':Telescope file_browser<CR>',                       noremap = true },
      { mode = 'n', '<leader>fa', ':Telescope telescope-alternate alternate_file<CR>', noremap = true },
      { mode = 'n', '<leader>fk', ':Telescope keymaps<CR>',                            noremap = true },
      { mode = 'n', '<leader>fG', ':Telescope ghq list<CR>',                           noremap = true },
      { mode = 'n', '<leader>fz', ':Telescope zoxide list<CR>',                           noremap = true },
      -- { mode = 'n', '<leader>fo', ':Telescope oldfiles<CR>',                           noremap = true },
      { mode = 'n', 'ga.',        ':TextCaseOpenTelescope<CR>',                        desc = 'telescope' },
      { mode = 'v', 'ga.',        ':TextCaseOpenTelescope<CR>',                        desc = 'telescope' },
    },
  },
  {
    'johmsalas/text-case.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
      require("textcase").setup({})
      require("telescope").load_extension("textcase")
    end,
    keys = {
      'cr', -- Default invocation prefix
      { 'crs', '<cmd>TextCaseOpenTelescope<CR>', mode = { 'n', 'x' }, desc = 'Telescope' },
    },
    cmd = {
      -- NOTE: The Subs command name can be customized via the option "substitude_command_name"
      "Subs",
      "TextCaseOpenTelescope",
      "TextCaseOpenTelescopeQuickChange",
      "TextCaseOpenTelescopeLSPChange",
      "TextCaseStartReplacingCommand",
    },
    -- If you want to use the interactive feature of the `Subs` command right away, text-case.nvim
    -- has to be loaded on startup. Otherwise, the interactive feature of the `Subs` will only be
    -- available after the first executing of it or after a keymap of text-case.nvim has been used.
    lazy = false,
  },
}
