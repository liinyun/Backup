return {
	-- "https://github.com/bfredl/nvim-ipy.git",
	"bfredl/nvim-ipy",
	config = function()
		vim.g.ipy_celldef = "#%%"
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "py",
			callback = function()
				vim.b.ipy_celldef = { "^# %%", "^# %%" }
			end,
		})
	end,
}
