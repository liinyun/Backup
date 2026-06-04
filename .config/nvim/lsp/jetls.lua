local lsp_capabilities = require("blink.cmp").get_lsp_capabilities()
return {
	cmd = {
		"jetls",
		"serve",
	},

	commands = {
		["editor.action.showReferences"] = function(command, ctx)
			local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
			local file_uri, position, references = unpack(command.arguments)
			local items = vim.lsp.util.locations_to_items(references, client.offset_encoding)
			vim.fn.setqflist({}, " ", {
				title = command.title,
				items = items,
			})
			vim.lsp.util.show_document({
				uri = file_uri,
				range = { start = position, ["end"] = position },
			}, client.offset_encoding)
			vim.cmd("botright copen")
		end,
	},

	filetypes = { "julia" },

	root_markers = { "Project.toml" },

	capabilities = lsp_capabilities,
	settings = {
		jetls = {
			full_analysis = {
				debounce = 1.0,
			},
			code_lens = {
				references = true,
			},
			-- completion = {
			-- 	method_signature = { true },
			-- },
			-- Use JuliaFormatter instead of Runic
			formatter = "JuliaFormatter",
			-- testrunner = { true },
		},
	},
	on_attach = function(client, bufnr)
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
		vim.lsp.codelens.enable(true)
	end,
}
