local OSName = vim.uv.os_uname().sysname

vim.pack.add({
	{ src = "https://github.com/sqls-server/sqls.git" },
}, { confirm = false })

-- vim.pack.add({
-- 	{ src = "https://github.com/gelguy/wilder.nvim.git" },
-- }, { confirm = false })
-- local wilder = require("wilder")
-- wilder.setup({ modes = { ":", "/", "?" } })
-- wilder.set_option(
-- 	"renderer",
-- 	wilder.popupmenu_renderer({
-- 		-- highlighter applies highlighting to the candidates
-- 		highlighter = wilder.basic_highlighter(),
-- 	})
-- )

vim.pack.add({
	{ src = "https://github.com/L3MON4D3/LuaSnip.git" },
}, { confirm = false })

-- vim.pack.add({
-- 	{ src = "https://github.com/liinyun/codelens_eol.nvim" },
-- }, { confirm = false })

require("luasnip").setup({
	load_ft_func = require("luasnip.extras.filetype_functions").extend_load_ft({
		htmldjango = { "html" },
	}),
})

local ls = require("luasnip")
vim.keymap.set({ "i", "s" }, "<c-n>", function()
	ls.jump(1)
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<c-p>", function()
	ls.jump(-1)
end, { silent = true })

-- this is snippets from friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load({})
-- this is snippets from my config
require("luasnip.loaders.from_vscode").lazy_load({
	paths = "~/.config/nvim/snips/",
})

-- ===============================lazydev===========================================
vim.pack.add({
	{ src = "https://github.com/folke/lazydev.nvim.git" },
}, { confirm = false })

require("lazydev").setup({
	library = {
		-- Library paths can be absolute
		-- "~/projects/my-awesome-lib",
		-- Or relative, which means they will be resolved from the plugin dir.
		"lazy.nvim",
		-- It can also be a table with trigger words / mods
		-- Only load luvit types when the `vim.uv` word is found
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },

		-- always load the LazyVim library
		-- "LazyVim",
		-- Only load the lazyvim library when the `LazyVim` global is found
		-- { path = "LazyVim", words = { "LazyVim" } },
		-- Load the wezterm types when the `wezterm` module is required
		-- Needs `justinsgithub/wezterm-types` to be installed
		{ path = "wezterm-types", mods = { "wezterm" } },

		-- Load the xmake types when opening file named `xmake.lua`
		-- Needs `LelouchHe/xmake-luals-addon` to be installed
		{ path = "xmake-luals-addon/library", files = { "xmake.lua" } },
	},
	-- always enable unless `vim.g.lazydev_enabled = false`
	-- This is the default
	-- enabled = function(root_dir)
	--   return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
	-- end,
	-- disable when a .luarc.json file is found
	enabled = function(root_dir)
		return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
	end,
})

--===================================blink===========================================
vim.pack.add({
	{ src = "https://github.com/saghen/blink.cmp.git" },
}, { confirm = false })

require("blink.cmp").setup({
	keymap = {
		preset = "none",
		["<Up>"] = { "select_prev", "fallback" },
		["<Down>"] = { "select_next", "fallback" },
		["<tab>"] = { "select_next", "fallback" },
		["<C-k>"] = { "select_prev", "fallback" },
		["<C-j>"] = { "select_next", "fallback" },
		["<CR>"] = { "accept", "fallback" },
		["<c-n>"] = { "snippet_forward", "fallback" },
		["<c-p>"] = { "snippet_backward", "fallback" },
		["<c-tab>"] = { "show" }, -- show the autocomplete manu
	},

	appearance = {
		highlight_ns = vim.api.nvim_create_namespace("blink_cmp"),
		-- Sets the fallback highlight groups to nvim-cmp's highlight groups
		-- Useful for when your theme doesn't support blink.cmp
		-- Will be removed in a future release
		use_nvim_cmp_as_default = false,
		-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
		-- Adjusts spacing to ensure icons are aligned
		nerd_font_variant = "mono",
		kind_icons = {
			Text = "  ",
			Method = "  ",
			Function = "  ",
			Constructor = "  ",
			Field = "  ",
			Variable = "  ",
			Class = "  ",
			Interface = "  ",
			Module = "  ",
			Property = "  ",
			Unit = "  ",
			Value = "  ",
			Enum = "  ",
			Keyword = "  ",
			Snippet = "  ",
			Color = "  ",
			File = "  ",
			Reference = "  ",
			Folder = "  ",
			EnumMember = "  ",
			Constant = "  ",
			Struct = "  ",
			Event = "  ",
			Operator = "  ",
			TypeParameter = "  ",
		},
	},

	-- (Default) Only show the documentation popup when manually triggered
	completion = {
		keyword = {
			range = "full",
		},
		documentation = { auto_show = true },
		list = { selection = { preselect = true, auto_insert = false } },
		menu = {
			auto_show = true,
			draw = {
				columns = {
					{ "label", "label_description", gap = 1 },
					{ "kind_icon", "kind" },
				},
			},
		},

		ghost_text = {
			enabled = true,
			-- Show the ghost text when an item has been selected
			-- show_with_selection = true,
			-- Show the ghost text when no item has been selected, defaulting to the first item
			show_without_selection = false,
			-- Show the ghost text when the menu is open
			show_with_menu = true,
			-- Show the ghost text when the menu is closed
			show_without_menu = true,
		},
	},

	-- this enables luasnip as snipet sources for blink
	snippets = { preset = "luasnip" },
	-- Default list of enabled providers defined so that you can extend it
	-- elsewhere in your config, without redefining it, due to `opts_extend`
	sources = {
		default = (OSName == "Linux" or OSName == "Windows_NT")
				and { "lsp", "path", "snippets", "lazydev", "buffer", "dictionary" }
			or { "lsp", "path", "snippets", "lazydev", "buffer" },

		providers = {
			lsp = {
				score_offset = 100,
			},

			lazydev = {
				name = "LazyDev",
				module = "lazydev.integrations.blink",
				-- make lazydev completions top priority (see `:h blink.cmp`)
				score_offset = 80,
			},

			dictionary = (OSName == "Linux" or OSName == "Windows_NT")
					and {
						module = "blink-cmp-dictionary",
						name = "Dict",
						score_offset = 10,
						-- Make sure this is at least 2.
						-- 3 is recommended
						min_keyword_length = 3,
						opts = {
							-- options for blink-cmp-dictionary
							dictionary_files = { vim.fn.expand("~/.config/nvim/dictionary/words.txt") },
							dictionary_directories = {
								vim.fn.expand("~/.config/nvim/dictionary"),
							},
						},
					}
				or nil, --Set to nil or an empty table to effectively comment it out/disable it

			path = {
				score_offset = 120,
			},
			snippets = {
				score_offset = 80,
			},
			buffer = {
				score_offset = 80,
			},
		},
	},

	-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
	-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
	-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
	--
	-- See the fuzzy documentation for more information
	fuzzy = { implementation = "prefer_rust_with_warning" },
	-- this config is very unusable, my cmdline command should be short not be too long like a luanguage snippet
	cmdline = {
		enabled = true,
		keymap = { preset = "inherit" },
		completion = {
			menu = {
				auto_show = true,
			},
			list = { selection = { preselect = false, auto_insert = false } },
			ghost_text = { enabled = true },
		},
	},

	-- opts_extend = { "sources.default" },
})

