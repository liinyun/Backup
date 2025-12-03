local vue_language_server_path =
	"/home/linya/.local/share/mise/installs/npm-vue-typescript-plugin/3.1.5/lib/node_modules/@vue/typescript-plugin"
local vue_plugin = {
	name = "@vue/typescript-plugin",
	location = vue_language_server_path,
	languages = { "vue" },
	configNamespace = "typescript",
}
local lsp_capabilities = require("blink.cmp").get_lsp_capabilities()
return {
	cmd = { "vtsls", "--stdio" },
	root_markers = { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock" },
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
