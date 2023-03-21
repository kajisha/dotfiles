require('mason').setup {
  ui = {
    icons = {
      package_installed = '✓',
      package_pending = '➜',
      package_uninstalled = '✗'
    }
  }
}

local nvim_lsp = require('lspconfig')

nvim_lsp.lua_ls.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      }
    }
  }
}

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

require('mason-lspconfig').setup_handlers {
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
