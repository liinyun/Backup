-- 行号
vim.opt.relativenumber = true
vim.opt.number = true

-- 缩进
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true

-- 防止包裹
vim.opt.wrap = false

-- 光标行高亮
vim.opt.cursorline = true

-- 启用鼠标
vim.o.mouse = "a"
-- 这里使用 
-- vim.opt.mouse:append("a") 也是可以的

-- 系统剪切板 
vim.opt.clipboard = "unnamedplus"

-- 默认新窗口右和下
vim.opt.splitright = true
vim.opt.splitbelow = true

-- 搜索
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- 外观
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"






