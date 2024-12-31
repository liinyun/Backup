-- Lua
-- 我得说一下，自己为什么选择这个插件了，因为 folk 写的 persistence 其实功能是比较欠缺的，这个插件是 fork 了 persistence 的，填补了一些新的功能
local M = {}
M = {
  "olimorris/persisted.nvim",
  lazy = false, -- make sure the plugin is always loaded at startup
  config = function()
    local home_dir = vim.uv.os_homedir()
    require("persisted").setup({
      autostart = true, -- automatically start the plugin on load
      autoload = true,  -- automatically load the session for he cwd on neovim startup
      -- Function to run when `autoload = true` but there is no session to load
      ---@type fun(): any
      on_autoload_no_session = function() end,

      config = true,
      save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"),
      -- Set `lazy = false` in `plugins/editor.lua` to enable this
      follow_cwd = true,
      use_git_branch = true,
      should_save = function()
        return vim.bo.filetype == "alpha" and false or true
      end,
      -- 这个不是官方写法，感觉有点脑残了，不过也能用，不管了
      allowed_dirs = { "~" }, -- Table of dirs that the plugin will start and autoload from

    })
  end

}

return M
