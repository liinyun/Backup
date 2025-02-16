local M = {}

highlight = {
	"RainbowDelimiterRed",
	"RainbowDelimiterYellow",
	"RainbowDelimiterBlue",
	"RainbowDelimiterOrange",
	"RainbowDelimiterGreen",
	"RainbowDelimiterViolet",
	"RainbowDelimiterCyan",
}
M = {
	"HiPhish/rainbow-delimiters.nvim",
	lazy = false,

	-- event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },

	opts = {
		query = {
			latex = "rainbow-blocks",
			lua = "rainbow-blocks",
			query = "rainbow-blocks",
			verilog = "rainbow-blocks",
			typescript = "rainbow-parens",
		},
		highlight = highlight,
	},

	config = function(_, opts)
		vim.g.rainbow_delimiters = opts
	end,
	-- config = function()
	-- 	local rainbow_delimiters = require("rainbow-delimiters")
	-- 	vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#E06C75", default = true })
	-- 	vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#E5C07B", default = true })
	-- 	vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#61AFEF", default = true })
	-- 	vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#D19A66", default = true })
	-- 	vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#98C379", default = true })
	-- 	vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#C678DD", default = true })
	-- 	vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#56B6C2", default = true })
	--
}
return M
