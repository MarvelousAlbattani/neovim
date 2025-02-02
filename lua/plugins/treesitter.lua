return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			local config = require("nvim-treesitter.configs")
			config.setup({
				ensure_install = {
					"lua",
					"typescript",
					"rust",
					"sql",
					"html",
					"javascript",
					"css",
					"json",
					"yaml",
					"tsx",
				},
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
}
