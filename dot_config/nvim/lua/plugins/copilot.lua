return {
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    build = "npm install -g mcp-hub@latest",  -- Installs `mcp-hub` node binary globally
    config = function()
      require("mcphub").setup()
    end
  },

  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    keys = {
      { "<leader>cc", "<cmd>ClaudeCode<cr>",     desc = "Toggle Claude Code" },
      { "<leader>cs", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude Code" },
    },
  },

--   {
--     'olimorris/codecompanion.nvim',
--     config = true,
--     dependencies = {
--       'nvim-lua/plenary.nvim',
--       'nvim-treesitter/nvim-treesitter',
--     },
--     opts = {
--       opts = {
--         language = 'Japanese',
--         display = {
--           chat = {
--             window = {
--               layout = 'horizontal',
--             },
--           },
--         },
--         adapters = {
--           openai = function()
--             return require('codecompanion.adapters').extend("azure_openai", {
--               env = {
--                 api_key = os.getenv('OPENAI_API_KEY'),
--                 endpoint = os.getenv('OPENAI_API_ENDPOINT'),
--               },
--               schema = {
--                 model = {
--                   default = os.getenv('OPENAI_MODEL'),
--                 },
--               },
--             })
--           end,
--         },
--         strategies = {
--           chat = {
--             adapter = "openai",
--           },
--           inline = {
--             adapter = "openai",
--           },
--         },
--       },
--       extensions = {
--         mcphub = {
--           callback = "mcphub.extensions.codecompanion",
--           opts = {
--             show_result_in_chat = true,
--             make_vars = true,
--             make_slask_command = true,
--           },
--         },
--       },
--     },
--   }
}
