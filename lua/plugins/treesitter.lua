return {
	'nvim-treesitter/nvim-treesitter',
    config = function()
        local config = require("nvim-treesitter.configs")
        config.setup({
            ensure_install = { "lua", "typescript" },
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true }
        })
    end
}
