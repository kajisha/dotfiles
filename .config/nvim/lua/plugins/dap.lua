return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'suketa/nvim-dap-ruby',
    },
    config = function()
      require('dap-ruby').setup {}
    end
  },

  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio',
    },
  }
}
