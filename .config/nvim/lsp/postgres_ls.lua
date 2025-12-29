local M = {
	cmd = { "postgres-language-server", "lsp-proxy" },
	filetypes = {
		"sql",
	},
	root_markers = { "postgres-language-server.jsonc" },
	-- workspace_required = true,
	settings = {
		linter = {
			--  Enable/disable the linter entirely
			enabled = true,
			rules = {
				-- Configure rule groups
				safety = {
					-- Individual rule configuration
					banDropColumn = "error", -- error, warn, info, hint, off
					banDropTable = "warn",
					addingRequiredField = "off",
				},
			},
		},
	},
}

return M
