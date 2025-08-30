local api = vim.api
local au = api.nvim_create_autocmd
local lsp_group = api.nvim_create_augroup("lspGroup", {})
local monkeyc_group = api.nvim_create_augroup("monkeycGroup", {})

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

au("UIEnter", {
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
				-- "clangd",
				-- "rust_analyzer",
				"basedpyright",
				-- "ruff",
				-- "zls",
				-- "cmake",
				"volar",
				-- "tsls",
        "vtsls"
				-- "rust-analyzer",
			})

			vim.lsp.log.set_level(vim.log.levels.DEBUG)

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
-- au("BufRead,BufNewFile",{
--
-- })
