return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'otavioschwanck/telescope-alternate.nvim',
      'nvim-telescope/telescope-ghq.nvim',
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
              i = { open_horizontal = '<CR>' },
              n = { open_horizontal = '<CR>' },
            },
          },
        }
      }

      require('telescope').load_extension 'telescope-alternate'
      require('telescope').load_extension 'ghq'
      require('telescope').load_extension 'textcase'
    end,
    cmd = { 'Telescope' },
    keys = {
      { mode = 'n', '<leader>fa', ':Telescope telescope-alternate alternate_file<CR>', noremap = true },
      { mode = 'n', '<leader>fG', ':Telescope ghq list<CR>',                           noremap = true },
      { mode = 'n', 'ga.',        ':TextCaseOpenTelescope<CR>',                        desc = 'Telescope' },
      { mode = 'v', 'ga.',        ':TextCaseOpenTelescope<CR>',                        desc = 'Telescope' },
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
      'cr',
      { 'crs', '<cmd>TextCaseOpenTelescope<CR>', mode = { 'n', 'x' }, desc = 'Telescope' },
    },
    cmd = {
      "Subs",
      "TextCaseOpenTelescope",
      "TextCaseOpenTelescopeQuickChange",
      "TextCaseOpenTelescopeLSPChange",
      "TextCaseStartReplacingCommand",
    },
    lazy = false,
  },
}
