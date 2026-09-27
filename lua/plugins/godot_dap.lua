return {
	{
		"fm39hz/nvim-dap-godot-mono",
		dependencies = {
			"stevearc/overseer.nvim", -- Required for build tasks
			-- Note: nvim-dap is NOT listed here to avoid loading it too early.
			-- The plugin will load nvim-dap lazily when a C# file is opened.
		},
		ft = "cs",
		opts = {},
	},
}
