-- ---@brief
---
--- https://github.com/rust-lang/rust-analyzer
---
--- rust-analyzer (aka rls 2.0), a language server for Rust
---
---
--- See [docs](https://rust-analyzer.github.io/book/configuration.html) for extra settings. The settings can be used like this:
--- ```lua
--- vim.lsp.config('rust_analyzer', {
---   settings = {
---     ['rust-analyzer'] = {
---       diagnostics = {
---         enable = false;
---       }
---     }
---   }
--- })
--- ```
---
--- Note: do not set `init_options` for this LS config, it will be automatically populated by the contents of settings["rust-analyzer"] per
--- https://github.com/rust-lang/rust-analyzer/blob/eb5da56d839ae0a9e9f50774fa3eb78eb0964550/docs/dev/lsp-extensions.md?plain=1#L26.

local lsp_capabilities = require("blink.cmp").get_lsp_capabilities()

return {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },

	root_markers = {
		"Cargo.toml",
		".git",
	},
	settings = {
		["rust-analyzer"] = {
			rustc = { source = "discover" },

			assist = {
				importEnforceGranularity = true,
				importPrefix = "by_self",
				emitMustUse = false, -- Whether to insert #[must_use] when generating as_ methods for enum variants.
				expressionFillDefault = "todo", -- Placeholder expression to use for missing expressions in assists.
			},
			cachePrimint = {
				enable = true,
			},

			cargo = {
				autoreload = true,
				allFeatures = true,
				loadOutDirsFromCheck = true,
				features = "all",
			},
			checkOnSave = true,
			check = {
				-- if true this would cause #![no_std] report error for no test
				allTargets = false,
				command = "clippy",
				extraArgs = {
					-- "--no-deps",
					-- "--message-format=json-diagnostic-rendered-ansi",
					-- "Wclippy::pedantic",
					-- "Wclippy::clone_on_ref_ptr",
					"--no-deps",
					"--", -- Separator: Everything after this goes to Clippy, not Cargo
					"-W",
					"clippy::pedantic",
					-- "-W",
					-- "clippy::clone_on_ref_ptr",
				},
			},
			diagnostics = {
				-- I don't actually know the functionality of this configuration
				-- but this config indeed extend my codeactions choices
				enable = true,
				refreshOnChange = true,
				disabled = {
					"proc-macro-disabled",
					"unfulfilled_lint_expectations",
					-- rustc 的 lint 已经有这些了
					"unused_variables",
					"unused_mut", -- rustc 更准确

					-- clippy 的 lint 已经有这些了
					"needless_return",
				}, -- 要禁用的rust-analyzer诊断列表。
				experimental = {
					enable = false,
					serverStatusNotification = true,
				},
				styleLints = {
					enable = true,
				},
			},
			highlightRelated = {
				breakPoints = { enable = true }, -- 当光标位于 break 、 loop 、 while 或 for 关键字上时，启用相关引用的高亮显示。
				closureCaptures = { enable = true }, -- 当光标位于闭包的 | 或move关键字上时，启用对闭包的所有捕获的高亮显示。
				exitPoints = { enable = true }, -- 当光标位于 return 、 ? 、 fn 或返回类型箭头（ → ）上时，启用所有退出点的高亮显示。
				references = { enable = true }, -- 当光标位于任何标识符上时，启用相关引用的高亮显示。
				yieldPoints = { enable = true }, -- 当光标位于任何 async 或 await 关键字上时，启用高亮显示循环或块上下文的所有断点。
			},
			procMacro = {
				enable = true,
			},
			---@type Hover
			hover = {
				actions = {
					enable = true,
					debug = {
						enable = true,
					},
				},
			},
			---@type InlayHints
			inlayHints = {
				closingBraceHints = { enable = true, minLines = 40 },
				closureCaptureHints = { enable = false },
				closureReturnTypeHints = { enable = "always" }, -- never
				closureStyle = "impl_fn",
				expressionAdjustmentHints = { -- reborrow, loop的返回值
					enable = "always",
					hideOutsideUnsafe = true,
					mode = "prefix",
					-- mode = "postfix ",
				},
				lifetimeElisionHints = { enable = "always", useParameterNames = true },
				parameterHints = { enable = true },
				renderColons = true,
				typeHints = { enable = true, hideClosureInitialization = false, hideNamedConstructor = false },
				interpret = { tests = false },
				joinLines = {
					joinAssignments = true, -- Join lines merges consecutive declaration and initialization of an assignment.
					joinElseIf = true, -- Join lines inserts else between consecutive ifs.
					removeTrailingComma = true, -- Join lines removes trailing commas.
					unwrapTrivialBlock = true, -- Join lines unwraps trivial blocks.
				},

				maxLength = 100,
				bindingModeHints = {
					enable = true,
				},
				chainingHints = {
					enable = true,
				},
				discriminantHints = {
					enable = "always",
				},
			},
			typing = {
				autoClosingAngleBrackets = { enable = true }, -- 键入泛型参数列表的左尖括号时是否插入右尖括号。
			},
			---@type Lens
			lens = {
				enable = true,
				run = {
					enable = false,
				},
				debug = {
					enable = false,
				},
				references = {
					adt = {
						enable = true,
					},
					trait = {
						enable = true,
					},
				},
			},

			imports = {
				granularity = {
					group = "module",
				},
				prefix = "self",
			},
			completion = {
				fullFunctionSignatures = true,
			},
		},
	},
	capabilities = lsp_capabilities,
	-- before_init = function(init_params, config)
	-- 	-- See https://github.com/rust-lang/rust-analyzer/blob/eb5da56d839ae0a9e9f50774fa3eb78eb0964550/docs/dev/lsp-extensions.md?plain=1#L26
	-- 	if config.settings and config.settings["rust-analyzer"] then
	-- 		init_params.initializationOptions = config.settings["rust-analyzer"]
	-- 	end
	-- end,
	on_attach = function(client, bufnr)
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
		vim.lsp.codelens.enable(true)
		-- local caps = client.server_capabilities
		-- if caps.codeLensProvider then
		-- 	local my_codelens = require("custom_codelens")
		-- 	my_codelens.enable(true, { bufnr = bufnr })
		-- 	-- my_codelens.refresh({ bufnr = bufnr })
		--
		-- 	-- Keymap specifically for this buffer
		-- 	-- vim.keymap.set("n", "<leader>cl", my_codelens.run, { buffer = bufnr, desc = "LSP CodeLens" })
		-- end
		-- vim.api.nvim_buf_create_user_command(0, "LspCargoReload", function()
		-- 	reload_workspace(0)
		-- end, { desc = "Reload current cargo workspace" })
	end,
}
