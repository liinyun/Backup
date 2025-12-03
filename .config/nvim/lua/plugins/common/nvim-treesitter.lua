-- Code Tree Support / Syntax Highlighting
return {
	-- https://github.com/nvim-treesitter/nvim-treesitter
	"nvim-treesitter/nvim-treesitter",
	-- event = "VeryLazy",
	dependencies = {
		-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
		"nvim-treesitter/nvim-treesitter-textobjects",
		-- 这个是用来自动补全前端的括号的，事实上我感觉放在这里作为依赖有点不太合适，应该单独拿出来和autopairs放一起的
		"windwp/nvim-ts-autotag",
		-- {
		-- 	"HiPhish/rainbow-delimiters.nvim",
		-- 	event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
		-- },
	},

	priority = 100,
	-- treesitter will auto update its parser everytime it updates
	build = ":TSUpdate",

	lazy = false,
	opts = {
		highlight = {
			enable = true,
			disable = { "latex" },
		},
		rainbow = {
			enable = true, -- enable rainbow parenthesis
			extended_mode = true, -- enable rainbow parenthesis in comment codes
			max_file_lines = nil, -- don't restrain the file size
		},
		indent = { enable = true },
		auto_install = false, -- automatically install syntax support when entering new file type buffer
		autotag = {
			enable = true,
		},
		ensure_installed = {
			"json",
			"javascript",
			"typescript",
			"tsx",
			"yaml",
			"html",
			"css",
			"prisma",
			"lua",
			"vim",
			"svelte",
			"graphql",
			"bash",
			"dockerfile",
			"gitignore",
			"query",
			"c",
			"markdown_inline",
			"markdown",
			"python",
			-- "vue",
			-- "rust",
			"make",
			"matlab",
			"toml",
			-- this is for references file
			"bibtex",
		},
	},
	config = function(_, opts)
		local configs = require("nvim-treesitter.configs")
		configs.setup(opts)
	end,
}
