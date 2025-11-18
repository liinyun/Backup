---@class RustAnalyzerConfig
---@field assist Assist
---@field cachepriming CachePriming
---@field cargo Cargo
---@field checkOnSave boolean
---@field check Check
---@field completion Completion
---@field diagnostics Diagnostics
---@field files table
---@field highlightRelated table
---@field hover Hover
---@field imports table
---@field inlayHints table
---@field interpret table
---@field joinLines  table
---@field lens table
---@field linkedProjects string[]
---@field lru table
---@field notifications table
---@field numThreads integer|nil
---@field procMacro table
---@field references table
---@field rename table
---@field runnables table
---@field rust table
---@field rustc table
---@field rustfmt table|nil
---@field semanticHighlighting table
---@field signatureInfo table
---@field typing table
---@field workspace table

---@class Assist
---@field emitMustUse boolean
---@field expressionFillDefault string
---@field termSearch? TermSearch

---@class TermSearch
---@field borrowcheck  boolean  -- Enable borrow checking for term search code assists. If set to false, also there will be more suggestions, but some of them may not borrow-check.
---@field fuel boolean  -- Term search fuel in "units of work" for assists (Defaults to 1800).

---@class CachePriming
---@field enable boolean

---@class Cargo
---@field autoreload boolean
---@field buildScripts table
---@field cfgs string[]
---@field extraArgs string[]
---@field extraEnv string[]
---@field features? string[]|string
---@field noDefaultFeatures boolean
---@field sysroot string
---@field sysrootQueryMetadata boolean
---@field sysrootSrc string|nil
---@field target string|nil
---@field unsetTest string[]

---@class Check
---@field allTargets boolean
---@field targets string|string[]|nil
---@field command string
---@field extraArgs string[]

---@class Completion
---@field addSemicolonToUnit boolean  -- Whether to automatically add a semicolon when completing unit-returning functions. In match arms it completes a comma instead.

---@class Diagnostics
---@field enable boolean
---@field experimental Experimental  -- Whether to show experimental rust-analyzer diagnostics that might have more false positives than usual.
---@field styleLints StyleLints  -- Whether to run additional style lints.
---
---@class Experimental
---@field enable boolean
---
---@class StyleLints
---@field enable boolean

---@class Hover
---@field actions Actions
---
---@class Actions
---@field enable boolean
---@field debug Debug
---
---@class Debug
---@field enable boolean

---@class InlayHints
---@field bindingModeHints BindingModeHints  -- Whether to show inlay type hints for binding modes.
---@field chainingHints ChainingHints
---@field maxLength integer|nil  -- Maximum length for inlay hints. Set to null to have an unlimited length.
---
---@class BindingModeHints
---@field enable boolean
---@class ChainingHints
---@field enable boolean

---@class Lens
---@field enable boolean
---@field references References
---
---@class References
---@field adt ADT  -- Whether to show References lens for Struct, Enum, and Union. Only applies when #rust-analyzer.lens.enable# is set.
---@field trait Trait  -- Whether to show References lens for Trait. Only applies when #rust-analyzer.lens.enable# is set.
---@class ADT
---@field enable boolean
---@class Trait
---@field enable boolean

local M = {}

M = {
	"mrcjkb/rustaceanvim",
	version = "^5", -- Recommended
	-- lazy = false,   -- This plugin is already lazy
	opts = {
		-- config = function()
		-- ---@type RustAnalyzerConfig
		-- local raconfig = {
		tools = {
			on_initialized = function(status)
				local health = status.health

				if health == "ok" then
					vim.cmd.RustLsp("flyCheck")
					vim.lsp.codelens.refresh()
					-- elseif health == "warning" then
					--   vim.notify("ra health is " .. health, vim.log.levels.WARN)
					-- elseif health == "error" then
					--   vim.notify("ra health is " .. health, vim.log.levels.ERROR)
				end
			end,
		},
		server = {
			-- don't use on_init, it will thow error, but I don't know the reason why it can throw error
			on_attach = function(client, bufnr)
				-- if client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, { bufnr = bufnr }) then
				-- local _ = pcall(vim.lsp.inlay_hint.enable, true, { bufnr = bufnr })
				if not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }) then
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
				end
				-- end

				-- vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			end,
			default_settings = {
				["rust-analyzer"] = {
					rustc = { source = "discover" },
					assist = {
						importEnforceGranularity = true,
						importPrefix = "by_self",
						emitMustUse = false, -- Whether to insert #[must_use] when generating as_ methods for enum variants.
						expressionFillDefault = "todo", -- Placeholder expression to use for missing expressions in assists.
					},
					cargo = {
						autoreload = true,
						allFeatures = true,
						loadOutDirsFromCheck = true,
					},
					checkOnSave = true,
					check = {
						-- if true this would cause #![no_std] report error for no test
						allTargets = false,
						command = "clippy",
						extraArgs = {
							"--no-deps",
							"--message-format=json-diagnostic-rendered-ansi",
							"Wclippy::pedantic",
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
							-- "unused_mut", -- rustc 更准确

							-- clippy 的 lint 已经有这些了
							"needless_return",
						}, -- 要禁用的rust-analyzer诊断列表。
						experimental = {
							enable = false,
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
				},
			},
		},
	},
	-- end
	config = function(_, opts)
		-- vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, { desc = "Run CodeLens action" })
		vim.g.rustaceanvim = opts
	end,
}

return M
