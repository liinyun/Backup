local lsp_capabilities = require("blink.cmp").get_lsp_capabilities()

local M = {
	cmd = { "fvm", "dart", "language-server", "--protocol=lsp" },
	filetypes = { "dart" },
	root_markers = { "pubspec.yaml" },
	init_options = {
		onlyAnalyzeProjectsWithOpenFiles = true,
		suggestFromUnimportedLibraries = true,
		closingLabels = true,
		outline = true,
		flutterOutline = true,
	},
	on_init = function(client)
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
	end,

	capabilities = lsp_capabilities,
	settings = {
		dart = {
			completeFunctionCalls = true,
			showTodos = true,
			inlayHints = true,
		},
	},
}

return M
