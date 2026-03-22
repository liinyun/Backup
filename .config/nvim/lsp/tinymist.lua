return {
	cmd = { "tinymist" },
	filetypes = { "typst" },
	-- root_dir = require("lspconfig").util.root_pattern(".git"),
	-- on_attach = function(client, bufnr)
	-- 	-- 核心操作：切断保存通知的联系
	-- 	-- 这会让 Neovim 在保存文件时，不再向 Tinymist 发送 didSave 信号
	-- 	if client.server_capabilities.textDocumentSync then
	-- 		client.server_capabilities.textDocumentSync.save = false
	-- 	end
	-- end,
	single_file_support = true,
	settings = {
		formatterMode = "typstyle",
		exportPdf = "onSave",
		semanticTokens = "disable",
	},
}
