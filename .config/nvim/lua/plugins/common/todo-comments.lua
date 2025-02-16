-- the most important functionality of this plugin is to add comment in blink line
return {
  'folke/todo-comments.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    sign = true,    -- show icons in the signs column    
    -- 这个是用来控制 符号的优先级的，防止和其他插件的符号冲突
    -- 如果别的插件想要使用符号栏，那么可能会与 todo-comments 的符号冲突，那么nvim 会选择显示哪个符号看的就是这个符号的优先级
    -- 所以有些插件就会使用 virtual text 来避免冲突，比如 lsp 。事实上，我个人感觉 lsp 其实对于符号的占用还是比较有限的，lsp 很多时候都是 virtual texg 在起作用
    -- 而且，我一般也不会看lsp 的 icons 而是选择使用 Trouble 之类的插件直接进行跳转才是更加合适的方案
    sign_priority = 8, -- sign priority
    keywords = {
      FIX = {
        icon = " ", -- icon used for the sign, and in search results
        color = "error", -- can be a hex color, or a named color (see below)
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
        -- signs = false, -- configure signs for some keywords individually
      },
      TODO = { icon = " ", color = "info" },
      HACK = { icon = " ", color = "warning" },
      WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
      PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
      TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
    },
    gui_style = {
      fg = "NONE", -- The gui style to use for the fg highlight group.
      bg = "BOLD", -- The gui style to use for the bg highlight group.
    },

  }
}
