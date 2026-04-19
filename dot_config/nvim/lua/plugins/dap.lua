return {
  {
    'mfussenegger/nvim-dap',
    dependencies = { 'suketa/nvim-dap-ruby' },
    keys = {
      { '<leader>dc', function() require('dap').continue() end,                                                        desc = 'Continue' },
      { '<leader>dn', function() require('dap').step_over() end,                                                       desc = 'Step over' },
      { '<leader>di', function() require('dap').step_into() end,                                                       desc = 'Step into' },
      { '<leader>do', function() require('dap').step_out() end,                                                        desc = 'Step out' },
      { '<leader>db', function() require('dap').toggle_breakpoint() end,                                               desc = 'Toggle breakpoint' },
      { '<leader>dB', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,            desc = 'Conditional breakpoint' },
      { '<leader>dr', function() require('dap').repl.open() end,                                                       desc = 'REPL' },
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
    keys = {
      { '<leader>du', function() require('dapui').toggle() end, desc = 'DAP UI toggle' },
    },
    config = function()
      require('dapui').setup {}
    end,
  },
}
