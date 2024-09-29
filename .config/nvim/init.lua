-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- 其他配置选项

-- 这个是将剪切板和nvim 的复制操作打通
vim.o.clipboard = "unnamedplus"

-- 在 copy 后高亮
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  pattern = { "*" },
  callback = function()
    vim.highlight.on_yank({
      timeout = 300,
    })
  end,
})

-- 支持左右走到头后跨行
vim.opt.whichwrap:append("<,>,[,],h,l")
