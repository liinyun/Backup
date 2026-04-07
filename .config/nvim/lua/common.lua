-- vim.pack.add({
-- 	{ src = "https://github.com/numToStr/Comment.nvim.git" },
-- }, { confirm = false })
-- require("Comment").setup({
-- 	ignore = nil,
-- })

vim.pack.add({
	{ src = "https://github.com/LunarVim/bigfile.nvim.git" },
}, { confirm = false })

vim.pack.add({
	{ src = "https://github.com/kylechui/nvim-surround.git" },
}, { confirm = false })

vim.pack.add({
	{ src = "https://github.com/kevinhwang91/nvim-bqf.git" },
}, { confirm = false })

vim.pack.add({
	{ src = "https://github.com/lambdalisue/vim-suda.git" },
}, { confirm = false })

vim.pack.add({
	{ src = "https://github.com/brenoprata10/nvim-highlight-colors.git" },
}, { confirm = false })
require("nvim-hight-colors").setup({
	---Render style
	---@usage 'background'|'foreground'|'virtual'
	render = "background",

	---Set virtual symbol (requires render to be set to 'virtual')
	virtual_symbol = "■",

	---Set virtual symbol suffix (defaults to '')
	virtual_symbol_prefix = "",

	---Set virtual symbol suffix (defaults to ' ')
	virtual_symbol_suffix = " ",

	---Set virtual symbol position()
	---@usage 'inline'|'eol'|'eow'
	---inline mimics VS Code style
	---eol stands for `end of column` - Recommended to set `virtual_symbol_suffix = ''` when used.
	---eow stands for `end of word` - Recommended to set `virtual_symbol_prefix = ' ' and virtual_symbol_suffix = ''` when used.
	virtual_symbol_position = "inline",

	---Highlight hex colors, e.g. '#FFFFFF'
	enable_hex = true,

	---Highlight short hex colors e.g. '#fff'
	enable_short_hex = true,

	---Highlight rgb colors, e.g. 'rgb(0 0 0)'
	enable_rgb = true,

	---Highlight hsl colors, e.g. 'hsl(150deg 30% 40%)'
	enable_hsl = true,

	---Highlight CSS variables, e.g. 'var(--testing-color)'
	enable_var_usage = true,

	---Highlight named colors, e.g. 'green'
	enable_named_colors = true,

	---Highlight tailwind colors, e.g. 'bg-blue-500'
	enable_tailwind = false,

	---Set custom colors
	---Label must be properly escaped with '%' to adhere to `string.gmatch`
	--- :help string.gmatch
	custom_colors = {
		{ label = "%-%-theme%-primary%-color", color = "#0f1219" },
		{ label = "%-%-theme%-secondary%-color", color = "#5a5d64" },
	},

	-- Exclude filetypes or buftypes from highlighting e.g. 'exclude_buftypes = {'text'}'
	exclude_filetypes = {},
	exclude_buftypes = {},
})

-- ==============================TODO-comments====================================
vim.pack.add({
	{ src = "https://github.com/folke/todo-comments.nvim.git" },
}, { confirm = false })

require("todo-comments").setup({
	sign = true, -- show icons in the signs column
	-- 这个是用来控制 符号的优先级的，防止和其他插件的符号冲突
	-- 如果别的插件想要使用符号栏，那么可能会与 todo-comments 的符号冲突，那么nvim 会选择显示哪个符号看的就是这个符号的优先级
	-- 所以有些插件就会使用 virtual text 来避免冲突，比如 lsp 。事实上，我个人感觉 lsp 其实对于符号的占用还是比较有限的，lsp 很多时候都是 virtual texg 在起作用
	-- 而且，我一般也不会看lsp 的 icons 而是选择使用 Trouble 之类的插件直接进行跳转才是更加合适的方案
	sign_priority = 8, -- sign priority
	keywords = {
		FIX = {
			icon = " ", -- icon used for the sign, and in search results
			color = "error", -- can be a hex color, or a named color (see below)
			alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
			-- signs = false, -- configure signs for some keywords individually
		},
		TODO = { icon = " ", color = "info" },
		HACK = { icon = " ", color = "warning" },
		WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
		PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
		NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
		TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
		QUES = { icon = "❔", color = "warning", alt = { "QUESTION" } },
		THOUGHT = { icon = " ", color = "thoughts", alt = { "thought" } },
		question = { icon = "❔", color = "question", alt = { "questions" } },
		FINISH = { icon = " ", color = "info", alt = { "finish" } },
		PURPLE = { icon = "❔", color = "purple", alt = { "purp" } },
		-- QUES = { icon = "?", color = "hint", alt = { "???" } },
	},
	gui_style = {
		fg = "NONE", -- The gui style to use for the fg highlight group.
		bg = "BOLD", -- The gui style to use for the bg highlight group.
	},
	highlight = {
		multiline = true, -- enable multine todo comments
		multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
		multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
		before = "", -- "fg" or "bg" or empty
		keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
		after = "fg", -- "fg" or "bg" or empty
		pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
		comments_only = true, -- uses treesitter to match keywords in comments only
		max_line_len = 400, -- ignore lines longer than this
		exclude = {}, -- list of file types to exclude highlighting
	},
	-- list of named colors where we try to extract the guifg from the
	-- list of highlight groups or use the hex color if hl not found as a fallback
	colors = {
		error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
		warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
		info = { "DiagnosticInfo", "#2563EB" },
		hint = { "DiagnosticHint", "#10B981" },
		default = { "Identifier", "#7C3AED" },
		test = { "Identifier", "#FF00FF" },
		thoughts = { "thoughts", "#2563EB" },
		question = { "question", "#ffee32" },
		purple = { "purple", "#7C3AED" },
	},
})

