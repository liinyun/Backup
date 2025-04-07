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


-- my test function to test highlight
function HighlightWord(word)
  -- vim.fn.matchadd("MySlimeHighlight", "vim")
end

vim.api.nvim_create_user_command("TestHigh", HighlightWord, { nargs = "*" })


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
local function SaveFileEnteringNormalMode()
  vim.cmd("silent! update")
  local filetype = vim.bo.filetype
  if filetype == "rust" then
    -- this function could get an error. If I change mode before rust lsp is fully loaded, it may rings error, but it's ok, it's just because the lsp is not fully loaded
    vim.cmd("RustLsp flyCheck")
    vim.lsp.codelens.refresh()
  end
end

vim.api.nvim_create_autocmd("ModeChanged", {
  -- nested = true,
  callback = SaveFileEnteringNormalMode,
})


-- set self defined comment pattern
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.dae",              -- Replace with your file extension (e.g., *.foo)
  callback = function()
    vim.bo.commentstring = "# %s" -- Example: Use `#` for comments (like Python)
    -- Alternatives:
    -- vim.bo.commentstring = "// %s"  (C-style)
    -- vim.bo.commentstring = "<!-- %s -->"  (HTML)
  end,
})

-- don't use any method to open a folder with nvim, just enter folder and operate nvim


function RefreshTmuxClipboard()
  vim.fn.system("tmux refresh-client -l")
end

if os.getenv("TMUX") ~= nil then
  vim.api.nvim_set_keymap("n", "p", [[:lua RefreshTmuxClipboard()<CR>p]], { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "P", [[:lua RefreshTmuxClipboard<CR>P]], { noremap = true, silent = true })
end




-- defin the correspond highlightt group
vim.api.nvim_set_hl(0, "MyFoldColumn", { fg = "#85EEA7" })
-- Define signs for open and closed folds
vim.fn.sign_define("FoldClosed", { text = "▼", texthl = "MyFoldColumn" })

function UpdateFoldSigns()
  local bufnr = vim.api.nvim_get_current_buf()
  -- Clear previous fold signs
  vim.fn.sign_unplace("FoldSigns", { buffer = bufnr })
  -- Iterate through all lines and place fold signs only for closed folds
  for lnum = 1, vim.api.nvim_buf_line_count(bufnr) do
    if vim.fn.foldclosed(lnum) ~= -1 then -- Only place if fold is closed
      vim.fn.sign_place(0, "FoldSigns", "FoldClosed", bufnr, { lnum = lnum, priority = 10 })
    end
  end
end

-- refresh folder symbol in gutter everytime enter a buffer
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    UpdateFoldSigns()
  end,
})



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
