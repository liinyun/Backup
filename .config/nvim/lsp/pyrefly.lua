return {
	cmd = { "pyrefly", "lsp" },
	filetypes = { "python" },
	root_markers = {
		"pyproject.toml",
		".git",
	},
	on_exit = function(code, _, _)
		vim.schedule(function()
			vim.notify("Closing Pyrefly LSP exited with code: " .. code, vim.log.levels.INFO)
		end)
	end,
}
