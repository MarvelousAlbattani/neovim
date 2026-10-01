return {
    {
        "marvelous-albattani/wildfly-handler",
        dir = vim.fn.stdpath("config") .. "/lua/wildfly",
        config = function()
            vim.api.nvim_create_user_command("WildflySetup", function()
                require("wildfly").setup()
            end, {})
            vim.api.nvim_create_user_command("WildflyStart", function()
                require("wildfly").start()
            end, {})
            vim.api.nvim_create_user_command("WildflyStop", function()
                require("wildfly").stop()
            end, {})
            vim.api.nvim_create_user_command("WildflyLogs", function()
                require("wildfly").logs()
            end, {})
        end
    }
}
