-- 这个配置太零散了，以后要找机会将这个配置整理一下
-- this is the config only related to neovim's default api which means no plugin related config is allowed here

local OSName = vim.uv.os_uname().sysname
local opt = vim.opt

-- Session Management it is the default session manager in neovin
-- opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- this is global spell check. if opened, it create undercurl under words
vim.opt.spell = false

-- Line Numbers
-- opt.relativenumber = true
opt.number = true

-- hide searchcount
vim.opt.shortmess:append("S")
-- vim.fn.searchcount({ maxcount = 99999 })

-- Tabs & Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
vim.bo.softtabstop = 2
vim.o.winborder = "rounded"

-- enable 24bit RGB color in TUI
vim.opt.termguicolors = true

-- auto detect fileencodings
vim.opt.fileencodings = "ucs-bom,utf-8,gb18030,gbk,gb2312,cp936,big5,latin1"

-- vim.o.completeopt = "preview"

-- Line Wrapping
opt.wrap = true
-- opt.formatoptions = "croqn2mB1"
-- opt.textwidth = 72
-- vim.wo.wrap = true --soft wrapping
vim.wo.linebreak = false
-- vim.formatoptions = "croqn2mB1"
vim.textwidth = 72

-- Search Settings
opt.ignorecase = true
opt.smartcase = true

-- Cursor Line
-- 光标所在行 高亮
opt.cursorline = true

-- 禁用 Node.js 宿主支持，从此 checkhealth 不再报错
vim.g.loaded_node_provider = 0

-- 顺便你也可以禁用 perl, ruby 和 python 的宿主支持（如果你也不用它们写的旧插件）
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
vim.diagnostic.config({
	float = { border = "rounded" }, -- add border to diagnostic popups
	virtual_text = true,
	undofile = true,
})

-- this is to add node_modules to the path, this will search node_modules in the whole project
vim.opt.path:append("**/node_modules/**")
-- this config is set for ts, for gf will recognize @ as a special character, so here I change it
vim.opt.isfname:append("@-@")

-- Backspace
opt.backspace = "indent,eol,start"

-- Split Windows
-- 这个是 nvim 新建窗口都是默认创建在 左边和上面的，这种设置有点违反直觉
-- 所以这里就设置成默认在 右边和下面打开
opt.splitright = true
opt.splitbelow = true
-- it would view word connected with "-" one when you use alt+k to find next match
opt.iskeyword:append("-")

-- Disable the mouse while in nvim
opt.mouse = "a"

-- Folding
-- opt.foldlevel = 100
local function myFoldText()
	return "++-"
end

opt.foldlevelstart = 100
-- opt.foldexpr = "nvim_treesitter#foldexpr()" -- Utilize Treesitter folds
opt.foldmethod = "indent"
opt.foldtext = myFoldText()
-- vim.opt.foldcolumn = "3"
-- opt.foldtext = vim.fn.getline(vim.v.foldstart)
vim.opt.fillchars:append("fold:-")
-- vim.o.foldexpr = "v:lua.vim.lsp.foldexpr()"

-- 设置撤销文件的保存路径
local undodir = vim.fn.stdpath("data") .. "/undodir"
if vim.fn.isdirectory(undodir) == 0 then
	-- 如果不存在就创建这个文件夹
	vim.fn.mkdir(undodir, "p")
end
vim.opt.undodir = undodir
-- 启用持久化撤销
vim.opt.undofile = true
-- 这里是使用空格来代替制表符，这个肯定是必须的，这样就能保证在不同的文件
-- 中的格式是一样的
vim.opt.expandtab = true

vim.filetype.add({
	pattern = {
		-- Matches a file named "config.txt" in the root directory
		["kdeglobals"] = "ini",
	},
	-- You can also use "extension" or "magic" (content inspection) here
})

-- transfer dos to unix
vim.api.nvim_create_user_command("Dos2Unix", function()
	-- Execute the commands in sequence
	vim.cmd("e ++ff=dos")
	vim.cmd("set fileformat=unix")
	vim.cmd("update")
end, {})

