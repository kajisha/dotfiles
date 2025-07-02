return {
  'ojroques/nvim-osc52',
  config = function()
    local osc52 = require('osc52')
    local copy = function(lines, _) osc52.copy(table.concat(lines, '\n')) end
    local paste = function() return { vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('') } end

    vim.g.clipboard = {
      name = 'OSC52',
      copy = {
        ['+'] = copy,
        ['*'] = copy,
      },
      paste = {
        ['+'] = paste,
        ['*'] = paste,
      },
    }
  end
}
