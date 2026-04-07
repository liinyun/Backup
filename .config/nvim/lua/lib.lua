vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim.git" },
}, { confirm = false })

vim.pack.add({
	{ src = "https://github.com/MunifTanjim/nui.nvim.git" },
}, { confirm = false })

vim.pack.add({
	{ src = "https://github.com/nvim-tree/nvim-web-devicons.git" },
}, { confirm = false })
require("nvim-web-devicons").setup({
	-- your personal icons can go here (to override)
	-- you can specify color or cterm_color instead of specifying both of them
	-- DevIcon will be appended to `name`
	override = {
		-- zsh = {
		-- 	icon = "",
		-- 	color = "#428850",
		-- 	cterm_color = "65",
		-- 	name = "Zsh",
		-- },
	},
	-- globally enable different highlight colors per icon (default to true)
	-- if set to false all icons will have the default icon's color
	color_icons = true,
	-- globally enable default icons (default to false)
	-- will get overriden by `get_icons` option
	default = true,
	-- globally enable "strict" selection of icons - icon will be looked up in
	-- different tables, first by filename, and if not found by extension; this
	-- prevents cases when file doesn't have any extension but still gets some icon
	-- because its name happened to match some extension (default to false)
	strict = true,
	-- set the light or dark variant manually, instead of relying on `background`
	-- (default to nil)
	variant = "light|dark",
	-- same as `override` but specifically for overrides by filename
	-- takes effect when `strict` is true
	-- override_by_filename = {
	-- 	[".gitignore"] = {
	-- 		icon = "",
	-- 		color = "#f1502f",
	-- 		name = "Gitignore",
	-- 	},
	-- },
	-- same as `override` but specifically for overrides by extension
	-- takes effect when `strict` is true
	override_by_extension = {
		["m"] = {
			icon = "⅀",
			-- icon = "ℵ",
			color = "#51a0cf",
			name = "matlab",
		},
		["mc"] = {
			icon = "🐒",
			name = "monkeyC",
		},
	},
	-- same as `override` but specifically for operating system
	-- takes effect when `strict` is true
	-- override_by_operating_system = {
	-- 	["apple"] = {
	-- 		icon = "",
	-- 		color = "#A2AAAD",
	-- 		cterm_color = "248",
	-- 		name = "Apple",
	-- 	},
	-- },
})

vim.pack.add({
	{ src = "https://github.com/rafamadriz/friendly-snippets.git" },
}, { confirm = false })

vim.pack.add({
	{ src = "https://github.com/Kaiser-Yang/blink-cmp-dictionary.git" },
}, { confirm = false })

vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects.git" },
}, { confirm = false })

vim.pack.add({
	{ src = "https://github.com/windwp/nvim-ts-autotag.git" },
}, { confirm = false })
