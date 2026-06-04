-- ~/.config/nvim/plugin/0-tangerine.lua or ~/.config/nvim/init.lua

-- pick your plugin manager

local function bootstrap(url, ref)
	local name = url:gsub(".*/", "")
	local path

	path = vim.fn.stdpath("data") .. "/site/pack/core/start/" .. name

	if vim.fn.isdirectory(path) == 0 then
		print(name .. ": installing in data dir...")

		vim.fn.system({ "git", "clone", url, path })
		if ref then
			vim.fn.system({ "git", "-C", path, "checkout", ref })
		end

		vim.cmd("redraw")
		print(name .. ": finished installing")
	end
end

-- for stable version [recommended]
bootstrap("https://github.com/arutonee1/tangerine.nvim", "8361df9")

-- for git head
-- bootstrap("https://github.com/udayvir-singh/tangerine.nvim")
require("tangerine").setup({
	target = vim.fn.stdpath([[data]]) .. "/tangerine",

	-- compile files in &rtp
	rtpdirs = { "after/ftplugin", "lsp" },
	compiler = {
		-- disable popup showing compiled files
		verbose = false,
		-- compile every time before sourcing init.fnl
		hooks = { "oninit" },
	},
	-- disable all keymaps
	keymaps = {
		eval_buffer = "<Nop>",
		peek_buffer = "<Nop>",
		goto_output = "<Nop>",
		float = {
			next = "<Nop>",
			prev = "<Nop>",
			kill = "<Nop>",
			close = "<Nop>",
			resizef = "<Nop>",
			resizeb = "<Nop>",
		},
	},
})
