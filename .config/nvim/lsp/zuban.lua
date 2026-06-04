local lsp_capabilities = require("blink.cmp").get_lsp_capabilities()
return {
	cmd = { "zuban", "server" },
	root_markers = { "pyproject.toml", ".git" },
	filetypes = { "python" },

	capabilities = lsp_capabilities,

	on_attach = function(client, bufnr)
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end,
}
