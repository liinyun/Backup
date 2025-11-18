-- 这个配置太零散了，以后要找机会将这个配置整理一下

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
--

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
