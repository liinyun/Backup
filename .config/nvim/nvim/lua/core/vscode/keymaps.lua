local keymap = vim.keymap





-- visual mode --
-- -- 向下移动多行
-- vim.keymap.set('v', 'J', "<cmd>lua require('vscode').action('editor.action.moveLinesDownAction')<CR>")
-- -- 向上移动多行
-- vim.keymap.set('v', 'shift+j', "<cmd>lua require('vscode').action('editor.action.moveLinesUpAction')<CR>")
--

------- normal mode -------
-- windows
-- 我原来是用这个快捷键的，感觉可能会比较直观，发现没必要，手还多出了位移
-- 直接用默认的 C-w + s  和  C-w + v 其实也没问题
-- keymap.set("n", "<leader>|", "<C-w>v") -- 水平新增窗口
-- keymap.set("n", "<leader>-", "<C-w>s") -- 垂直新增窗口

-- 使用 Ctrl+方向键在窗口间切换
-- 说实话，我感觉先使用ctrl+w 后再切换窗口还是比较快和直观的
-- 所有与窗口有关的快捷键都是 ctrl+w 开头的，这样会方便很多
-- vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
-- vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
-- vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
-- vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
-- 为什么这里这么设计，就是因为这些操作都是不那么常用的操作，所以我们愿意让这些操作复杂一点
-- 最好这些操作不要和我们vsc和idea中的快捷键相挂
-- keymap.set("n", "<leader>sj", "<C-w>-")  -- make split window height shorter
-- keymap.set("n", "<leader>sk", "<C-w>+")  -- make split windows height taller
-- keymap.set("n", "<leader>sl", "<C-w>>5") -- make split windows width bigger
-- keymap.set("n", "<leader>sh", "<C-w><5") -- make split windows width smaller



-- 取消高亮
-- 个人感觉其实这个快捷键不是很有必要，就没弄了
-- keymap.set("n", "<leader>nh", ":nohl<CR>")

-- 这个是撤回的快捷键
-- 将 'U' 映射为 :redo 命令，执行撤销撤销操作
vim.api.nvim_set_keymap('n', 'U', '<C-r>', { noremap = true })

-- -- 将 Alt+j 映射为正常模式下的 '*'，即查找当前光标下的单词
-- vim.api.nvim_set_keymap('n', '<M-j>', '*', { noremap = true, silent = true })
-- -- Alt+k 映射为向上查找当前单词 (#)
-- vim.api.nvim_set_keymap('n', '<M-k>', '#', { noremap = true, silent = true })
-- -- 这里是取消normal 模式下 J 的快捷键，这个快捷键的作用是合并下一行，完全是没有意义徒增记忆量的蛋疼快捷键
-- vim.api.nvim_set_keymap('n', 'J', '<nop>', { noremap = true, silent = true })
--

------------------ vscode shortcuts ------------------
vim.keymap.set("n", "<leader>ee",
  "<cmd>lua require('vscode').action('workbench.action.toggleSidebarVisibility')<CR>")


-- this is the key to enable block move in vscode, without these code, it will take place error
vim.keymap.set("v", "J", ":m .+1<CR>==", { noremap = true, silent = true })
vim.keymap.set("v", "K", ":m .-2<CR>==", { noremap = true, silent = true })
-- it is essential, without this could cause bugs
vim.keymap.set("x", "J", ":move '>+1<CR>gv-gv", { noremap = true, silent = true })
vim.keymap.set("x", "K", ":move '<-2<CR>gv-gv", { noremap = true, silent = true })


-- Comment mappings
-- vim.keymap.set('x', 'gc', '<Plug>VSCodeCommentary', { silent = true })
-- vim.keymap.set('n', 'gc', '<Plug>VSCodeCommentary', { silent = true })
-- vim.keymap.set('o', 'gc', '<Plug>VSCodeCommentary', { silent = true })
-- vim.keymap.set('n', 'gcc', '<Plug>VSCodeCommentaryLine', { silent = true })


-- For Windows/Linux (Control key)
-- vim.keymap.set('n', '<C-/>', 'gcc', { silent = true, remap = true })
-- vim.keymap.set('x', '<C-/>', 'gc', { silent = true, remap = true })
--
--
--
-- vim.keymap.set('x', 'gc', '<Plug>VSCodeCommentary', {})
-- vim.keymap.set('n', 'gc', '<Plug>VSCodeCommentary', {})
-- vim.keymap.set('o', 'gc', '<Plug>VSCodeCommentary', {})
-- vim.keymap.set('n', 'gcc', '<Plug>VSCodeCommentaryLine', {})
--
-- -- If you want the selection to stay after commenting in visual mode
-- vim.keymap.set('x', '<C-/>', '<Plug>VSCodeCommentarygv', {})
-- vim.keymap.set('n', '<C-/>', '<Plug>VSCodeCommentaryLine', {})
