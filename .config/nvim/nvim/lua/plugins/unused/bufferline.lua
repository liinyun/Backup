-- using lazy.nvim
local M = {}
M = {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local bufferline = require("bufferline")
		bufferline.setup({
			highlights = {
				indicator_selected = {
					fg = "#85EEA7",
				},
			},
			options = {
				mode = "buffers", -- set to "tabs" to only show tabpages instead
				style_preset = bufferline.style_preset.default, -- or bufferline.style_preset.minimal,
				themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
				-- numbers = "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
				close_command = "bdelete! %d", -- can be a string | function, | false see "Mouse actions"
				right_mouse_command = "bdelete! %d", -- can be a string | function | false, see "Mouse actions"
				left_mouse_command = "buffer %d", -- can be a string | function, | false see "Mouse actions"
				middle_mouse_command = nil, -- can be a string | function, | false see "Mouse actions"
				indicator = {
					icon = "▎▎", -- this should be omitted if indicator style is not 'icon'

					-- style = 'icon' | 'underline' | 'none',
					style = "icon",
				},

				buffer_close_icon = "󰅖",
				modified_icon = "● ",
				close_icon = " ",
				left_trunc_marker = " ",
				right_trunc_marker = " ",
			},
		})
	end,
}
return M
