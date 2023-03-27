vim.opt.termguicolors = true
vim.opt.autowrite = true
vim.opt.backspace = 'indent,eol,start'
vim.opt.fileencodings = 'ucs-bom,utf-8,iso-2022-jp,cp932,euc-jp,default,latin'
vim.opt.history = 50
vim.opt.incsearch = true
vim.opt.laststatus = 2
vim.opt.backup = false
vim.opt.number = false
vim.opt.swapfile = false
vim.opt.wrap = false
vim.opt.writebackup = false
vim.opt.ruler = true
vim.opt.showcmd = true
vim.opt.textwidth = 0
vim.opt.hidden = true

vim.opt.list = false
vim.opt.listchars = {tab='»·', trail='·', nbsp='·'}

vim.opt.joinspaces = false
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.diffopt:append{'vertical'}
