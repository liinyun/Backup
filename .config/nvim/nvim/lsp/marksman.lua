local lsp_capabilities = require("blink.cmp").get_lsp_capabilities()

local M = {}

M = {
	cmd = { "marksman" },
	filetypes = { "markdown" },
	capabilities = lsp_capabilities,
}

return M
