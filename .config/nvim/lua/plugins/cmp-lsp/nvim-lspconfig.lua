-- LSP Support
local M = {}
M = {
	-- LSP Configuration
	-- https://github.com/neovim/nvim-lspconfig
	"neovim/nvim-lspconfig",
	event = "VeryLazy",
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
		{ "folke/lazydev.nvim" },
	},
	config = function()
		require("mason").setup()
		-- 这里负责配置这些插件，但是仅仅是配置
		require("mason-lspconfig").setup({
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
				"lemminx",
				"quick_lint_js",
				"tailwindcss",

				-- markdown
				"marksman",

				-- yaml
				"yamlls",

				-- python
				-- "pyright",
				"basedpyright",

				-- latex
				"texlab",

				--- c, cpp
				"clangd",

				-- lua
				"lua_ls",
			},
		})

		require("mason-tool-installer").setup({
			-- Install these linters, formatters, debuggers automatically
			ensure_installed = {
				-- python
				"black",
				"isort",
				"debugpy",
				"flake8",
				"mypy",
				"pylint",
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
		vim.api.nvim_command("MasonToolsInstall")

		local lspconfig = require("lspconfig")
		local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
		local lsp_attach = function(client, bufnr)
			-- Create your keybindings here...
		end

		-- Call setup on each LSP server
		require("mason-lspconfig").setup_handlers({
			function(server_name)
				lspconfig[server_name].setup({
					on_attach = lsp_attach,
					capabilities = lsp_capabilities,
				})
			end,
			["svelte"] = function()
				-- configure svelte server
				lspconfig["svelte"].setup({
					capabilities = lsp_capabilities,
					on_attach = function(client, bufnr)
						vim.api.nvim_create_autocmd("BufWritePost", {
							pattern = { "*.js", "*.ts" },
							callback = function(ctx)
								-- Here use ctx.match instead of ctx.file
								client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
							end,
						})
					end,
				})
			end,
			["graphql"] = function()
				-- configure graphql language server
				lspconfig["graphql"].setup({
					capabilities = lsp_capabilities,
					filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
				})
			end,
			-- ["emmet_ls"] = function()
			-- 	-- configure emmet language server
			-- 	lspconfig["emmet_ls"].setup({
			-- 		capabilities = lsp_capabilities,
			-- 		filetypes = {
			-- 			"html",
			-- 			"htmldjango",
			-- 			"typescriptreact",
			-- 			"javascriptreact",
			-- 			"css",
			-- 			"sass",
			-- 			"scss",
			-- 			"less",
			-- 			"svelte",
			-- 		},
			-- 	})
			-- end,
			["ts_ls"] = function()
				lspconfig["ts_ls"].setup({
					capabilities = lsp_capabilities,
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
					filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
					settings = {
						typescript = {
							tsserver = {
								useSyntaxServer = false,
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
			end,
			["volar"] = function()
				-- Vue 3
				lspconfig["volar"].setup({
					capabilities = lsp_capabilities,
					filetypes = { "vue" },
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
			end,
			["lua_ls"] = function()
				-- configure lua server (with special settings)
				lspconfig["lua_ls"].setup({
					capabilities = lsp_capabilities,
					settings = {
						Lua = {
							-- make the language server recognize "vim" global
							diagnostics = {
								globals = { "vim" },
							},
							workspace = {
								-- 就算加上了也没不一定有用处，首先，我已经有
								library = vim.api.nvim_get_runtime_file("", true),
								checkThirdParty = true,
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				})
			end,
			["marksman"] = function()
				lspconfig["marksman"].setup({
					capabilities = lsp_capabilities,
					filetypes = { "markdown" },
				})
			end,
			-- ["basedpyright"] = function()
			-- 	lspconfig["basedpyright"].setup({
			-- 		capabilities = lsp_capabilities,
			-- 		settings = {
			-- 			basedpyright = {
			-- 				typeCheckingMode = "basic",
			-- 				analysis = {
			-- 					diagnosticMode = "openFilesOnly",
			-- 				},
			-- 			},
			-- 		},
			-- 	})
			-- end,

			-- ["pyright"] = function()
			-- 	-- config python server with special setting
			--
			-- 	lspconfig.pyright.setup({
			-- 		capabilities = {
			-- 			codeActionProvider = true,
			-- 		},
			-- 		settings = {
			-- 			python = {
			-- 				analysis = {
			-- 					typeCheckingMode = "basic",
			-- 					autoSeachPaths = true,
			-- 				},
			-- 			},
			-- 		},
			-- 	})
			-- end,
		})

		-- lspconfig.pyright.setup({
		-- 	-- cmd = { vim.fn.stdpath("config") .. "/lsp/node_modules/.bin/pyright-langserver", "--stdio" },
		-- 	cmd = { vim.fn.stdpath("config") .. "/lsp/node_modules/.bin/delance-langserver", "--stdio" },
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

		lspconfig["basedpyright"].setup({
			capabilities = lsp_capabilities,
			settings = {
				basedpyright = {
					typeCheckingMode = "basic",
					analysis = {
						diagnosticMode = "openFilesOnly",
					},
				},
			},
		})

		-- lspconfig["emmet_ls"].setup({
		-- 	filetypes = {
		-- 		"html",
		-- 		"typescriptreact",
		-- 		"javascriptreact",
		-- 		"css",
		-- 		"sass",
		-- 		"scss",
		-- 		"less",
		-- 		"vue",
		-- 		"django-html", -- add your custom filetypes
		-- 	},
		-- 	init_options = {
		-- 		html = {
		-- 			options = {
		-- 				-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
		-- 				["bem.enabled"] = true,
		-- 			},
		-- 		},
		-- 	},
		-- })

		-- -- Lua LSP settings
		-- lspconfig.lua_ls.setup {
		--   settings = {
		--     Lua = {
		--       diagnostics = {
		--         -- Get the language server to recognize the `vim` global
		--         globals = { 'vim' },
		--       },
		--     },
		--   },
		-- }
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
