return {
  'saghen/blink.cmp',
  version = '1.*',
  opts = {
    keymap = {
      preset = 'default',
      ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
      ['<C-y>'] = { 'show', 'fallback' },
      ['<C-e>'] = { 'cancel', 'fallback' },
      ['<CR>'] = { 'accept', 'fallback' },
    },
    appearance = {
      nerd_font_variant = 'mono',
    },
    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
    },
    sources = {
      default = { 'lsp', 'path', 'buffer', 'snippets' },
    },
    signature = { enabled = true },
  },
}
