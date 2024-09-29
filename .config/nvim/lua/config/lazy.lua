-- stdpath("data") 是指系统中一般用来存放数据的文件夹，在fedora 中是 .local/nvim
-- 这里的意思就是，完整路径为 .local/nvim/lazy/lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- fs_stat 检查指定路径是否存在，如果路径不存在，就执行下面的代码块了
-- vim.uv 和 vim.loop 是neovim 提供的接口，用于访问底层的异步事件循环和文件系统功能
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  -- 在系统中执行命令，这里执行了一个 git clone 命令，将lazy.nvim 从 github 克隆到了本地
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
-- 将lazy.vim 的路径添加到neovim 的运行时路径(rtp runtime pah)中，确保neovim 可以找到并加载该插件
vim.opt.rtp:prepend(lazypath)

-- 加载并初始化 lazy.nvim 插件，并且传递一个 table(表)来配置插件设置
require("lazy").setup({
  -- 这里是要加载的插件和他们的配置
  spec = {
    -- { "LazyVim/LazyVim", import = "lazyvim.plugins" }：加载 LazyVim 插件，并从 lazyvim.plugins 中导入其配置。
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import/override with your plugins
    --导入您自定义的插件配置，假设您在 ~/.config/nvim/lua/plugins.lua 中定义了插件。
    { import = "plugins" },
  },
  -- 设置默认配置
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    -- 默认情况下只有 lazyVim 拆建会延迟加载
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  -- 设置安装时的默认颜色主题
  install = { colorscheme = { "tokyonight", "habamax" } },
  -- 设置插件更新检查
  checker = { enabled = true }, -- automatically check for plugin updates
  -- 设置性能相关的选项
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        -- 禁用 gzip 支持
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
