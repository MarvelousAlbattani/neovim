-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
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
        -- avoid showing neotree when query result appears
        if vim.bo.filetype ~= "" and vim.bo.filetype ~= "dbout" then
            vim.cmd("Neotree reveal")
        end
    end,
})

local pipepath = vim.fn.stdpath("cache") .. "/server.pipe"
if not vim.loop.fs_stat(pipepath) then
    vim.fn.serverstart(pipepath)
end
-- Reveal file in neotree
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("Neotree reveal")
end, { desc = "Reveal file in Neotree" })

-- without this, pressing n will select everything
vim.keymap.set("n", "n", function() end, { desc = "avoid selecting everything" })
-- show all the commands from plugins
vim.keymap.set("n", "<leader>c", function()
    vim.cmd("Telescope commands")
end, { desc = "Show all commands" })

-- Error handling, if length is grater than 80 do not show
vim.diagnostic.config({
    virtual_text = {
        spacing = 2,
        prefix = "●",
        format = function(diagnostic)
            local msg = diagnostic.message

            if #msg > 80 then
                return nil
            else
                return msg
            end
        end,
    },
    float = {
        border = "rounded",
        max_width = 80,
        max_height = 20,
        wrap = true,
    },
})

vim.o.updatetime = 300

-- Error handling if grater than 80 show error inside a popup
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local cursor = vim.api.nvim_win_get_cursor(0) -- {line, col}
    local cursor_line = cursor[1] - 1 -- convert to 0-indexed line

    -- Get diagnostics only for the current line
    local diagnostics = vim.diagnostic.get(bufnr, { lnum = cursor_line })

    for _, diag in ipairs(diagnostics) do
      if #diag.message > 80 then
        vim.diagnostic.open_float(nil, {
          focusable = false,
          border = "rounded",
          max_width = 80,
          wrap = true,
        })
        break -- show only once per line
      end
    end
  end,
})
