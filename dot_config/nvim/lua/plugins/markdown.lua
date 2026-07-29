return {
  {
    "3rd/diagram.nvim",
    dependencies = {
      { "3rd/image.nvim", opts = {} }, -- you'd probably want to configure image.nvim manually instead of doing this
    },
    opts = { -- you can just pass {}, defaults below
      events = {
        render_buffer = { "InsertLeave", "BufWinEnter", "TextChanged" },
        clear_buffer = {"BufLeave"},
      },
      renderer_options = {
        mermaid = {
          background = nil, -- nil | "transparent" | "white" | "#hex"
          theme = nil, -- nil | "default" | "dark" | "forest" | "neutral"
          scale = 1, -- nil | 1 (default) | 2  | 3 | ...
          width = nil, -- nil | 800 | 400 | ...
          height = nil, -- nil | 600 | 300 | ...
          cli_args = nil, -- nil | { "--no-sandbox" } | { "-p", "/path/to/puppeteer" } | ...
        },
        plantuml = {
          charset = nil,
          cli_args = nil, -- nil | { "-Djava.awt.headless=true" } | ...
        },
        d2 = {
          theme_id = nil,
          dark_theme_id = nil,
          scale = nil,
          layout = nil,
          sketch = nil,
          cli_args = nil, -- nil | { "--pad", "0" } | ...
        },
        gnuplot = {
          size = nil, -- nil | "800,600" | ...
          font = nil, -- nil | "Arial,12" | ...
          theme = nil, -- nil | "light" | "dark" | custom theme string
          cli_args = nil, -- nil | { "-p" } | { "-c", "config.plt" } | ...
        },
      }
    },
    keys = {
      {
        "K",
        function()
          require('diagram').show_diagram_hover()
        end,
        mode = "n",
        ft = { "markdwon", "norg" },
        desc = "Show diagram in new tab",
      }
    },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" },            -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module "render-markdown"
    ---@type render.md.UserConfig
    opts = {},
  },
}
