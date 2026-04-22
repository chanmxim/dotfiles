vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.showbreak = "↪"
vim.opt.termguicolors = true

vim.g.have_nerd_font = true

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

require("config.lazy")
