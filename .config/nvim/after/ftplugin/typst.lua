function TinymistCompileToPdf()
	local params = {
		textDocument = {
			uri = vim.uri_from_bufnr(0),
		},
		-- We include the text to ensure the server is perfectly in sync
		text = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n"),
	}
	vim.lsp.buf_notify(0, "textDocument/didSave", params)
end
vim.api.nvim_create_autocmd("ModeChanged", {
	pattern = "i*:*",
	-- nested = true,
	callback = TinymistCompileToPdf,
})

-- vim.api.nvim_create_user_command("TinyExport", function()
-- 	-- vim.lsp.buf.execute_command({
-- 	-- 	command = "tinymist.exportPdf",
-- 	-- 	arguments = { vim.uri_from_bufnr(0) },
-- 	-- })
-- 	local params = {
-- 		textDocument = {
-- 			uri = vim.uri_from_bufnr(0),
-- 		},
-- 		-- We include the text to ensure the server is perfectly in sync
-- 		text = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n"),
-- 	}
-- 	vim.lsp.buf_notify(0, "textDocument/didSave", params)
-- end, {})
