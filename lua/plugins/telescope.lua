return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = function()
			return {
				{
					"<C-p>",
					"<cmd>Telescope find_files<cr>",
					desc = "Telescope file finder",
				},
				{
					"<C-h>",
					"<cmd>Telescope live_grep<cr>",
					desc = "Telescope live grep",
				},
			}
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
