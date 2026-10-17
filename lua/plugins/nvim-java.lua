return {
	{
		"nvim-java/nvim-java",
		config = function()
			require("java").setup()
			vim.lsp.enable("jdtls")

			vim.keymap.set("n", "<leader>jc", "<cmd>JavaBuildCleanWorkspace<CR>", { desc = "Build and clean java workspace" })
			vim.keymap.set("n", "<leader>jb", "<cmd>JavaBuildWorkspace<CR>", { desc = "Build java workspace" })
            vim.keymap.set("n", "<leader>jr", "<cmd>JavaRunnerRunMain<CR>", { desc = "Runs java main class"})
            vim.keymap.set("n", "<leader>jp", "<cmd>JavaProfile<CR>", { desc = "Opens java profile window"})
		end,
	},
}
