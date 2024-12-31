M = {
	"L3MON4D3/LuaSnip",
	enabled = true,
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	-- event = {
	-- 	"InsertEnter",
	-- 	"CmdlineEnter",
	-- },

	config = function()
		require("luasnip").setup({
			load_ft_func = require("luasnip.extras.filetype_functions").extend_load_ft({
				htmldjango = { "html" },
			}),
		})

		-- this is snippets from friendly-snippets
		require("luasnip.loaders.from_vscode").lazy_load({})
		-- this is snippets from my config
		require("luasnip.loaders.from_vscode").lazy_load({
			paths = "~/.config/nvim/snips/",
		})
	end,
}
return M