-- ===================================ui2=========================================
require("vim._core.ui2").enable({
	enable = true, -- Whether to enable or disable the UI.
	msg = { -- Options related to the message module.
		---@type 'cmd'|'msg' Default message target, either in the
		---cmdline or in a separate ephemeral message window.
		---@type string|table<string, 'cmd'|'msg'|'pager'> Default message target
		---or table mapping |ui-messages| kinds and triggers to a target.
		targets = "msg",
		cmd = { -- Options related to messages in the cmdline window.
			height = 0.5, -- Maximum height while expanded for messages beyond 'cmdheight'.
		},
		dialog = { -- Options related to dialog window.
			height = 0.5, -- Maximum height.
		},
		msg = { -- Options related to msg window.
			height = 0.5, -- Maximum height.
			timeout = 4000, -- Time a message is visible in the message window.
		},
		pager = { -- Options related to message window.
			height = 1, -- Maximum height.
		},
	},
})

-- ================================persisted======================================
vim.pack.add({
	{ src = "https://github.com/olimorris/persisted.nvim.git" },
}, { confirm = false })
require("persisted").setup({
	autostart = true, -- automatically start the plugin on load
	autoload = true, -- automatically load the session for he cwd on neovim startup
	-- Function to run when `autoload = true` but there is no session to load
	---@type fun(): any
	on_autoload_no_session = function() end,

	config = true,
	save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"),
	-- Set `lazy = false` in `plugins/editor.lua` to enable this
	follow_cwd = true,
	use_git_branch = true,
	should_save = function()
		return vim.bo.filetype == "alpha" and false or true
	end,
	-- 这个不是官方写法，感觉有点脑残了，不过也能用，不管了
	-- allowed_dirs = { "~" }, -- Table of dirs that the plugin will start and autoload from
})

-- ==============================render markdown==================================

vim.pack.add({
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim.git" },
}, { confirm = false })

