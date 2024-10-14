require("core.options")
require("plugins.plugins-setup")
require("core.keymaps")

vim.cmd([[
  set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  autocmd VimLeave * set guicursor=a:ver25
]])

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
