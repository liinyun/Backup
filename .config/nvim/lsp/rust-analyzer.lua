---@brief
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
local function is_descendant(root, path)
	if not path or not root then
		return false
	end

	local ok, relpath = pcall(vim.fs.relpath, path, root)
	if not ok or not relpath then
		return false
	end

	return relpath == "." or not relpath:match("^%.%./")
end

local function escape_wildcards(path)
	return path:gsub("([%[%]%?%*])", "\\%1")
end

local function root_pattern(...)
	local patterns = vim.iter({ ... }):flatten(math.huge):totable()

	return function(startpath)
		startpath = startpath or vim.fn.expand("%:p:h")

		for _, pattern in ipairs(patterns) do
			for path in vim.fs.parents(startpath) do
				local matches = vim.fn.glob(escape_wildcards(path) .. "/" .. pattern, true, true)

				for _, p in ipairs(matches) do
					if vim.uv.fs_stat(p) then
						return path
					end
				end
			end

			local matches = vim.fn.glob(escape_wildcards(startpath) .. "/" .. pattern, true, true)
			for _, p in ipairs(matches) do
				if vim.uv.fs_stat(p) then
					return startpath
				end
			end
		end

		return nil
	end
end

local function reload_workspace(bufnr)
	bufnr = bufnr == 0 and vim.api.nvim_get_current_buf() or bufnr
	local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "rust_analyzer" })
	for _, client in ipairs(clients) do
		vim.notify("Reloading Cargo Workspace")
		client.request("rust-analyzer/reloadWorkspace", nil, function(err)
			if err then
				error(tostring(err))
			end
			vim.notify("Cargo workspace reloaded")
		end, 0)
	end
end

-- local function is_library(fname)
-- 	local user_home = vim.fs.normalize(vim.env.HOME)
-- 	local cargo_home = os.getenv("CARGO_HOME") or user_home .. "/.cargo"
-- 	local registry = cargo_home .. "/registry/src"
-- 	local git_registry = cargo_home .. "/git/checkouts"
--
-- 	local rustup_home = os.getenv("RUSTUP_HOME") or user_home .. "/.rustup"
-- 	local toolchains = rustup_home .. "/toolchains"
--
-- 	for _, item in ipairs({ toolchains, registry, git_registry }) do
-- 		if is_descendant(item, fname) then
-- 			local clients = vim.lsp.get_clients({ name = "rust_analyzer" })
-- 			return #clients > 0 and clients[#clients].config.root_dir or nil
-- 		end
-- 	end
-- end

return {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },

	root_markers = {
		"Cargo.toml",
		".git",
	},
	settings = {
		["rust-analyzer"] = {

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
				},
			},
			diagnostics = {
				-- I don't actually know the functionality of this configuration
				-- but this config indeed extend my codeactions choices
				enable = true,
				refreshOnChange = true,
				disabled = {
					disabled = {
						"proc-macro-disabled",
						"unfulfilled_lint_expectations",
						-- rustc 的 lint 已经有这些了
						"unused_variables",
						"unused_mut", -- rustc 更准确

						-- clippy 的 lint 已经有这些了
						"needless_return",
					}, -- 要禁用的rust-analyzer诊断列表。
				},
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
	-- root_dir = function(bufnr, on_dir)
	-- 	local fname = vim.api.nvim_buf_get_name(bufnr)
	-- 	local reused_dir = is_library(fname)
	-- 	if reused_dir then
	-- 		on_dir(reused_dir)
	-- 		return
	-- 	end
	--
	-- 	local cargo_crate_dir = root_pattern("Cargo.toml")(fname)
	-- 	local cargo_workspace_root
	--
	-- 	if cargo_crate_dir == nil then
	-- 		on_dir(
	-- 			root_pattern("rust-project.json")(fname)
	-- 				or vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
	-- 		)
	-- 		return
	-- 	end
	--
	-- 	local cmd = {
	-- 		"cargo",
	-- 		"metadata",
	-- 		"--no-deps",
	-- 		"--format-version",
	-- 		"1",
	-- 		"--manifest-path",
	-- 		cargo_crate_dir .. "/Cargo.toml",
	-- 	}
	--
	-- 	vim.system(cmd, { text = true }, function(output)
	-- 		if output.code == 0 then
	-- 			if output.stdout then
	-- 				local result = vim.json.decode(output.stdout)
	-- 				if result["workspace_root"] then
	-- 					cargo_workspace_root = vim.fs.normalize(result["workspace_root"])
	-- 				end
	-- 			end
	--
	-- 			on_dir(cargo_workspace_root or cargo_crate_dir)
	-- 		else
	-- 			vim.schedule(function()
	-- 				vim.notify(
	-- 					("[rust_analyzer] cmd failed with code %d: %s\n%s"):format(output.code, cmd, output.stderr)
	-- 				)
	-- 			end)
	-- 		end
	-- 	end)
	-- end,
	-- capabilities = {
	-- 	experimental = {
	-- 		serverStatusNotification = true,
	-- 	},
	-- },
	capabilities = lsp_capabilities,
	-- before_init = function(init_params, config)
	-- 	-- See https://github.com/rust-lang/rust-analyzer/blob/eb5da56d839ae0a9e9f50774fa3eb78eb0964550/docs/dev/lsp-extensions.md?plain=1#L26
	-- 	if config.settings and config.settings["rust-analyzer"] then
	-- 		init_params.initializationOptions = config.settings["rust-analyzer"]
	-- 	end
	-- end,
	on_attach = function(client, bufnr)
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
		-- vim.api.nvim_buf_create_user_command(0, "LspCargoReload", function()
		-- 	reload_workspace(0)
		-- end, { desc = "Reload current cargo workspace" })
	end,
}
