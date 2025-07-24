return {
	cmd = { "tinymist" },
	filetypes = { "typst" },
	-- root_dir = require("lspconfig").util.root_pattern(".git"),
	single_file_support = true,
	settings = {
		formatterMode = "typstyle",
		exportPdf = "onType",
		sematicTokens = "disable",
	},
}
