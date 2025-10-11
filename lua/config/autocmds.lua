-- Open neotree by default
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		require("neo-tree.command").execute({})
	end,
})

-- Reveal file in neotree when opened
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	callback = function(args)
		local ft = vim.bo[args.buf].filetype
		-- Skip special buffers or plugin windows
		if ft ~= "" and ft ~= "neo-tree" and ft ~= "dbout" then
			-- Delay slightly to ensure the buffer is fully loaded
			vim.schedule(function()
				vim.cmd("Neotree reveal")
			end)
		end
	end,
})
