-- Bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
-- 这里是在设置 runtimepath 了，这里直接使用 lazypath 既lazy.nvim 的路径作为runtimepath
-- 并不是将.config/nvim 中的文件都加入 lazypath，前面的lazypath只有lazy.nvim 这一个module
-- 那么是怎么实现将其他的插件也加入 runtimepath 的呢？
vim.opt.rtp:prepend(lazypath)

-- Initialize lazy with dynamic loading of anything in the plugins directory
-- 就是这里，如果这个插件被 lazy.nvim 识别的话，这个插件就会被添加进入 runtimepath
require("lazy").setup({
  -- { import = "plugins" },    -- 这里注释是因为这个文件夹下面没有lua 文件了，会报错
  { import = "plugins.common" },
  { import = "plugins.ui" },
  -- { import = "plugins.coc" },
  { import = "plugins.cmp-lsp" },
  { import = "plugins.others" }
  -- { import = "plugins.lsp.lspconfig" },
  -- { import = "plugins.lsp.mason" }
}, {
  git = {
    url_format = "git@github.com:%s.git",
  },
  change_detection = {
    enabled = true, -- automatically check for config file changes and reload the ui
    notify = false, -- turn off notifications whenever plugin changes are made
  },
})

-- These modules are not loaded by lazy
require("core.options")
require("core.keymaps")
