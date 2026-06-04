-- :fennel:1780562465
local blink = require("blink.cmp")
local lsp_capabilities = blink.get_lsp_capabilities({offsetEncoding = {"utf-8", "utf-16"}})
local function _1_(bufnr, on_dir)
  local fname = vim.api.nvim_buf_get_name(bufnr)
  local has_fls_project_cfg_3f
  local function _2_(path)
    return ((vim.uv.fs_stat(vim.fs.joinpath(path, "flsproject.fnl")) or {}).type == "file")
  end
  has_fls_project_cfg_3f = _2_
  return on_dir((vim.iter(vim.fs.parents(fname)):find(has_fls_project_cfg_3f) or vim.fs.root(0, ".git")))
end
return {cmd = {"fennel-ls", "--server"}, filetypes = {"fennel"}, root_dir = _1_, capabilities = lsp_capabilities, settings = {workspace = {library = vim.api.nvim_list_runtime_paths()}, diagnostics = {globals = {"vim"}}}}