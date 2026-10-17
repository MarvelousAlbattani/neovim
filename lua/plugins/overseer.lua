return {
	{
		"stevearc/overseer.nvim",
		opts = {},
		config = function(_, opts)
			local overseer = require("overseer")
			overseer.setup(opts)

			vim.keymap.set("n", "<leader>os", "<cmd>OverseerRun<CR>", { desc = "Run Overseer task" })
			vim.keymap.set("n", "<leader>ot", "<cmd>OverseerToggle<CR>", { desc = "Toggle Overseer Window" })

			overseer.register_template({
				name = "Maven package",
				builder = function(params)
					return {
						cmd = { "mvn" },
						args = { "clean", "package" },
						components = { "default" },
					}
				end,
			})
		end,
	},
}
