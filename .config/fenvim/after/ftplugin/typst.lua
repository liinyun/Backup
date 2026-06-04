-- :fennel:1780514269
local function TinymistCompileToPdf()
  local params = {textDocument = {uri = vim.uri_from_bufnr(0)}, text = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")}
  return vim.lsp.buf_notify(0, "textDocument/didSave", params)
end
return vim.api.nvim_create_autocmd("ModeChanged", {pattern = "i*:*", callback = TinymistCompileToPdf})