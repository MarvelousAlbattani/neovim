return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	keys = function()
		return {
			{
				"<C-e>",
				'<cmd>Neotree source=filesystem reveal=true position=left toggle=true<CR>',
				desc = "Neotree toggle",
			},
		}
	end,
	config = function()
		require("neo-tree").setup({
			visible = true,
			close_if_last_window = false,
			popup_border_style = "rounded",
			enable_git_status = true,
			enable_diagnostics = true,
			default_component_cs = {
				container = {
					enable_character_fade = true,
				},
				git_status = {
					symbols = {
						added = "✚",
						modified = "",
						deleted = "✖",
						renamed = "󰁕",
						untracked = "",
						ignored = "",
						unstaged = "󰄱",
						staged = "",
						conflict = "",
					},
				},
			},
		})
	end,
}
