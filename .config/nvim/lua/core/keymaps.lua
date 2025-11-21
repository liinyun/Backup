--  I have to explain the reason why I don't use the local keymap = vim.keymap
--  because all of my shortcut settings is done setp by setp, I am not add these at one time
--  so I don't have to worry about repeaatly entering a large number of the same characters

-- =====================================================================================
-- ================================== insert mode ======================================
-- =====================================================================================

-- =====================================================================================
-- ================================== visual mode ======================================
-- =====================================================================================

-- move multilines down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
-- move multilines up
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- =====================================================================================
-- ================================== normal mode ======================================
-- =====================================================================================
-- windows
-- I delete previous settings, the default shortcuts is explicit and simple enough

-- colse highlight
-- keymap.set("n", "<leader>nh", ":nohl<CR>")

-- shortcut for redo
-- cancel redo
vim.api.nvim_set_keymap("n", "U", "<C-r>", { noremap = true })

-- project "Alt+j" to '*' in normal mode, to find the next same word
vim.api.nvim_set_keymap("n", "<M-j>", "*", { noremap = true, silent = true })
-- project "Alt+k" to find the same word above (#)
vim.api.nvim_set_keymap("n", "<M-k>", "#", { noremap = true, silent = true })
-- it is a stupid shortcut totally waste of key. it works to merge the next line to the current line
-- I can't image which coding language would do this frequently
vim.api.nvim_set_keymap("n", "J", "<nop>", { noremap = true, silent = true })
-- well, this config may be good, but I don't appreciate this config. I think this two keys can do something more interesting
-- vim.api.nvim_set_keymap("n", "H", "0", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "L", "$", { noremap = true, silent = true })

-- this two keymaps append my function after the default zo and zc
vim.api.nvim_set_keymap("n", "zo", "zo:lua UpdateFoldSigns()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "zc", "zc:lua UpdateFoldSigns()<CR>", { noremap = true, silent = true })

-- ==================== plugins ==================== --
-- neo-tree

-- oil --
-- keymap.set("n", "<leader>ee", ":Oil --float .<CR>") -- open Oil

-- lsp
-- how the definition of the function
-- it will show the doc, but the content is provided by lsp
-- keymap.set("n", "<leader>gg", "<cmd>lua vim.lsp.buf.hover()<CR>")
vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")

local function quit_floating_win()
	local win_id = vim.api.nvim_get_current_win()
	local config = vim.api.nvim_win_get_config(win_id)
	local flag = config.relative ~= ""
	if flag then
		vim.api.nvim_win_close(win_id, true)
	end
end

vim.keymap.set("n", "<Esc>", quit_floating_win, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
-- shortcut to view the source code
-- vim.keymap.set("n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
-- vim.keymap.set("n", "<leader>gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
vim.keymap.set("n", "<leader>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
vim.keymap.set("n", "<leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>")
vim.keymap.set("n", "<leader>gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
vim.keymap.set("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>")
vim.keymap.set("n", "<M-\\>", "<cmd>lua vim.diagnostic.open_float()<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>")
vim.keymap.set("n", "<leader>tr", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
vim.keymap.set("n", "<M-CR>", "<cmd>lua vim.lsp.buf.code_action()<CR>")

vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>")
vim.keymap.set("n", "gp", "<cmd>Lspsaga goto_definition<CR>")
-- vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
-- vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>")
-- vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>")

-- quickfix

vim.keymap.set("n", "<leader>q", function()
	local is_open = vim.fn.getqflist({ winid = 0 }).winid ~= 0
	if is_open then
		vim.cmd("cclose")
	else
		vim.cmd("copen")
	end
end, {
	desc = "Toggle quickfix",
})

-- telescope
-- local builtin = require("telescope.builtin")
-- vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
-- vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
-- vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
-- vim.keymap.set("n", "<leader>fs", require("telescope.builtin").current_buffer_fuzzy_find, {})
-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- This shortcut is for Floaterm
-- vim.keymap.set('n', '<leader>r', ':FloatermNew<CR>', { noremap = true, silent = true })

-- =========================================================================
-- =========================== command mode ================================
-- =========================================================================
-- this is for auto completing in command line. I set the select next to ctrl+j and ctrl+k instead of ctrl+n or ctrl+print
vim.keymap.set("c", "<C-j>", "<C-n>", { noremap = true, silent = true })
vim.keymap.set("c", "<C-k>", "<C-p>", { noremap = true, silent = true })

-- =========================================================================
-- =========================== terminal mode ===============================
-- =========================================================================
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true })
