local api = vim.api
local au = api.nvim_create_autocmd
local lsp_group = api.nvim_create_augroup("lspGroup", {})
-- local monkeyc_group = api.nvim_create_augroup("monkeycGroup", {})

-- au("ExitPre", {
-- 	group = group,
-- 	callback = function()
-- 		if vim.env.TERM == "alacritty" then
-- 			vim.o.guicursor = "a:ver90"
-- 		end
-- 	end,
-- 	desc = "Set cursor back to beam when leaving Neovim.",
-- })

-- au("LspAttach", {
-- 	group = group,
-- 	callback = function(args)
-- 		local client = vim.lsp.get_client_by_id(args.data.client_id)
-- 		if vim.bo[args.buf].filetype == "lua" and api.nvim_buf_get_name(args.buf):find("_spec") then
-- 			vim.diagnostic.enable(false, { bufnr = args.buf })
-- 		end
-- 		if client and client:supports_method("textDocument/documentColor") then
-- 			vim.lsp.document_color.enable(true, args.buf)
-- 		end
--
-- 		if client then
-- 			client.server_capabilities.semanticTokensProvider = nil
-- 		end
-- 	end,
-- })

vim.api.nvim_create_autocmd("UIEnter", {
	group = lsp_group,
	once = true,
	callback = function()
		vim.schedule(function()
			-- require("private.keymap")
			vim.lsp.enable({
				"luals",
				"kotlin_lsp",
				"bashls",
				"tinymist",
				"matlabls",
				"monkeyc",
				"marksman",
				"clangd",
				-- "basedpyright",
				"ty",
				"ruff",
				-- "zls",
				-- "cmake",
				"volar",
				-- "tsls",
				"vtsls",
				-- "rust-analyzer",
				"dartls",
				"csharpls",
				-- "postgres_ls",
				"sqls",
				"texlab",
				"jetls",
				-- "julials",
				-- "juliaimagels",
			})

			vim.lsp.log.set_level(vim.log.levels.WARN) -- INFO, WARN,DEBUG,TRACE,ERROR,OFF

			vim.diagnostic.config({
				-- virtual_text = { current_line = true },
				virtual_text = false,
				-- signs = {
				-- 	text = { "●", "●", "●", "●" },
				-- 	numhl = {
				-- 		"DiagnosticError",
				-- 		"DiagnosticWarn",
				-- 		"DiagnosticInfo",
				-- 		"DiagnosticHint",
				-- 	},
				-- },
			})

			api.nvim_create_user_command("LspLog", function()
				vim.cmd(string.format("tabnew %s", vim.lsp.get_log_path()))
			end, {
				desc = "Opens the Nvim LSP client log.",
			})

			vim.api.nvim_create_user_command("LspInfo", function()
				vim.cmd("checkhealth vim.lsp")
			end, {
				desc = "Displays attached, active, and configured language servers",
			})

			api.nvim_create_user_command("LspDebug", function()
				vim.lsp.log.set_level(vim.log.levels.WARN)
			end, { desc = "enable lsp log" })

			-- require("private.grep")

			-- vim.cmd.packadd("nohlsearch")
		end)
	end,
	desc = "Initializer",
})

-- Create an augroup to manage the autocmds
local progress_group = vim.api.nvim_create_augroup("UserLspProgress", { clear = true })

vim.api.nvim_create_autocmd("LspProgress", {
	group = progress_group,
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then
			return
		end

		-- Extract data from the event
		local value = args.data.params.value
		if not value or type(value) ~= "table" then
			return
		end

		local client_name = client.name
		local title = value.title or ""
		local message = value.message or ""
		local percentage = value.percentage and (value.percentage .. "%%") or ""

		-- Format the message
		local msg = string.format("[%s] %s %s %s", client_name, title, message, percentage)

		-- Clean up when finished
		if value.kind == "end" then
			vim.defer_fn(function()
				vim.api.nvim_echo({ { "" } }, false, {})
			end, 2000)
			msg = string.format("[%s] Finished", client_name)
		end

		-- Display the message without it being stuck in :messages history
		vim.api.nvim_echo({ { msg, "None" } }, true, {})
	end,
})
