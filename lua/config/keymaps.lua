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
