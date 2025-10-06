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
