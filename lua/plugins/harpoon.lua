return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            local harpoon = require("harpoon")

            -- REQUIRED
            harpoon:setup()
            -- REQUIRED

            vim.keymap.set("n", "<C-a>", function()
                harpoon:list():add()
            end)
            vim.keymap.set("n", "<C-m>", function()
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end)
            vim.keymap.set("n", "<CR>", function()
                -- nothing to disable menu open on enter
            end)
        end,
    },
}
