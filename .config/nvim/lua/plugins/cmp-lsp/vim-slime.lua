local M = {}
M = {
	"jpalardy/vim-slime",
	init = function()
		-- these two should be set before the plugin loads
		-- vim.g.slime_target = "tmux"
		vim.g.slime_target = "neovim"
		vim.g.slime_no_mappings = true
		vim.g.slime_python_ipython = 1
		vim.g.slime_no_mappings = 1
		vim.g.slime_bracketed_paste = 1
		vim.g.slime_cell_delimiter = "#%%"
		vim.g.slime_input_pid = false
		vim.g.slime_suggest_default = true
		vim.g.slime_menu_config = false
		vim.g.slime_neovim_ignore_unlisted = false
	end,
	config = function()
		local sign_on_cell_boundaries = function()
			local filepath = vim.fn.expand("%:p")
			local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
			if filepath == "" then
				return
			end
			local cell_delimiter = vim.g.slime_cell_delimiter
			for idx, line in ipairs(lines) do
				if string.match(line, cell_delimiter) then
					vim.fn.sign_place(0, "", "SlimeCell", vim.api.nvim_get_current_buf(), {
						lnum = idx,
					})
				end
			end
		end
		vim.api.nvim_create_autocmd({
			"TextChanged",
			"TextChangedI",
			"TextChangedP",
			"BufWinEnter",
			"BufWritePost",
			"FileWritePost",
			"BufEnter",
		}, {
			pattern = "*.py",
			callback = sign_on_cell_boundaries,
		})
		-- options not set here are g:slime_neovim_menu_order, g:slime_neovim_menu_delimiter, and g:slime_get_jobid
		-- see the documentation above to learn about those options

		-- called MotionSend but works with textobjects as well
		vim.keymap.set("n", "gz", "<Plug>SlimeMotionSend", { remap = true, silent = false })
		vim.keymap.set("n", "gzz", "<Plug>SlimeLineSend", { remap = true, silent = false })
		vim.keymap.set("x", "gz", "<Plug>SlimeRegionSend", { remap = true, silent = false })
		vim.keymap.set("n", "gzc", "<Plug>SlimeConfig", { remap = true, silent = false })
		vim.keymap.set("n", "<leader><CR>", "<Plug>SlimeSendCell", {
			silent = true,
			noremap = false, -- important for <Plug> mappings
		})
	end,
}
return M
