-- if vim.g.vscode then
--   -- VSCode extension
-- else
--   -- ordinary Neovim
--
-- This has to be set before initializing lazy
vim.g.mapleader = " "
-- enable 24-bit RGB support in the terminal
vim.opt.termguicolors = true
require("core.lazy")

-- These modules are not loaded by lazy
require("core.options")
require("core.keymaps")
-- require("core.keymaps-bak")
require("core.scripts.scripts")

vim.o.autoread = true
-- 这个是支持ssh 的时候将 nvim 复制的东西传到本地的剪切板
-- 这里
vim.g.clipboard = {
	name = "OSC 52",
	copy = {
		["+"] = require("vim.ui.clipboard.osc52").copy("+"),
		["*"] = require("vim.ui.clipboard.osc52").copy("*"),
	},
	paste = {
		["+"] = require("vim.ui.clipboard.osc52").paste("+"),
		["*"] = require("vim.ui.clipboard.osc52").paste("*"),
	},
}

-- Clipboard
-- 这里是选择使用系统寄存器，就可以实现跨应用复制和粘贴了
vim.opt.clipboard:append("unnamedplus")

--  在init.vim中
-- 默认使用 zathura 打开pdf
vim.api.nvim_create_autocmd("BufReadPost", {
	group = vim.api.nvim_create_augroup("OpenPDFWithZathura", { clear = true }),
	pattern = "*.pdf",
	callback = function()
		vim.fn.system("zathura " .. vim.fn.expand("%") .. " &")
	end,
})

-- 先判断是不是在 ssh 中，如果不在 ssh 中，就启用这个 命令，否则就不启用
if vim.fn.getenv("SSH_TTY") == vim.NIL then
	vim.api.nvim_create_autocmd("InsertLeave", {
		pattern = "*",
		callback = function()
			os.execute("fcitx5-remote -c") -- 切换到英文输入法
		end,
	})
end

vim.cmd.colorscheme("catppuccin")
vim.api.nvim_set_hl(0, "NotifyBackground", { bg = "#2E2E2E", fg = "#FFFFFF" })

vim.filetype.add({
	filename = {
		["pages.json"] = "jsonc",
		["manifest.json"] = "jsonc",
	},
})
