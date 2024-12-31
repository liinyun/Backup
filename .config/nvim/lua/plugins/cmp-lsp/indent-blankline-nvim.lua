-- Indentation guides
local M = {}
M = {
  -- https://github.com/lukas-reineke/indent-blankline.nvim
  "lukas-reineke/indent-blankline.nvim",
  event = 'VeryLazy',
  -- 这个 ibl 是indent-blankline 文件夹中的一个module,这里指定ibl 是因为这个文件夹下面没有init
  -- lua 默认使用init 作为 module 的入口，如果没有init 这个文件夹，就需要手动指定入口文件夹
  config = function ()
    local highlight = {
        "CursorColumn",
        "Whitespace",
    }
    require("ibl").setup {
        indent = { highlight = highlight, char = "" },
        whitespace = {
            highlight = highlight,
            remove_blankline_trail = false,
        },
        scope = { enabled = false },
    }
  end
  -- main = "ibl",
  -- opts = {
  --   enabled = true,
  --   -- 这里说的是用什么方式来显示
  --   indent = {
      -- char = '|',
    -- },
  -- },
}

return M
