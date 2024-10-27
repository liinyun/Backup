local keymap = vim.keymap

-- insert mode --






-- visual mode --
-- 向下移动多行
keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
-- 向上移动多行
keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })





------- normal mode -------
-- windows
keymap.set("n", "<leader>|", "<C-w>v") -- 水平新增窗口
keymap.set("n", "<leader>-", "<C-w>s") -- 垂直新增窗口

-- 使用 Ctrl+方向键在窗口间切换
-- 说实话，我感觉先使用ctrl+w 后再切换窗口还是比较快和直观的
-- 所有与窗口有关的快捷键都是 ctrl+w 开头的，这样会方便很多
-- vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
-- vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
-- vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
-- vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
-- 为什么这里这么设计，就是因为这些操作都是不那么常用的操作，所以我们愿意让这些操作复杂一点
-- 最好这些操作不要和我们vsc和idea中的快捷键相挂
keymap.set("n", "<leader>sj", "<C-w>-")  -- make split window height shorter
keymap.set("n", "<leader>sk", "<C-w>+")  -- make split windows height taller
keymap.set("n", "<leader>sl", "<C-w>>5") -- make split windows width bigger
keymap.set("n", "<leader>sh", "<C-w><5") -- make split windows width smaller


-- 取消高亮
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- 这个是撤回的快捷键
-- 将 'U' 映射为 :redo 命令，执行撤销撤销操作
vim.api.nvim_set_keymap('n', 'U', '<C-r>', { noremap = true })

-- 将 Alt+j 映射为正常模式下的 '*'，即查找当前光标下的单词
vim.api.nvim_set_keymap('n', '<M-j>', '*', { noremap = true, silent = true })
-- Alt+k 映射为向上查找当前单词 (#)
vim.api.nvim_set_keymap('n', '<M-k>', '#', { noremap = true, silent = true })
-- 这里是取消normal 模式下 J 的快捷键，这个快捷键的作用是合并下一行，完全是没有意义徒增记忆量的蛋疼快捷键
vim.api.nvim_set_keymap('n', 'J', '<nop>', { noremap = true, silent = true })

-- plugins --
-- nvim-tree
keymap.set("n", "<leader>ee", ":NvimTreeToggle<CR>") -- toggle file explorer
-- keymap.set("n", "<leader>er", ":NvimTreeFocus<CR>")    -- toggle focus to file explorer
-- keymap.set("n", "<leader>ef", ":NvimTreeFindFile<CR>") -- find file in file explorer




local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })


-- persistence
-- 我不是很确定要不要绑快捷键，所以就先没有绑定了
