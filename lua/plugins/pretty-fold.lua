return {
	"anuvyklack/pretty-fold.nvim",
	config = function()
		require("pretty-fold").setup({
			sections = {
				left = {
					"content",
				},
				right = {
					" ",
					"number_of_folded_lines",
					": ",
					"percentage",
					" ",
					function(config)
						return config.fill_char:rep(3)
					end,
				},
			},
			fill_char = "•",
			remove_fold_markers = true,
			keep_indentation = true,
			process_comment_signs = "spaces",
			comment_signs = {},
			stop_words = {
				"@brief%s*",
			},
			add_close_pattern = true,
			matchup_patterns = {
				{ "{", "}" },
				{ "%(", ")" },
				{ "%[", "]" },
			},
			ft_ignore = { "neorg" },
		})
	end,
}
