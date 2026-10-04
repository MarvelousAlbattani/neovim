-- ~/.config/nvim/lua/plugins/lsp.lua
return {
	-- Mason core
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
        end,
	},
	-- Mason + LSP integration
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { 
                    "ts_ls", 
                    "angularls", 
                    "tailwindcss", 
                    "jdtls", 
                    "csharp_ls",
                }, 
				automatic_installation = true,
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
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = { 
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap",
        },
		config = function()
			require("mason-nvim-dap").setup({
                -- https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua
				ensure_installed = { 
                    "javadbg",
                    "netcoredbg",
                }, 
				automatic_installation = true,
			})
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		dependencies = { 
            "williamboman/mason.nvim", 
            "nvimtools/none-ls.nvim",
        },
		config = function()
			require("mason-null-ls").setup({
				ensure_installed = { 
                    "prettier", 
                    "stylua", 
                    "eslint_d", 
                    "jq", 
                },
				automatic_installation = true,
			})
		end,
	},
}

