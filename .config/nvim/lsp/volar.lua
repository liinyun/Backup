local lsp_capabilities = require("blink.cmp").get_lsp_capabilities()
return {
	cmd = { "vue-language-server", "--stdio" },

	capabilities = lsp_capabilities,
	on_attach = function(client, bufnr) end,
	on_init = function(client, bufnr)
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
	end,
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
	init_options = {
		vue = {
			hybridMode = false,
		},
	},
	settings = {
		typescript = {
			inlayHints = {
				enumMemberValues = {
					enabled = true,
				},
				functionLikeReturnTypes = {
					enabled = true,
				},
				propertyDeclarationTypes = {
					enabled = true,
				},
				parameterTypes = {
					enabled = true,
					suppressWhenArgumentMatchesName = true,
				},
				variableTypes = {
					enabled = true,
				},
			},
		},
	},
}
