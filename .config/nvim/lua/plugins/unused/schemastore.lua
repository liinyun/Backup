return {
	"b0o/schemastore.nvim",
	config = function()
		require("lspconfig").jsonls.setup({
			settings = {
				json = {
					schemas = require("schemastore").json.schemas({
						-- fileMatch = { "tsconfig.json" },
						-- url = "https://json.schemastore.org/tsconfig",
						["tsconfig.json"] = {
							fileMatch = { "tsconfig.json" },
							name = "tsconfig.json",
							url = "https://json.schemastore.org/tsconfig",
						},
					}),
					validate = { enable = true },
				},
			},
		})
	end,
}
