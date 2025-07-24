local lsp_capabilities = require("blink.cmp").get_lsp_capabilities()
return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = {
		".luarc.json",
		".luarc.jsonc",
		".luacheckrc",
		".stylua.toml",
		"stylua.toml",
		"selene.toml",
		"selene.yml",
		".git",
	},
	capabilities = lsp_capabilities,

	on_init = function(client)
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if
				path ~= vim.fn.stdpath("config")
				and (vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc"))
			then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			-- 		-- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
			--
		})
	end,

	settings = {
		Lua = {

			workspace = {
				checkThirdParty = false,
				library = {
					-- vim.env.VIMRUNTIME,
					-- Depending on the usage, you might want to add additional paths here.
					"${3rd}/luv/library",
					-- this enables  the busted library
					"${3rd}/busted/library",
				},
				-- library = vim.api.nvim_get_runtime_file("", true),
			},

			-- Make the server aware of Neovim runtime files
			runtime = {
				-- Tell the language server which version of Lua you're using
				-- (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},

			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			hint = {
				enable = true,
				arrayIndex = "Enable",
				await = true,
				paramName = "All",
				paramType = true,
				semicolon = "All",
				setType = true,
			},
			completion = {
				callSnippet = "Replace",
			},
		},
	},
}
