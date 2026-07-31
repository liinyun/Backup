local lsp_capabilities = require("blink.cmp").get_lsp_capabilities()
return {
	cmd = {
		"jetls",
		"serve",
	},

	filetypes = { "julia" },

	root_markers = { "Project.toml" },

	capabilities = lsp_capabilities,
	-- settings = {
	-- 	jetls = {
	-- 		full_analysis = {
	-- 			debounce = 1.0,
	-- 		},
	-- 		code_lens = {
	-- 			references = true,
	-- 		},
	-- 		-- completion = {
	-- 		-- 	method_signature = { true },
	-- 		-- },
	-- 		-- Use JuliaFormatter instead of Runic
	-- 		-- formatter = "JuliaFormatter",
	-- 		-- testrunner = { true },
	-- 	},
	-- },
	-- on_attach = function(client, bufnr)
	-- 	vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	-- 	vim.lsp.codelens.enable(true)
	-- end,
}
