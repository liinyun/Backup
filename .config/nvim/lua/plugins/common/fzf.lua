local M = {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- or if using mini.icons/mini.nvim
	-- dependencies = { "echasnovski/mini.icons" },
	-- why it doesn't work as usual ?
	-- Type number and <Enter> or click with the mouse (q or empty cancels):
	-- I don't know why it acts like this

	config = function()
		local fzf_cmd = require("fzf-lua")
		vim.keymap.set("n", "<leader>ff", fzf_cmd.files, { desc = "Telescope find files" })
		vim.keymap.set("n", "<leader>fg", fzf_cmd.live_grep, { desc = "Telescope live grep" })
		vim.keymap.set("n", "<leader>fb", fzf_cmd.buffers, { desc = "Telescope buffers" })
		-- vim.keymap.set("n", "<leader>fs", require("telescope.fzf_cmd").current_buffer_fuzzy_find, {})
		-- vim.keymap.set("n", "<leader>fh", FzfLua.help_tags, { desc = "Telescope help tags" })

		require("fzf-lua").setup({

		})
	end,
}

return M
