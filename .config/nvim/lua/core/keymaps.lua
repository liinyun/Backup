local keymap = vim.keymap

-- insert mode --

-- visual mode --
-- 向下移动多行
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
-- 向上移动多行
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

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
-- keymap.set("n", "<leader>sj", "<C-w>-") -- make split window height shorter
-- keymap.set("n", "<leader>sk", "<C-w>+") -- make split windows height taller
-- keymap.set("n", "<leader>sl", "<C-w>>5") -- make split windows width bigger
-- keymap.set("n", "<leader>sh", "<C-w><5") -- make split windows width smaller

-- 取消高亮
-- 个人感觉其实这个快捷键不是很有必要，就没弄了
-- keymap.set("n", "<leader>nh", ":nohl<CR>")

-- 这个是撤回的快捷键
-- 将 'U' 映射为 :redo 命令，执行撤销撤销操作
vim.api.nvim_set_keymap("n", "U", "<C-r>", { noremap = true })

-- 将 Alt+j 映射为正常模式下的 '*'，即查找当前光标下的单词
vim.api.nvim_set_keymap("n", "<M-j>", "*", { noremap = true, silent = true })
-- Alt+k 映射为向上查找当前单词 (#)
vim.api.nvim_set_keymap("n", "<M-k>", "#", { noremap = true, silent = true })
-- 这里是取消normal 模式下 J 的快捷键，这个快捷键的作用是合并下一行，完全是没有意义徒增记忆量的蛋疼快捷键
vim.api.nvim_set_keymap("n", "J", "<nop>", { noremap = true, silent = true })

-- plugins --
-- nvim-tree
-- keymap.set("n", "<leader>ee", ":NvimTreeToggle<CR>") -- toggle file explorer
-- keymap.set("n", "<leader>er", ":NvimTreeFocus<CR>")    -- toggle focus to file explorer
-- keymap.set("n", "<leader>ef", ":NvimTreeFindFile<CR>") -- find file in file explorer

-- neo-tree

-- oil --
-- keymap.set("n", "<leader>ee", ":Oil --float .<CR>") -- open Oil

-- lsp
-- 这个是查看函数的定义
-- 这些配置是 nvim 的lsp内置的接口提供的，但是如果要能实现，就需要安装lsp 插件了
keymap.set("n", "<leader>gg", "<cmd>lua vim.lsp.buf.hover()<CR>")
keymap.set("n", "<leader>gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
-- -- 这个是查看源码的快捷键
keymap.set("n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>")

keymap.set("n", "<leader>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
keymap.set("n", "<leader>gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
keymap.set("n", "<leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>")
keymap.set("n", "<leader>gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
keymap.set("n", "<leader>gp", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
keymap.set("n", "<leader>gn", "<cmd>lua vim.diagnostic.goto_next()<CR>")
keymap.set("n", "<leader>tr", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
keymap.set("n", "<M-CR>", "<cmd>lua vim.lsp.buf.code_action()<CR>")
keymap.set("n", "<M-\\>", "<cmd>lua vim.diagnostic.open_float()<CR>", { noremap = true, silent = true })

-- 这个是 telescope 的快捷键，是telescope 默认的快捷键
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fs", require("telescope.builtin").current_buffer_fuzzy_find, {})
-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- This shortcut is for Floaterm
-- vim.keymap.set('n', '<leader>r', ':FloatermNew<CR>', { noremap = true, silent = true })

-- 在终端模式中绑定快捷键进行窗口切换
-- 这个是我在使用 floaterm 的时候遇到的问题，但是，这个配置不是插件的配置，而是nvim 的配置，修改的是nvim 终端模式下的快捷键
-- vim.api.nvim_set_keymap('t', '<C-w>w', [[<C-\><C-n><C-w>w]], { noremap = true, silent = true })
-- 这个是将终端中进入普通模式改了一下快捷键
-- 这个快捷键还真不能该，冲突的地方太多了
-- vim.api.nvim_set_keymap('t', 'jj', [[<C-\><C-n>]], { noremap = true, silent = true })

-- persistence
-- 我不是很确定要不要绑快捷键，所以就先没有绑定了

------- command mode --------
-- 这个是 候选的时候 ctrl+n 选择下一个，这个快捷键我修改成 ctrl+j 了，下面同理
vim.keymap.set("c", "<C-j>", "<C-n>", { noremap = true, silent = true })
vim.keymap.set("c", "<C-k>", "<C-p>", { noremap = true, silent = true })
