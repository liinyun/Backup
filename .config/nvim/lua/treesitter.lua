vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter.git" },
}, { confirm = false })

require("nvim-treesitter").install({
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
	"rust",
	"make",
	"matlab",
	"toml",
	-- this is for references file
	"bibtex",
	"julia",
	"hurl",
})

-- require("nvim-treesitter").setup({
-- 		highlight = {
-- 			enable = true,
-- 			disable = { "latex" },
-- 		},
-- 		rainbow = {
-- 			enable = true, -- enable rainbow parenthesis
-- 			extended_mode = true, -- enable rainbow parenthesis in comment codes
-- 			max_file_lines = nil, -- don't restrain the file size
-- 		},
-- 		indent = { enable = true },
-- 		auto_install = false, -- automatically install syntax support when entering new file type buffer
-- 		autotag = {
-- 			enable = true,
-- 		},
-- })
