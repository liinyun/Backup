require("core.lazy")
-- These modules are not loaded by lazy
require("core.options")
require("core.keymaps")

vim.o.autoread = true
-- 这个是让nvim 退出的时候将光标弄回竖线
vim.cmd([[
  set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  autocmd VimLeave * set guicursor=a:ver25
]])
-- 这里是添加切换到normal 的时候自动使用英文输入法
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  callback = function()
    os.execute("fcitx5-remote -c") -- 切换到英文输入法
  end
})


-- 自动关闭 nvim-tree 缓冲区
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("NvimTreeClose", { clear = true }),
  pattern = "NvimTree_*",
  callback = function()
    local layout = vim.api.nvim_call_function("winlayout", {})
    ---@diagnostic disable-next-line
    if layout[1] == "leaf" and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree" and layout[3] == nil then
      -- 这一条是设置 退出的时候修改光标的，如果退出的时候，nvim-tree 还在的话，光标是不会还原成竖线的
      vim.cmd("set guicursor=a:ver25")
      -- 这里是设置退出nvim-tree 的
      vim.cmd("quit")
    end
  end
})


--  在init.vim中
