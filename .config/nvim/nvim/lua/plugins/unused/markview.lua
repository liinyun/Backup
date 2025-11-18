return {
	"OXY2DEV/markview.nvim",
	lazy = false, -- Recommended
	-- ft = "markdown" -- If you decide to lazy-load anyway

	priority = 50,

	dependencies = {
		-- "nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		preview = {
			modes = { "n" },
			hybrid_modes = { "n" },
			-- linewise_hybrid_mode = true,
		},
		latex = {
			enable = false,
			blocks = {
				enable = false,
			},
		},
		markdown = {
			enable = true,

			block_quotes = {},
			code_blocks = {},
			headings = {},
			horizontal_rules = {},
			list_items = {},
			metadata_plus = {},
			metadata_minus = {},
			tables = {},
		},
		markdown_inline = {
			enable = true,

			block_references = {},
			checkboxes = {},
			emails = {},
			embed_files = {},
			entities = {},
			escapes = {},
			footnotes = {},
			highlights = {},
			hyperlinks = {},
			images = {},
			inline_codes = {},
			internal_links = {},
			uri_autolinks = {},
		},

		html = {
			enable = true,

			---@type markview.config.html.container_elements
			container_elements = {
				enable = true,

				["^a$"] = {
					on_opening_tag = {
						conceal = "",
						virt_text_pos = "inline",
						virt_text = { { "", "MarkviewHyperlink" } },
					},
					on_node = { hl_group = "MarkviewHyperlink" },
					on_closing_tag = { conceal = "" },
				},
				["^b$"] = {
					on_opening_tag = { conceal = "" },
					on_node = { hl_group = "Bold" },
					on_closing_tag = { conceal = "" },
				},
				["^code$"] = {
					on_opening_tag = {
						conceal = "",
						hl_mode = "combine",
						virt_text_pos = "inline",
						virt_text = { { " ", "MarkviewInlineCode" } },
					},
					on_node = { hl_group = "MarkviewInlineCode" },
					on_closing_tag = {
						conceal = "",
						hl_mode = "combine",
						virt_text_pos = "inline",
						virt_text = { { " ", "MarkviewInlineCode" } },
					},
				},
				["^em$"] = {
					on_opening_tag = { conceal = "" },
					on_node = { hl_group = "@text.emphasis" },
					on_closing_tag = { conceal = "" },
				},
				["^i$"] = {
					on_opening_tag = { conceal = "" },
					on_node = { hl_group = "Italic" },
					on_closing_tag = { conceal = "" },
				},
				["^mark$"] = {
					on_opening_tag = { conceal = "" },
					on_node = { hl_group = "MarkviewPalette1" },
					on_closing_tag = { conceal = "" },
				},
				["^pre$"] = {
					on_opening_tag = { conceal = "" },
					on_node = { hl_group = "Special" },
					on_closing_tag = { conceal = "" },
				},
				["^strong$"] = {
					on_opening_tag = { conceal = "" },
					on_node = { hl_group = "@text.strong" },
					on_closing_tag = { conceal = "" },
				},
				["^sub$"] = {
					on_opening_tag = {
						conceal = "",
						hl_mode = "combine",
						virt_text_pos = "inline",
						virt_text = { { "↓[", "MarkviewSubscript" } },
					},
					on_node = { hl_group = "MarkviewSubscript" },
					on_closing_tag = {
						conceal = "",
						hl_mode = "combine",
						virt_text_pos = "inline",
						virt_text = { { "]", "MarkviewSubscript" } },
					},
				},
				["^sup$"] = {
					on_opening_tag = {
						conceal = "",
						hl_mode = "combine",
						virt_text_pos = "inline",
						virt_text = { { "↑[", "MarkviewSuperscript" } },
					},
					on_node = { hl_group = "MarkviewSuperscript" },
					on_closing_tag = {
						conceal = "",
						hl_mode = "combine",
						virt_text_pos = "inline",
						virt_text = { { "]", "MarkviewSuperscript" } },
					},
				},
				["^u$"] = {
					on_opening_tag = { conceal = "" },
					on_node = { hl_group = "Underlined" },
					on_closing_tag = { conceal = "" },
				},
			},
			headings = {},
			void_elements = {},
		},
	},
}
