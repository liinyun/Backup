local M = {}

-- M = {
-- 	"b0o/schemastore.nvim",
-- 	event = "LspAttach",
-- 	opts = {},
-- 	config = function(_, opts)
-- 		require("lspconfig").jsonls.setup({
-- 			settings = {
-- 				json = {
-- 					schemas = require("schemastore").json.schemas({
-- 						select = {
-- 							".eslintrc",
-- 							"package.json",
-- 							"tsconfig.json",
-- 						},
-- 					}),
-- 					validate = { enable = true },
-- 				},
-- 			},
-- 		})
-- 	end,
-- }

return M