-- Auto-save when leaving Insert mode (entering Normal mode)
-- local function SaveFileEnteringNormalMode()
-- 	vim.cmd("silent! update")
-- 	local filetype = vim.bo.filetype
-- 	if filetype == "rust" then
-- 		-- this function could get an error. If I change mode before rust lsp is fully loaded, it may throw error, but it's ok, it's just because the lsp is not fully loaded
-- 		vim.cmd("RustLsp flyCheck")
-- 		vim.lsp.codelens.refresh()
-- 	end
-- end
--
-- vim.api.nvim_create_autocmd("ModeChanged", {
-- 	pattern = "i*:*",
-- 	-- nested = true,
-- 	callback = SaveFileEnteringNormalMode,
-- })

-- set self defined comment pattern
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.dae", -- Replace with your file extension (e.g., *.foo)
	callback = function()
		vim.bo.commentstring = "# %s" -- Example: Use `#` for comments (like Python)
		-- Alternatives:
		-- vim.bo.commentstring = "// %s"  (C-style)
		-- vim.bo.commentstring = "<!-- %s -->"  (HTML)
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.kdl", -- Replace with your file extension (e.g., *.foo)
	callback = function()
		vim.bo.commentstring = "// %s" -- Example: Use `#` for comments (like Python)
		-- Alternatives:
		-- vim.bo.commentstring = "// %s"  (C-style)
		-- vim.bo.commentstring = "<!-- %s -->"  (HTML)
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "ini", -- Replace with your file extension (e.g., *.foo)
	callback = function()
		vim.bo.commentstring = "# %s" -- Example: Use `#` for comments (like Python)
		-- Alternatives:
		-- vim.bo.commentstring = "// %s"  (C-style)
		-- vim.bo.commentstring = "<!-- %s -->"  (HTML)
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.peggy", -- Replace with your file extension (e.g., *.foo)
	callback = function()
		vim.bo.commentstring = "// %s" -- Example: Use `#` for comments (like Python)
		-- Alternatives:
		-- vim.bo.commentstring = "// %s"  (C-style)
		-- vim.bo.commentstring = "<!-- %s -->"  (HTML)
	end,
})
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.mc", -- Replace with your file extension (e.g., *.foo)
	callback = function()
		vim.bo.commentstring = "// %s" -- Example: Use `#` for comments (like Python)
		-- Alternatives:
		-- vim.bo.commentstring = "// %s"  (C-style)
		-- vim.bo.commentstring = "<!-- %s -->"  (HTML)
	end,
})

-- defin the correspond highlightt group
vim.api.nvim_set_hl(0, "MyFoldColumn", { fg = "#85EEA7" })
-- Define signs for open and closed folds
vim.fn.sign_define("FoldClosed", { text = "▼", texthl = "MyFoldColumn" })

function UpdateFoldSigns()
	local bufnr = vim.api.nvim_get_current_buf()
	-- Clear previous fold signs
	vim.fn.sign_unplace("FoldSigns", { buffer = bufnr })
	-- Iterate through all lines and place fold signs only for closed folds
	for lnum = 1, vim.api.nvim_buf_line_count(bufnr) do
		if vim.fn.foldclosed(lnum) ~= -1 then -- Only place if fold is closed
			vim.fn.sign_place(0, "FoldSigns", "FoldClosed", bufnr, { lnum = lnum, priority = 10 })
		end
	end
end

-- refresh folder symbol in gutter everytime enter a buffer
vim.api.nvim_create_autocmd("BufEnter", {
	callback = UpdateFoldSigns,
})

if OSName == "Linux" then
	-- transfer dos to unix
	vim.api.nvim_create_user_command("Dos2Unix", function()
		-- Execute the commands in sequence
		vim.cmd("e ++ff=dos")
		vim.cmd("set fileformat=unix")
		vim.cmd("update")
	end, {})
elseif OSName == "Windows_NT" then
	-- auto generate png file
	vim.api.nvim_create_autocmd("BufWritePost", {
		pattern = "*.typ",
		callback = function()
			vim.cmd("silent !tinymist compile -f png " .. vim.fn.expand("<afile>"))
		end,
		group = vim.api.nvim_create_augroup("TypstCompile", { clear = true }),
	})
end
