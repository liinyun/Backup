local M = {
	name = "asm_lsp",
	cmd = { "asm-lsp" },
	filetypes = { "asm", "vmasm" },
	root_markers = { ".asm-lsp.toml", ".git" },
	single_file_support = true,
	settings = {
		-- bashIde = {
		-- 	globPattern = vim.env.GLOB_PATTERN or "*@(.sh|.inc|.bash|.command)",
		-- },
	},
}

return M
