-- add this to your lua/plugins.lua, lua/plugins/init.lua,  or the file you keep your other plugins:
-- 说一下为什么使用 comment.nvim 而不使用 vim-commentary 。因为我希望可以对空行进行注释，而vim-commentary 无法实现
return {
  'numToStr/Comment.nvim',
  opts = {
    -- add any options here
  }
}
