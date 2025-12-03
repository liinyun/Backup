-- local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

local lsp_capabilities = require("blink.cmp").get_lsp_capabilities()
return {
	cmd = { "typescript-language-server", "--stdio" },
	capabilities = lsp_capabilities,
	root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
	on_attach = function(client, bufnr) end,
	on_init = function(client, bufnr)
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
	end,
	init_options = {
		plugins = {
			{
				name = "@vue/typescript-plugin",
				-- location = "/home/linya/.local/share/fnm/node-versions/v22.12.0/installation/lib/node_modules/@vue/typescript-plugin",
				location = "/home/linya/.local/share/mise/installs/npm-vue-typescript-plugin",
				languages = { "vue" },
			},
		},
	},
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
	settings = {
		typescript = {
			tsserver = {
				useSyntaxServer = true,
			},
			-- tsdk = "/home/linya/.local/share/fnm/node-versions/v22.12.0/installation/lib",
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = true,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayVariableTypeHintsWhenTypeMatchesName = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
		},
	},
}
