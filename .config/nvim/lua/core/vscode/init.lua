vim.g.mapleader = " "

require("core.vscode.keymaps")
require("core.vscode.lazy")

-- This has to be set before initializing lazy


vim.opt.clipboard:append("unnamedplus")

if vim.fn.getenv("SSH_TTY") == vim.NIL then
  vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = "*",
    callback = function()
      os.execute("fcitx5-remote -c") -- 切换到英文输入法
    end
  })
end



local undodir = vim.fn.stdpath("data") .. "/undodir"
if vim.fn.isdirectory(undodir) == 0 then
  -- 如果不存在就创建这个文件夹
  vim.fn.mkdir(undodir, "p")
end
vim.opt.undodir = undodir
-- 启用持久化撤销
vim.opt.undofile = true
