-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.q
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = "`"
vim.g.maplocalleader = "``"

vim.opt.relativenumber = true
vim.opt.number = true

-- tabs
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.g.lazyvim_prettier_needs_config = false