-- ==================================rustaceanvim=======================================

vim.pack.add({
	{ src = "https://github.com/mrcjkb/rustaceanvim.git" },
}, { confirm = false })

vim.g.rustaceanvim = {
	tools = {
		on_initialized = function(status)
			local health = status.health

			if health == "ok" then
				vim.cmd.RustLsp("flyCheck")
				-- vim.lsp.codelens.refresh()
				-- elseif health == "warning" then
				--   vim.notify("ra health is " .. health, vim.log.levels.WARN)
				-- elseif health == "error" then
				--   vim.notify("ra health is " .. health, vim.log.levels.ERROR)
			end
		end,
	},
	server = {
		-- don't use on_init, it will thow error, but I don't know the reason why it can throw error
		on_attach = function(client, bufnr)
			-- if client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, { bufnr = bufnr }) then
			-- local _ = pcall(vim.lsp.inlay_hint.enable, true, { bufnr = bufnr })
			if not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }) then
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
			end
			-- end

			-- vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		end,
		default_settings = {
			["rust-analyzer"] = {},
		},
	},
}

-- =================================hurl===============================================

vim.pack.add({
	{ src = "https://github.com/jellydn/hurl.nvim.git" },
}, { confirm = false })

require("hurl").setup(
	{
		-- Show debugging info
		debug = false,
		-- Show notification on run
		show_notification = false,
		-- Show response in popup or split
		mode = "split",
		-- Default formatter
		formatters = {
			json = { "jq" }, -- Make sure you have install jq in your system, e.g: brew install jq
			html = {
				"prettier", -- Make sure you have install prettier in your system, e.g: npm install -g prettier
				"--parser",
				"html",
			},
			xml = {
				"tidy", -- Make sure you have installed tidy in your system, e.g: brew install tidy-html5
				"-xml",
				"-i",
				"-q",
			},
		},
		-- Default mappings for the response popup or split views
		-- mappings = {
		-- 	close = "q", -- Close the response popup or split view
		-- 	next_panel = "<C-n>", -- Move to the next response popup window
		-- 	prev_panel = "<C-p>", -- Move to the previous response popup window
		-- },
	}
	-- keys = {
	-- 	-- Run API request
	-- 	{ "<leader>A", "<cmd>HurlRunner<CR>", desc = "Run All requests" },
	-- 	{ "<leader>a", "<cmd>HurlRunnerAt<CR>", desc = "Run Api request" },
	-- 	{ "<leader>te", "<cmd>HurlRunnerToEntry<CR>", desc = "Run Api request to entry" },
	-- 	{ "<leader>tE", "<cmd>HurlRunnerToEnd<CR>", desc = "Run Api request from current entry to end" },
	-- 	{ "<leader>tm", "<cmd>HurlToggleMode<CR>", desc = "Hurl Toggle Mode" },
	-- 	{ "<leader>tv", "<cmd>HurlVerbose<CR>", desc = "Run Api in verbose mode" },
	-- 	{ "<leader>tV", "<cmd>HurlVeryVerbose<CR>", desc = "Run Api in very verbose mode" },
	-- 	-- Run Hurl request in visual mode
	-- 	{ "<leader>h", ":HurlRunner<CR>", desc = "Hurl Runner", mode = "v" },
	-- }
)
