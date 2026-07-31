vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter.git" },
}, { confirm = false })

require("nvim-treesitter").install({
	"bash",
	"bibtex",
	"c",
	"cpp",
	"css",
	"dockerfile",
	"fennel",
	"gitignore",
	"graphql",
	"html",
	"hurl",
	"json",
	"javascript",
	"julia",
	"lua",
	"make",
	"matlab",
	"markdown_inline",
	"markdown",
	"ocaml",
	"prisma",
	"python",
	"query",
	-- "vue",
	"readline",
	"rust",
	"scheme",
	"svelte",
	"tsx",
	"toml",
	"typescript",
	-- this is for references file
	"vim",
	"yaml",
	"zathurarc",
})

local parsers = require("nvim-treesitter.parsers")
local avail = require("nvim-treesitter").get_available()

local disable = {
	["rust"] = true,
	["csv"] = true,
	["dockerfile"] = true,
	["typst"] = true,
	-- ["scheme"] = true,
}

vim.api.nvim_create_autocmd("FileType", {
	pattern = avail,
	callback = function(args)
		if disable[args.match] then
			return
		end

		local max_filesize = 100 * 1024 -- 100 KB
		local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
		if ok and stats and stats.size > max_filesize then
			return
		end

		-- vim.print(args)
		vim.treesitter.start(args.buf)
		if parsers[args.match] == nil then
			vim.bo[args.buf].syntax = "on" -- only if additional legacy syntax is needed
		end
	end,
})
