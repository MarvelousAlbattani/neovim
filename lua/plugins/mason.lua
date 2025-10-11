-- ~/.config/nvim/lua/plugins/lsp.lua
return {
	-- Mason core
	{
		"williamboman/mason.nvim",
		config = true,
	},
	-- Mason + LSP integration
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "ts_ls", "angularls", "tailwindcss", "jdtls" }, 
				automatic_installation = true, -- auto-install any LSP we configure
			})

			vim.lsp.config("*", {
				capabilities = {
					textDocument = {
						semanticTokens = {
							multilineTokenSupport = true,
						},
					},
				},
				root_markers = { ".git" },
			})
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		dependencies = { "williamboman/mason.nvim", "nvimtools/none-ls.nvim" },
		config = function()
			require("mason-null-ls").setup({
				ensure_installed = { "prettier", "stylua", "eslint_d", "jq" },
				automatic_installation = true,
			})
		end,
	},
}
