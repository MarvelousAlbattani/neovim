-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.q
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = "`"
vim.g.maplocalleader = "``"

-- line numbers
vim.wo.relativenumber = true
vim.wo.number = true

-- tabs
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

-- Setup lazy.nvim
require("lazy").setup("plugins")

-- Open neotree by default
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		require("neo-tree.command").execute({})
	end,
})

-- Reveal file in neotree when opened
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        vim.cmd('Neotree reveal')
    end
})

local pipepath = vim.fn.stdpath("cache") .. "/server.pipe"
if not vim.loop.fs_stat(pipepath) then
	vim.fn.serverstart(pipepath)
end

-- without this, pressing n will select everything
vim.keymap.set('n', 'n', function() end, { desc = "avoid selecting everything" })
