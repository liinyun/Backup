return {
	-- cmd = { "scheme-langserver", ".scheme-langserver", "enable" },
	cmd = {
		"scheme-langserver",
		-- "-l ~/scheme-langserver.log",
		"-l",
		"scheme-langserver",
		-- vim.fn.expand("~") .. "/scheme-langserver.log",
		-- --enable multi-thread
		-- "-m enable",
		-- --disable type inference, because it's on very early stage.
		-- "-t disable",
	},
	filetypes = { "scheme" },
	root_markers = {
		-- "Akku.manifest",
		"scheme-langserver.log",
	},
}
