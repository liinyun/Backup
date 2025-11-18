-- LSP Support
local M = {}

local lsp_attach = function(client, bufnr)
	-- Create your keybindings here...
end

local on_init = function(client, bufnr)
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end

local function quit_floating_win()
	local win_id = vim.api.nvim_get_current_win()
	local config = vim.api.nvim_win_get_config(win_id)
	local flag = config.relative ~= ""
	if flag then
		vim.api.nvim_win_close(win_id, true)
	end
end

M = {
	-- LSP Configuration
	-- https://github.com/neovim/nvim-lspconfig
	"neovim/nvim-lspconfig",
	-- event = "VeryLazy",
	dependencies = {
		-- LSP Management
		-- https://github.com/williamboman/mason.nvim
		{ "williamboman/mason.nvim" },
		-- https://github.com/williamboman/mason-lspconfig.nvim
		{ "williamboman/mason-lspconfig.nvim" },

		-- Auto-Install LSPs, linters, formatters, debuggers
		-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
		{ "WhoIsSethDaniel/mason-tool-installer.nvim" },

		-- Useful status updates for LSP
		-- https://github.com/j-hui/fidget.nvim
		{ "j-hui/fidget.nvim", opts = {} },

		-- Additional lua configuration, makes nvim stuff amazing!
		-- https://github.com/folke/neodev.nvim
		-- { 'folke/neodev.nvim',                        opts = {} },
		-- { "folke/lazydev.nvim" },
		-- schemas
		{ "b0o/schemastore.nvim" },
	},
	key = {
		vim.keymap.set("n", "<M-\\>", "<cmd>lua vim.diagnostic.open_float()<CR>", { noremap = true, silent = true }),
	},
	config = function()
		require("mason").setup()
		-- 这里负责配置这些插件，但是仅仅是配置
		require("mason-lspconfig").setup({
			automatic_installation = true,
			-- Install these LSPs automatically
			ensure_installed = {
				-- bash
				"bashls",

				-- fronted
				"cssls",
				"html",
				"emmet_ls",
				"jsonls",
				"volar",
				"ts_ls",
				-- "vtsls"
				"lemminx",
				"quick_lint_js",
				"tailwindcss",
				-- unocss
				"unocss", -- markdown
				"marksman",

				-- yaml
				"yamlls",

				-- python
				-- "pyright",
				"basedpyright",

				-- latex
				"texlab",

				-- c, cpp
				-- "clangd",

				-- rust
				-- "rust_analyzer",

				-- lua
				"lua_ls",

				-- asm
				-- "asm-lsp",
			},
		})

		require("mason-tool-installer").setup({
			-- Install these linters, formatters, debuggers automatically
			ensure_installed = {
				-- python
				-- "black",
				-- "isort",
				"ruff",
				"debugpy",
				-- "flake8",
				-- "mypy",
				-- "pylint",
				"djlint",

				-- cpp
				"clang-format",

				-- javascript formatter
				"prettier",
				"prettierd",
			},
		})

		-- There is an issue with mason-tools-installer running with VeryLazy, since it triggers on VimEnter which has already occurred prior to this plugin loading so we need to call install explicitly
		-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim/issues/39
		-- vim.api.nvim_command("MasonToolsInstall")

		local lspconfig = require("lspconfig")
		local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Call setup on each LSP server
		-- 	-- configure svelte server
		-- 	lspconfig["svelte"].setup({
		-- 		capabilities = lsp_capabilities,
		-- 		on_attach = function(client, bufnr)
		-- 			vim.api.nvim_create_autocmd("BufWritePost", {
		-- 				pattern = { "*.js", "*.ts" },
		-- 				callback = function(ctx)
		-- 					-- Here use ctx.match instead of ctx.file
		-- 					client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
		-- 				end,
		-- 			})
		-- 		end,
		-- 	})

		-- 	-- configure graphql language server
		-- 	lspconfig["graphql"].setup({
		-- 		capabilities = lsp_capabilities,
		-- 		filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
		-- 	})

		-- this config can autocomplete a pair of tags
		-- like if you enter view it will offer view~ and can create <view></view>
		-- it can work with volar so I add vue to its file type
		lspconfig["emmet_ls"].setup({
			capabilities = lsp_capabilities,
			filetypes = {
				"html",
				"htmldjango",
				"typescriptreact",
				"javascriptreact",
				"css",
				"sass",
				"scss",
				"less",
				"svelte",
				"vue",
			},

			-- 	init_options = {
			-- 		html = {
			-- 			options = {
			-- 				-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
			-- 				["bem.enabled"] = true,
			-- 			},
			-- 		},
			-- 	},
		})

		lspconfig["marksman"].setup({
			capabilities = lsp_capabilities,
			filetypes = { "markdown" },
		})

		-- lspconfig["pyright"].setup({
		-- 	-- cmd = { vim.fn.stdpath("config") .. "/lsp/node_modules/.bin/pyright-langserver", "--stdio" },
		-- 	-- cmd = { vim.fn.stdpath("config") .. "/lsp/node_modules/.bin/delance-langserver", "--stdio" },
		-- 	capabilities = {
		-- 		codeActionProvider = true,
		-- 	},
		-- 	settings = {
		-- 		python = {
		-- 			analysis = {
		-- 				typeCheckingMode = "basic",
		-- 				autoSeachPaths = true,
		-- 			},
		-- 		},
		-- 	},
		-- })

		lspconfig["ruff"].setup({
			init_options = {
				settings = {
					-- organizeImports = false,
					-- disable lint of ruff
					showSyntaxErrors = false,
				},
			},
		})

		lspconfig["kotlin_language_server"].setup({

			cmd = {
				"/home/linya/codes/lsp/kotlin-language-server/server/build/install/server/bin/kotlin-language-server",
			},
			on_attach = lsp_attach,
			capabilities = lsp_capabilities,
		})

		lspconfig["unocss"].setup({
			capabilities = lsp_capabilities,
			filetypes = { "vue" },
		})

		lspconfig["basedpyright"].setup({
			capabilities = lsp_capabilities,
			on_init = on_init,
			settings = {
				basedpyright = {
					typeCheckingMode = "basic",
					analysis = {
						diagnosticMode = "openFilesOnly",
						strictGenericNarrowing = true,
						inlayHints = {
							variableTypes = true,
							callArgumentNames = true,
							functionReturnTypes = true,
							genericTypes = true,
						},
					},
				},
			},
		})

		-- lspconfig["rust_analyzer"].setup({
		--   capabilities = lsp_capabilities,
		--   on_attach = function(client, bufnr)
		--     vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
		--   end,
		--   settings = {
		--     ["rust-analyzer"] = {
		--       imports = {
		--         granularity = {
		--           group = "module",
		--         },
		--         prefix = "self",
		--       },
		--       cargo = {
		--         buildScripts = {
		--           enable = true,
		--         },
		--       },
		--       procMacro = {
		--         enable = true,
		--       },
		--       completion = {
		--         fullFunctionSignatures = true,
		--       },
		--       diagnostics = {
		--         experimental = true,
		--         enable = true,
		--
		--       }
		--     },
		--   },
		-- })

		lspconfig["jsonls"].setup({
			capabilities = lsp_capabilities,
			on_attach = lsp_attach,
			filetypes = { "json", "jsonc" },
			settings = {
				http = {
					proxy = "127.0.0.1:7897",
					proxyStrictSSL = true,
				},
				json = {
					schemas = require("schemastore").json.schemas(),
					validate = { enable = true },
				},
			},
		})

		-- these config is enough to use schemas in schemastore
		lspconfig["yamlls"].setup({
			capabilities = lsp_capabilities,
			on_attach = lsp_attach,
			filetypes = { "yaml", "yml" },
			settings = {
				yaml = {
					schemas = {
						["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
						["../path/relative/to/file.yml"] = "/.github/workflows/*",
						["/path/from/root/of/project"] = "/.github/workflows/*",
					},
				},
			},
		})

		lspconfig["ts_ls"].setup({
			capabilities = lsp_capabilities,
			on_attach = lsp_attach,
			init_options = {
				plugins = {
					{
						name = "@vue/typescript-plugin",
						location = vim.fn.stdpath("data")
							.. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
						languages = { "vue" },
					},
				},
			},
			-- filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
			settings = {
				typescript = {
					tsserver = {
						useSyntaxServer = true,
					},
					inlayHints = {
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = true,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayVariableTypeHintsWhenTypeMatchesName = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayEnumMemberValueHints = true,
					},
				},
			},
		})

		lspconfig["volar"].setup({
			capabilities = lsp_capabilities,
			on_attach = lsp_attach,
			on_init = on_init,
			filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
			init_options = {
				vue = {
					hybridMode = false,
				},
			},
			settings = {
				typescript = {
					inlayHints = {
						enumMemberValues = {
							enabled = true,
						},
						functionLikeReturnTypes = {
							enabled = true,
						},
						propertyDeclarationTypes = {
							enabled = true,
						},
						parameterTypes = {
							enabled = true,
							suppressWhenArgumentMatchesName = true,
						},
						variableTypes = {
							enabled = true,
						},
					},
				},
			},
		})

		lspconfig["cssls"].setup({
			capabilities = lsp_capabilities,
			on_attach = lsp_attach,
		})

		-- Lua LSP settings
		lspconfig["lua_ls"].setup({
			capabilities = lsp_capabilities,

			on_init = function(client)
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
					runtime = {
						-- Tell the language server which version of Lua you're using
						-- (most likely LuaJIT in the case of Neovim)
						version = "LuaJIT",
					},
					-- Make the server aware of Neovim runtime files
				})
			end,

			settings = {
				Lua = {
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
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME,
							-- Depending on the usage, you might want to add additional paths here.
							"${3rd}/luv/library",
							-- "${3rd}/busted/library",
						},
						-- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
						-- library = vim.api.nvim_get_runtime_file("", true)
					},
					completion = {
						callSnippet = "Replace",
					},
				},
			},
		})

		--
		-- markdown LSP settings
		-- setup() is also available as an alias
		require("lspkind").init({
			-- DEPRECATED (use mode instead): enables text annotations
			--
			-- default: true
			-- with_text = true,

			-- defines how annotations are shown
			-- default: symbol
			-- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
			mode = "symbol_text",

			-- default symbol map
			-- can be either 'default' (requires nerd-fonts font) or
			-- 'codicons' for codicon preset (requires vscode-codicons font)
			--
			-- default: 'default'
			preset = "codicons",

			-- override preset symbols
			--
			-- default: {}
			symbol_map = {
				Text = "󰉿",
				Method = "󰆧",
				Function = "󰊕",
				Constructor = "",
				Field = "󰜢",
				Variable = "󰀫",
				Class = "󰠱",
				Interface = "",
				Module = "",
				Property = "󰜢",
				Unit = "󰑭",
				Value = "󰎠",
				Enum = "",
				Keyword = "󰌋",
				Snippet = "",
				Color = "󰏘",
				File = "󰈙",
				Reference = "󰈇",
				Folder = "󰉋",
				EnumMember = "",
				Constant = "󰏿",
				Struct = "󰙅",
				Event = "",
				Operator = "󰆕",
				TypeParameter = "",
			},
		})

		-- it is the same shortcut in coc, I may addd this to the overall config
		vim.keymap.set("n", "<Esc>", quit_floating_win, { noremap = true, silent = true })
		-- Globally configure all LSP floating preview popups (like hover, signature help, etc)
		local open_floating_preview = vim.lsp.util.open_floating_preview
		-- function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
		--   opts = opts or {}
		--   opts.border = opts.border or "rounded" -- Set border to rounded
		--   return open_floating_preview(contents, syntax, opts, ...)
		-- end
		-- 上面的写法会提示报错，我这种写法就不会有报错提示了，效果是一样的
		-- 不过我不知道为什么之前的函数要添加 ... 因为 原来的 vim.lsp.util.open_floating_preview 这个函数是只接受三个变量的，就算添加新的变量也没有意义吧
		local function my_open_floating_preview(contents, syntax, opts)
			opts = opts or {}
			opts.border = opts.border or "rounded" -- Set border to rounded
			return open_floating_preview(contents, syntax, opts)
		end
		vim.lsp.util.open_floating_preview = my_open_floating_preview
	end,
}
return M
