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
