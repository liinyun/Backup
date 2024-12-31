-- ---@type LazyPluginSpec
return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  opts = function()
    -- 这里使用的是 插件的 module 不是nvim 的notify 的包
    -- local stages_util = require "notify.stages.util"
    -- 这个是插件给的 api 是可以进行选择的
    -- local direction = stages_util.DIRECTION.BOTTOM_UP

    return {
      background_colour = "NotifyBackground",
      render = "minimal",
      stages = "fade_in_slide_out",
      icons = {
        DEBUG = "",
        ERROR = "",
        INFO = "",
        TRACE = "✎",
        WARN = ""
      },
      level = 2,
      minimum_width = 50,

      -- Modified from "static"
      -- stages = {
      --   function(state)
      --     local next_height = state.message.height + 2
      --     local next_row = stages_util.available_slot(
      --       state.open_windows,
      --       next_height,
      --       direction
      --     )
      --     if not next_row then
      --       return nil
      --     end
      --
      --     -- Avoid overlapping with the statusline
      --     if vim.tbl_isempty(state.open_windows) then
      --       next_row = next_row - 1
      --     end
      --     -- 这里是通知位置的定位
      --     return {
      --       -- 相对于整个编辑器而不是buffer
      --       relative = "editor",
      --       -- 定位在右上角
      --       anchor = "NE",
      --       width = state.message.width,
      --       height = state.message.height,
      --       -- 得到列数
      --       col = vim.opt.columns:get(),
      --       row = next_row,
      --       border = "rounded",
      --       style = "minimal",
      --     }
      --   end,
      --   function()
      --     return {
      --       col = vim.opt.columns:get(),
      --       time = true,
      --     }
      --   end,
      -- },
    }
  end,
}
