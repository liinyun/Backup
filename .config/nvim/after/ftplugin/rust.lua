local bufnr = vim.api.nvim_get_current_buf()

-- local function checkdiagnostic()
--   -- check if any diagnostic window open
--   for _, win in ipairs(vim.api.nvim_list_wins()) do
--     if vim.api.nvim_win_get_config(win).relative ~= "" then
--       vim.api.nvim_set_current_win(win)
--       -- return
--     else
--       vim.cmd.RustLsp({ "renderDiagnostic", "cycle" })
--     end
--   end
-- end

vim.keymap.set("n", "<M-CR>", function()
  vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
  -- or vim.lsp.buf.codeAction() if you don't want grouping.
end, { silent = true, buffer = bufnr })
vim.keymap.set(
  "n",
  "K", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
  function()
    vim.cmd.RustLsp({ "hover", "actions" })
  end,
  { silent = true, buffer = bufnr }
)

vim.keymap.set("n", "<M-\\>", function()
  vim.cmd.RustLsp({ "renderDiagnostic", "current" })
end, { noremap = true, silent = true })


-- make rustaceanvim auto refresh lint
-- local function SaveFileEnteringNormalMode()
--   vim.cmd("silent! update")
--   vim.cmd("RustLsp flyCheck")
-- end

-- vim.api.nvim_create_autocmd("ModeChanged", {
--   pattern = '*.rs',
--   callback = SaveFileEnteringNormalMode,
-- })



-- vim.keymap.set("n", "<M-\\>", checkdiagnostic, { noremap = true, silent = true })
