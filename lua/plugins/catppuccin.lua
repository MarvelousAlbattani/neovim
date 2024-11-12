return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
	    vim.cmd.colorscheme("catppuccin")

		local catppuccin = require("catppuccin")

		catppuccin.setup({
			transparent_background = false,
		})
	end,
}