require("render-markdown").setup({
	enabled = true,
	preset = "none",
	file_types = { "markdown", "html" },
	render_modes = { "n", "c", "t" },
	latex = { enabled = false },
	-- injections = {
	-- 	markdown = {
	-- 		enabled = true,
	-- 		query = [[
	--              ((message) @injection.content
	--                  (#set! injection.combined)
	--                  (#set! injection.include-children)
	--                  (#set! injection.language "html"))
	--          ]],
	-- 	},
	-- },
})

-- =====================================fzf======================================

vim.pack.add({
	{ src = "https://github.com/ibhagwan/fzf-lua.git" },
}, { confirm = false })

local fzf_cmd = require("fzf-lua")
vim.keymap.set("n", "<leader>ff", fzf_cmd.files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", fzf_cmd.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", fzf_cmd.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>ft", fzf_cmd.lsp_document_symbols, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fi", fzf_cmd.lsp_incoming_calls, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fo", fzf_cmd.lsp_outgoing_calls, { desc = "Telescope buffers" })

-- =================================autopairs=================================
vim.pack.add({
	{ src = "https://github.com/windwp/nvim-autopairs.git" },
}, { confirm = false })
require("nvim-autopairs").setup({
	check_ts = true, -- enable treesitter
	ts_config = {
		lua = { "string" }, -- don't add pairs in lua string treesitter nodes
		javascript = { "template_string" }, -- don't add pairs in javascript template_string
	},
})

-- ================================neotree==================================
vim.pack.add({
	{ src = "https://github.com/nvim-neo-tree/neo-tree.nvim.git" },
}, { confirm = false })

require("neo-tree").setup({
	enable_git_status = true,
	enable_diagnostics = true,
	defaults_components_configs = {
		indent = {
			with_markers = true,
			indent_marker = "│",
			last_indent_marker = "└",
			indent_size = 3,
		},
		icon = {
			folder_closed = "",
			folder_open = "",
			folder_empty = "󰜌",
			provider = function(icon, node, state) -- default icon provider utilizes nvim-web-devicons if available
				if node.type == "file" or node.type == "terminal" then
					local success, web_devicons = pcall(require, "nvim-web-devicons")
					local name = node.type == "terminal" and "terminal" or node.name
					if success then
						local devicon, hl = web_devicons.get_icon(name)
						icon.text = devicon or icon.text
						icon.highlight = hl or icon.highlight
					end
				end
			end,
			-- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
			-- then these will never be used.
			default = "*",
			highlight = "NeoTreeFileIcon",
		},
	},

	filesystem = {
		filtered_items = {
			visible = false,
			-- hide_dotfiles = false,
			-- hide_hidden = false,
		},
	},
	window = {
		position = "float",
		-- position = "left",
		mappings = {
			["p"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
			["P"] = { "paste_from_clipboard" },
			["<Tab>"] = { "toggle_node" },
		},
	},
})
-- vim.keymap.set('n', '<leader>ee', ':Neotree float<CR>') -- open as float window
vim.keymap.set("n", "<leader>ee", ":Neotree reveal<cr>") -- open as float window

-- ==============================lualine==========================================
local funcs = {}
local function get_venv(variable)
	local venv = os.getenv(variable)
	if venv ~= nil and string.find(venv, "/") then
		local orig_venv = venv
		for w in orig_venv:gmatch("([^/]+)") do
			venv = w
		end
		venv = string.format("%s", venv)
	end
	return venv
end

funcs.python_venv = function()
	if vim.bo.filetype == "python" then
		-- print(clients)
		-- local venv = os.getenv("CONDA_DEFAULT_ENV")
		local venv = get_venv("CONDA_DEFAULT_ENV") or get_venv("VIRTUAL_ENV") or "NO ENV"
		if venv then
			-- package = "",           -- 用于 Python 包或虚拟环境
			-- python = "󰌠",            -- 用于 Python 语言标识
			-- 
			-- 这里是直接返回图标，我看看以后有没有办法弄得更加好看吧
			-- print(venv)
			return " " .. venv
			-- return "yes"
		end
	end
	return ""
end

vim.pack.add({
	{ src = "https://github.com/nvim-lualine/lualine.nvim.git" },
}, { confirm = false })
require("lualine").setup({
	options = {
		-- 我先在开头将默认配置粘贴一下
		icons_enabled = true,
		-- 这个是分割符，这个是同一个 section 的分割符号
		component_separators = { left = "", right = "" },
		-- 这个是不同section 的分隔符号
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
		-- 这个是我修改的配置，以后修改过的地方我都会注释一下
		-- For more themes, see https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md
		theme = "codedark", -- "auto, tokyonight, catppuccin, codedark, nord"
	},
	-- 现在是一些我自己定义的组件的内容
	-- 这个才是控制状态栏显示的内容的
	-- lualine_a   lualine_b  lualine_c  lualine_x  lualine_y  lualine_z
	-- 这些控制显示的内容
	-- +-------------------------------------------------+
	-- | A | B | C                             X | Y | Z |
	-- +-------------------------------------------------+
	sections = {
		-- 这两个也是默认的配置
		lualine_a = { "mode" },
		lualine_b = {
			"branch",
			{
				"diff",

				symbols = { added = "+", modified = "~", removed = "-" }, -- Changes the symbols used by the diff.
				colored = true, -- Displays a colored diff status if set to true
			},
			{
				"diagnostics",
				sections = { "error", "warn", "info", "hint" },
				symbols = { error = "E", warn = "W", info = "I", hint = "H" },
				colored = true,
				always_visible = false, -- Show diagnostics even if there are none.
			},
		},
		-- 这个是我自定义的配置
		lualine_c = {
			{
				-- Customize the filename part of lualine to be parent/filename
				-- 这个 filename 下面都是 filename 的一些属性
				"filename",
				-- 是否检测文件的状态
				file_status = true, -- Displays file status (readonly status, modified status)
				newfile_status = false, -- Display new file status (new file means no write after created)
				-- 为我这里让他显示完整的路径了
				path = 3, -- 0: Just the filename
				-- 1: Relative path
				-- 2: Absolute path
				-- 3: Absolute path, with tilde as the home directory
				-- 4: Filename and parent dir, with tilde as the home directory
				-- 如果要检测出来的文件状态如果 是 modified 的话，就使用[+]
				-- 否则就使用[-]
				symbols = {
					modified = "[+]", -- Text to show when the file is modified.
					readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
				},
			},
		},
		-- 下面的这三个也是默认的配置
		lualine_x = { "encoding", "filetype" },
		lualine_y = {
			funcs.python_venv,
			{ "progress" },
		},
		lualine_z = {
			{
				"searchcount",
				maxcount = 9999,
				timeout = 500,
			},
			{ "location" },
		},
	},

	-- 这个是非选中的窗口会显示的内容
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	-- 这个控制的是 nvim 的顶栏
	tabline = {},
	-- 在窗口顶部显示额外的信息
	winbar = {},
	inactive_winbar = {},
	-- 配置插件的样式
	extensions = {},
})
