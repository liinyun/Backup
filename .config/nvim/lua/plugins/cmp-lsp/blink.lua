local M = {
	"saghen/blink.cmp",
	-- optional: provides snippets for the snippet source
	dependencies = { "rafamadriz/friendly-snippets", "Kaiser-Yang/blink-cmp-dictionary" },

	-- use a release tag to download pre-built binaries
	version = "1.*",
	-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
	-- build = 'cargo build --release',
	-- If you use nix, you can build from source using latest nightly rust with:
	-- build = 'nix run .#build-plugin',

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
		-- 'super-tab' for mappings similar to vscode (tab to accept)
		-- 'enter' for enter to accept
		-- 'none' for no mappings
		--
		-- All presets have the following mappings:
		-- C-space: Open menu or open docs if already open
		-- C-n/C-p or Up/Down: Select next/previous item
		-- C-e: Hide menu
		-- C-k: Toggle signature help (if signature.enabled = true)
		--
		-- See :h blink-cmp-config-keymap for defining your own keymap
		keymap = {
			preset = "none",
			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<C-k>"] = { "select_prev", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },
			["<CR>"] = { "accept", "fallback" },
			["<C-n>"] = { "snippet_backward", "fallback" },
			["<C-p>"] = { "snippet_forward", "fallback" },
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
				-- Text = "󰉿",
				-- Method = "󰊕",
				-- -- Method = "󰆧",
				-- Function = "󰊕",
				-- Constructor = "󰒓",
				--
				-- Field = "󰜢",
				-- -- Variable = "󰆦",
				-- Variable = "󰀫",
				-- Property = "󰖷",
				--
				-- -- Class = "󱡠",
				--
				-- Class = "󰠱",
				-- -- Interface = "󱡠",
				-- -- Interface = "ⓘ",
				-- Interface = "",
				-- Struct = "󱡠",
				-- Module = "󰆧",
				--
				-- Unit = "󰪚",
				-- -- Value = "󰦨",
				-- -- Enum = "󰦨",
				-- -- EnumMember = "󰦨",
				-- Value = "󰎠",
				-- Enum = "",
				-- EnumMember = "",
				--
				-- -- Keyword = "󰻾",
				-- Keyword = "󰌋",
				-- Constant = "󰏿",
				--
				-- -- Snippet = "󱄽",
				-- Snippet = "",
				-- Color = "󰏘",
				-- File = "󰈔",
				-- Reference = "󰬲",
				-- Folder = "󰉋",
				-- Event = "󱐋",
				-- -- Operator = "󰪚",
				-- Operator = "󰆕",
				-- -- TypeParameter = "󰬛",
				-- TypeParameter = "",

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
			default = { "lsp", "path", "snippets", "lazydev", "buffer", "dictionary" },
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

				dictionary = {
					module = "blink-cmp-dictionary",
					name = "Dict",
					score_offset = 10,
					-- Make sure this is at least 2.
					-- 3 is recommended
					min_keyword_length = 3,
					opts = {
						-- options for blink-cmp-dictionary
						dictionary_files = { vim.fn.expand("~/.config/nvim/dictionary/words.dict") },
						dictionary_directories = {
							vim.fn.expand("~/.config/nvim/dictionary"),
						},
					},
				},
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
			enabled = false,
			keymap = { preset = "inherit" },
			completion = {
				menu = {
					auto_show = true,
				},
				ghost_text = { enabled = true },
			},
		},
	},

	opts_extend = { "sources.default" },
}
return M
