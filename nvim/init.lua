require("config.lazy")
require("keymaps")
require("settings")

vim.cmd [[colorscheme tokyonight]]

vim.opt.lazyredraw = true
vim.opt.synmaxcol = 240
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
