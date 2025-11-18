local render_markdown = {
	"MeanderingProgrammer/render-markdown.nvim",
	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
	--	---@module 'render-markdown'
	-- 	---@type render.md.UserConfig
	-- opts = {},
	config = function()
		require("render-markdown").setup({
			enable = true,
			preset = "none",
			file_types = { "markdown", "html" },
			render_modes = { "n", "c", "t" },
			markdown = {
				disable = false,
			},
			-- injections = {
			-- 	markdown = {
			-- 		enabled = true,
			-- 		query = [[
			--              ((message) @injection.content
			--                  (#set! injection.combined)
			--                  (#set! injection.include-children)
			--                  (#set! injection.language "html"))
			--          ]],
			-- 	},
			-- },
		})
	end,
}

return render_markdown
