return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'suketa/nvim-dap-ruby',
      'mfussenegger/nvim-dap-python',
    },
    config = function()
      require('dap-ruby').setup {}
      require('dap-python').setup('python')
    end,
    keys = {
      { mode = 'n', '<leader>dn', '<cmd>lua require("dap-python").test_method()<CR>' },
    },
  },

  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio',
    },
  },
}
