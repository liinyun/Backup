return {
  'folke/todo-comments.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = { 'nvim-lua/plenary.nvim' },
  -- 后面是一些快捷键的设置，我以后有需要再添加吧
  -- config = function ()
  --   local todo_comments = require)("todo-comments")

  -- end
}
