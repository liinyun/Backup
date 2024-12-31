-- scripts or some commands I write myself
-- if I write all my selfconfig functions in init.lua it will be difficult to read and maintain

-- define my own highlight group
vim.api.nvim_set_hl(0, "MySlimeHighlight", {
	fg = "#9399b2", -- Your chosen foreground color
	-- fg = "#9370DB",
	-- bg = "#9399b2",
	underline = true, -- Add underline style
	bold = true,
})

vim.api.nvim_create_namespace("SlimeSign")

vim.fn.sign_define("SlimeCell", {
	text = "▶", -- The symbol to show
	texthl = "MySlimeHighlight", -- Highlight group for the sign
	linehl = "MySlimeHighlight", -- Optional: highlight for the whole line
	-- numhl = "", -- Optional: highlight for the line number
})

function HighlightWord(word)

	-- vim.fn.matchadd("MySlimeHighlight", "vim")
end

vim.api.nvim_create_user_command("TestHigh", HighlightWord, { nargs = "*" })

-- sign_on_cell_boundaries = function()
-- 	local filepath = vim.fn.expand("%:p")
-- 	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
-- 	-- if filepath == "" then
-- 	--      return
-- 	-- end
-- 	local cell_delimiter = "function"
-- 	for idx, line in ipairs(lines) do
-- 		if string.match(line, cell_delimiter) then
-- 			-- vim.api.nvim_buf_set_extmark(0, vim.api.nvim_create_namespace("SlimeSign"), idx, 0, {
-- 			-- 	end_row = idx,
-- 			-- 	-- end_col = 1,
-- 			-- 	line_hl_group = "MySlimeHighlight",
-- 			-- })
-- 			-- bufname("%")
-- 			vim.fn.sign_place(0, "", "SlimeCell", vim.api.nvim_get_current_buf(), {
-- 				lnum = idx,
-- 			})
-- 		end
-- 	end
-- end
--
-- vim.api.nvim_create_user_command("AddHigh", sign_on_cell_boundaries, {})

-- 运行脚本并捕获输出
-- 这是为了 可以使用nvim的
-- 这个脚本 的命令传递形式是直接在后面跟需要跑的命令，比较推荐直接将命令写入一个 sh 文件或者 py 文件之类的直接执行
-- 因为我创建这个命令的初衷一个是 可以快速 跳转，一个就是希望可以不用每次在命令行输入很多文件
-- 这个函数的使用方式是这样的：
-- RunScript "! bash run.sh"   或者  RunScript "! python run.py"
-- 如果看了下面的源码就知道 这个命令是直接放到 cmd 中执行的
vim.api.nvim_create_user_command("RunScript", function(opts)
	-- Split the command arguments into an array
	-- for vim.system demand cmd a table
	-- local cmd = vim.split(opts.args, " ", { trimempty = true })
	-- Insert 'run.sh' at the end of our command array
	local result = vim.system(opts.fargs, { text = true }):wait()
	local items = {}

	if result.stdout then
		for line in result.stdout:gmatch("[^\r\n]+") do
			table.insert(items, { text = line })
		end
	end

	vim.fn.setqflist(items)
	vim.cmd("copen")
end, { nargs = "*" }) -- Allow any number of arguments

-- transfer dos to unix
vim.api.nvim_create_user_command("Dos2Unix", function()
	-- Execute the commands in sequence
	vim.cmd("e ++ff=dos")
	vim.cmd("set fileformat=unix")
	vim.cmd("update")
end, {})

-- Auto-save when leaving Insert mode (entering Normal mode)
function SaveFileEnteringNormalMode()
	vim.cmd("silent! update")
end

vim.api.nvim_create_autocmd("ModeChanged", {
	callback = SaveFileEnteringNormalMode,
})

-- don't use such method to open a folder with nvim, just enter folder and operate nvim
-- nvim folder to open a folder
-- -- this function is very essential, with this I don't need to modify .bashrc file
-- function ChangeDirToFileOrParent()
--   -- this command is to get the input parameter's path
--   -- don't use vim.uv.cmd()  it gets the current directory path, not the input parameter's path
--   local path = vim.fn.expand('%:p')
--   -- if input parameter is a directory then ,jump into it
--   if vim.fn.isdirectory(path) == 1 then
--     vim.cmd('cd' .. path)
--   else
--     -- it gets the parent directory
--     -- local parent_dir = vim.fn.fnamemodify(path, ':h')
--     -- if vim.fn.isdirectory(parent_dir) == 1 then
--     --   -- it jump to parent directory
--     --   vim.cmd('cd' .. parent_dir)
--     -- end
--   end
-- end
--
-- vim.api.nvim_create_autocmd('VimEnter', {
--   pattern = '*',
--   callback = ChangeDirToFileOrParent
-- })

function RefreshTmuxClipboard()
	vim.fn.system("tmux refresh-client -l")
end

if os.getenv("TMUX") ~= nil then
	vim.api.nvim_set_keymap("n", "p", [[:lua RefreshTmuxClipboard()<CR>p]], { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "P", [[:lua RefreshTmuxClipboard<CR>P]], { noremap = true, silent = true })
end

-- why the below command is no use because I always enter TMUX first then open nvim
-- every time I launch nvim, it's Term will never be changed
-- function RefreshTmuxClipboardAutoCmd()
--   if os.getenv("TMUX") ~= nil then
--     vim.api.nvim_set_keymap('n', 'p', [[:lua RefreshTmuxClipboard()<CR>p]],
--       { noremap = true, silent = true })
--     vim.api.nvim_set_keymap('n', 'P', [[:lua RefreshTmuxClipboard<CR>P]],
--       { noremap = true, silent = true })
--   end
-- end
--
-- vim.api.nvim_create_autocmd('TermEnter',{
--   callback = RefreshTmuxClipboardAutoCmd
-- })
