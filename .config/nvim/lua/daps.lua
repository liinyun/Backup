vim.pack.add({
	{ src = "https://github.com/mfussenegger/nvim-dap.git" },
}, { confirm = false })

local dap = require("dap")
-- dap.set_log_level("TRACE")
dap.adapters.codelldb = {
	type = "executable",
	command = "codelldb", -- or if not in $PATH: "/absolute/path/to/codelldb"

	-- On windows you may have to uncomment this:
	-- detached = false,
}

dap.configurations.c = {
	{
		name = "default codelldb Launch",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopAtEntry = false,
		terminal = "integrated",
		MIMode = "lldb",
		stopOnEntry = true,
	},
}

dap.adapters.gdb = {
	type = "executable",
	command = "rust-gdb",
	args = { "-i", "dap" },
}
dap.configurations.c = {
	{
		name = "default GDB Launch",
		type = "gdb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		console = "integratedTerminal",
		terminal = "integrated",
		stopOnEntry = true,
	},
}

dap.configurations.asm = {
	{
		name = "default GDB Assembly Launch",
		type = "gdb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		console = "integratedTerminal",
		terminal = "integrated",
		stopOnEntry = true,
	},
}

vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "DapBreakpoint", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = " ", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = " ", texthl = "", linehl = "", numhl = "" }) -- 󰍩
vim.fn.sign_define("DapStopped", { text = "👉", texthl = "", linehl = "", numhl = "" })

vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "toggle break point" })

vim.keymap.set("n", "<space>B", function()
	dap.set_breakpoint(vim.fn.input("Condition: "), vim.fn.input("Hit condition: "), vim.fn.input("Log message: "))
end)
vim.keymap.set("n", "<space>lp", function()
	dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end)

vim.keymap.set({ "n", "i", "t" }, "<F1>", dap.continue)
vim.keymap.set({ "n", "i", "t" }, "<F2>", dap.step_over)
vim.keymap.set({ "n", "i", "t" }, "<F3>", dap.step_into)
vim.keymap.set({ "n", "i", "t" }, "<F4>", dap.step_out)
vim.keymap.set({ "n", "i", "t" }, "<F5>", dap.step_back)
vim.keymap.set({ "n", "i", "t" }, "<F6>", dap.run_last)
vim.keymap.set({ "n", "i", "t" }, "<F7>", dap.terminate)
vim.keymap.set({ "n", "i", "t" }, "<F8>", dap.pause)
vim.keymap.set({ "n", "i", "t" }, "<F9>", dap.disconnect)
-- vim.keymap.set({ "n", "i", "t" }, "<leader>rtc", dap.run_to_cursor)
-- vim.keymap.set("n", "<space>dr", dap.repl.open)

vim.pack.add({
	{ src = "https://github.com/igorlfs/nvim-dap-view.git" },
}, { confirm = false })

local dapview = require("dap-view")
dapview.setup({
	icons = {
		disconnect = "",
		pause = " 󱊲",
		play = " 󱊫",
		run_last = " 󱊰",
		step_back = " 󱊳",
		step_into = " 󱊭",
		step_out = " 󱊮",
		step_over = " 󱊬",
		terminate = " 󱊱",
	},
	auto_toggle = true,
	switchbuf = "newtab",
	follow_tab = true,
	help = {
		border = "double",
	},
	winbar = {
		controls = {
			enabled = true,
			buttons = {
				"play",
				"step_over",
				"step_into",
				"step_out",
				"step_back",
				"run_last",
				"terminate",
				"disconnect",
			},
		},
		default_section = "scopes",
		sections = {
			-- "console",
			"watches",
			"scopes",
			"exceptions",
			"breakpoints",
			"threads",
			"repl",
			"sessions",
			-- "disassembly",
		},
	},
	windows = {
		position = "below",
		terminal = {
			position = "left",
		},
	},
})
