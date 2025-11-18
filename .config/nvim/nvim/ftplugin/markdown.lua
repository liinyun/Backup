-- Markdown specific settings
vim.opt.wrap = true        -- Wrap text
vim.opt.breakindent = true -- Match indent on line break
vim.opt.linebreak = true   -- Line break on whole words

-- Allow j/k when navigating wrapped lines
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- Spell check
-- 这个拼写检查有时候还比较脑瘫,会直接将注释中的中文添加下划线，贼丑
-- 这个设置是真nm 抽象，是指，如果打开了md文件，那么全局的语法检查就都会打开
-- vim.opt.spell = true
-- vim.opt.spelllang = {'en','cjk'}
