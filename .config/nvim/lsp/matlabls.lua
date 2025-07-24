local lsp_capabilities = require("blink.cmp").get_lsp_capabilities()
return {
	cmd = { "matlab-language-server", "--stdio" },
	filetypes = { "matlab" },
	capabilities = lsp_capabilities,

	-- root_dir = require("lspconfig").util.root_pattern(".git"),
	-- root_dir = function(bufnr, on_dir)
	-- 	local root_dir = vim.fs.root(bufnr, ".git")
	-- 	on_dir(root_dir or vim.fn.getcwd())
	-- end,
	settings = {
		MATLAB = {
			indexWorkspace = true,
			installPath = "/usr/local/MATLAB/R2025a",
			matlabConnectionTiming = "onStart",
			telemetry = true,
		},
	},
}
