return {
    {
        "kristijanhusak/vim-dadbod-ui",
        dependencies = {
            { "tpope/vim-dadbod", lazy = true },
            { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
        },
        cmd = {
            "DBUI",
            "DBUIToggle",
            "DBUIAddConnection",
            "DBUIFindBuffer",
        },
        config = function()
            -- ad ogni query lanciata, il risultato non sara' in stato fold
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "dbout",
                callback = function()
                    vim.wo.foldenable = false
                end
            })
        end
    },
}
