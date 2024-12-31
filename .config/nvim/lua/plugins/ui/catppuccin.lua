local M = {}
-- local catppuccin = require("catppuccin")

M = {
	"catppuccin/nvim",
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
		})
	end,
}

return M
