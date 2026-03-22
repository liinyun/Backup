vim.pack.add({
	{ src = "https://github.com/numToStr/Comment.nvim.git" },
}, { confirm = false })
require("Comment").setup({
	ignore = nil,
})

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

-- ==============================TODO-comments====================================
vim.pack.add({
	{ src = "https://github.com/folke/todo-comments.nvim.git" },
}, { confirm = false })

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
	allowed_dirs = { "~" }, -- Table of dirs that the plugin will start and autoload from
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
