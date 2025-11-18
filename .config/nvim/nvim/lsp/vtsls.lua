local vue_language_server_path =
	"/home/linya/.local/share/fnm/node-versions/v22.12.0/installation/lib/node_modules/@vue/language-server"
local vue_plugin = {
	name = "@vue/typescript-plugin",
	location = vue_language_server_path,
	languages = { "vue" },
	configNamespace = "typescript",
}
local lsp_capabilities = require("blink.cmp").get_lsp_capabilities()
return {
	cmd = { "vtsls", "--stdio" },
	capabilities = lsp_capabilities,
	settings = {
		vtsls = {
			tsserver = {
				globalPlugins = {
					vue_plugin,
				},
			},
		},
	},
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
}
