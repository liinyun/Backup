local M = {}
-- local catppuccin = require("catppuccin")

M = {
	"catppuccin/nvim",
	event = "BufReadPre",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
			background = {
				dark = "mocha",
				light = "frappe",
			},
			transparent_background = true,
			show_end_of_buffer = true,
			rainbow_delimiters = true,
		})
	end,
}

return M
