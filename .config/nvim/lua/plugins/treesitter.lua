return {
  {
    'nvim-treesitter/nvim-treesitter',
    event = 'InsertEnter',
    build = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'RRethy/nvim-treesitter-endwise',
    },
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          'bash',
          'c',
          'cpp',
          'css',
          'dart',
          'diff',
          'dockerfile',
          'fish',
          'go',
          'graphql',
          'html',
          'json',
          'lua',
          'markdown',
          'python',
          'prisma',
          'ruby',
          'terraform',
          'tsx',
          'typescript',
          'vim',
          'yaml',
        },
        endwise = {
          enable =false,
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = true,
        },
        auto_tag = {
          enable = true,
        },
        textobjects = {
          rainbow = { enabled = true, extended_mode = true, max_file_linex = 1500 },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              [']c'] = '@class.outer',
              [']]'] = '@function.outer',
            },
            goto_next_end = {
              [']C'] = '@class.outer',
              [']['] = '@function.outer',
            },
            goto_previous_start = {
              ['[c'] = '@class.outer',
              ['[['] = '@function.outer',
            },
            goto_previous_end = {
              ['[C'] = '@class.outer',
              ['[]'] = '@function.outer',
            },
          },
          select = {
            enable = true,

            -- Automatically jump forward to textobjects, similar to targets.vim
            lookahead = true,

            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ab'] = '@block.outer',
              ['ib'] = '@block.inner',
              ['ac'] = '@class.outer',
              -- you can optionally set descriptions to the mappings (used in the desc parameter of nvim_buf_set_keymap
              ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class region' },
            },
            -- You can choose the select mode (default is charwise 'v')
            selection_modes = {
              ['@parameter.outer'] = 'v', -- charwise
              ['@function.outer'] = 'V', -- linewise
              ['@class.outer'] = '<c-v>', -- blockwise
            },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`. Can also be a function (see above).
            include_surrounding_whitespace = true,
          },
        },
      }
    end,
  },
}
