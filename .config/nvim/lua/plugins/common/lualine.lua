-- Status line
-- 这个是lualine 的配置表格，我就不直接传入一个配置表了，毕竟还有很多东西需要配置
local M = {}

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

M = {
	-- https://github.com/nvim-lualine/lualine.nvim
	"nvim-lualine/lualine.nvim",
	dependencies = {
		-- https://github.com/nvim-tree/nvim-web-devicons
		"nvim-tree/nvim-web-devicons", -- fancy icons
		-- https://github.com/linrongbin16/lsp-progress.nvim
		"linrongbin16/lsp-progress.nvim", -- LSP loading progress
	},
	opts = {
		-- 这个控制的是一些全局的设定
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
	},
}

return M
