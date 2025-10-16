-- Indentation guides
local M = {}
M = {
	-- https://github.com/lukas-reineke/indent-blankline.nvim
	"lukas-reineke/indent-blankline.nvim",

	event = "VeryLazy",

	config = function()
		-- this is two highlight used in hte indent below
		-- CursorColumn just show blur effect
		-- whitespace shows noting, I think this is really cool, so I wiil not
		-- delete them. I will just comment them this config can be found in
		-- indent-blankline nvim github

		-- create the highlight groups in the highlight setup hook, so they are reset
		local highlight = {
			"CursorColumn",
			"Whitespace",
		}
		-- local highlight = {
		-- 	"RainbowRed",
		-- 	"RainbowYellow",
		-- 	"RainbowBlue",
		-- 	"RainbowOrange",
		-- 	"RainbowGreen",
		-- 	"RainbowViolet",
		-- 	"RainbowCyan",
		-- }

		-- this is to conform highlight groups are loaded before the plugin loads
		-- local hooks = require("ibl.hooks")
		-- 	hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
		-- end)

		-- vim.opt.ada_rainbow_color
		-- the mode name here is ibl like mason or other plugin, there, ibl is the name of the plugin
		-- but how it uses ilb as the name of the plugin? There is a folder called
		-- ilb in lua folder of indent-blankline.nvim in .local/share/nvim/lazy
		require("ibl").setup({
			-- indent = { highlight = highlight, char = "|" },
			indent = { highlight = highlight, char = "" },
			whitespace = {
				highlight = highlight,
				remove_blankline_trail = false,
			},
			scope = { enabled = false },
			-- scope = { highlight = highlight },
			-- scope = { enabled = true, show_start = true, show_end = true, highlight = highlight },
		})
	end,
}

return M
