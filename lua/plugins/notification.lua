return {
    {
        "rcarriga/nvim-notify",
        config = function()
            local notify = require("notify")
            notify.setup()

            vim.notify = notify

            vim.keymap.set("n", "<C-l>", function()
                require('telescope').extensions.notify.notify()
            end, { desc = "Open notifications history list" })
        end,
    },
}
