local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set("n", "<M-CR>", function()
	vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
	-- or vim.lsp.buf.codeAction() if you don't want grouping.
end, { silent = true, buffer = bufnr })
vim.keymap.set(
	"n",
	"K", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
	function()
		vim.cmd.RustLsp({ "hover", "actions" })
	end,
	{ silent = true, buffer = bufnr }
)

vim.keymap.set("n", "<M-\\>", function()
	vim.cmd.RustLsp({ "renderDiagnostic", "cycle" })
end, { noremap = true, silent = true })


-- vim.keymap.set("n", "<M-\\>", "<cmd>lua vim.diagnostic.open_float()<CR>", { noremap = true, silent = true }),
-- vim.cmd.RustLsp({ "explainError", "cycle" })
-- vim.cmd.RustLsp({ "renderDiagnostic", "cycle" })
