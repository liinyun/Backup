-- File Explorer / Tree
-- 我把M 在开头赋值，是为了防止后面赋值的时候将前面的函数给直接弄没了
local M = {
  -- 插件，可以直接写，可以写成 name = 'nvim-tree/nvim-tree.lua'
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    -- https://github.com/nvim-tree/nvim-web-devicons
    'nvim-tree/nvim-web-devicons', -- Fancy icon support
  },
}

M.open_win_config = function()
  local columns = vim.opt.columns:get()
  local lines = vim.opt.lines:get()

  -- local width = math.floor(columns * 0.3) -- 悬浮窗口宽度为编辑器宽度的 30%
  -- local height = math.floor(lines * 0.4)  -- 悬浮窗口高度为编辑器高度的 40%

  local width = math.max(math.floor(columns * 0.5), 40)
  local height = math.max(math.floor(lines * 0.5), 20)

  return {
    relative = "editor",
    border = "rounded",
    width = width,
    height = height,
    -- row = row,
    -- col = col
    -- 这个点是用来确定左上角的
    row = math.floor((lines - height) / 2),  -- 居中
    col = math.floor((columns - width) / 2), -- 居中
  }
end


-- C 佬的太复杂了，我直接修改还不会那么绕
M.magicCd = function()
  ---@module "nvim-tree.api"
  local api = require("nvim-tree.api")
  -- 光标所在文件的路径
  -- 如果是文件的话，好像就不会生效，但是文件夹的话，就可以
  local node = api.tree.get_node_under_cursor()
  -- print(node.absolute_path)
  -- print(node.type)
  if node.type == "directory" then
    print("ok")
    return api.tree.change_root(node.absolute_path)
  end
end



-- lazy.vim 中 配置函数的入口是 config

M.config = function()
  vim.cmd("au FileType NvimTree nnoremap <buffer> <silent> go :lua require('plugins.common.nvim-tree').magicCd()<cr>")
  local nvim_tree = require("nvim-tree")
  nvim_tree.setup({
    -- 我这个设置的意思就是打开一个文件的时候不会自动打开 netrw
    hijack_netrw = false, -- 可以保留，接管 netrw
    filters = {
      -- 显示隐藏文件
      dotfiles = false,
    },
    sort_by = "case_sensitive",
    actions = {
      open_file = {
        window_picker = { enable = false }
      }
    },
    view = {
      float = {
        enable = true,
        -- 传递的是整个函数，不能是函数的返回值
        open_win_config = M.open_win_config
      }
    },
    update_focused_file = {
      enable = true,
      update_root = false,
      ignore_list = {},
    },
    renderer = {
      group_empty = true,
      indent_markers = { enable = true },
      icons = {
        git_placement = "after",
        webdev_colors = true,
        glyphs = {
          git = { unstaged = "~", staged = "✓", unmerged = "", renamed = "+", untracked = "?", deleted = "", ignored = " " },
          folder = { empty = "", empty_open = "" }
        }
      }
    },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
      debounce_delay = 50,
      icons = { hint = "", info = "", warning = "", error = "" }
    },
  })
end

return M
