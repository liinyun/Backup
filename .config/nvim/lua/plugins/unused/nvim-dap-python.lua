local M
local python_path
if os.getenv("CONDA_PREFIX") then
  python_path = os.getenv("CONDA_PREFIX") .. "/bin/python"
elseif os.getenv("VIRTUAL_ENV") then
  python_path = os.getenv("VIRTUAL_ENV") .. "/bin/python"
else
  python_path = "usr/bin/python3"
end
M = {
  -- https://github.com/mfussenegger/nvim-dap-python
  'mfussenegger/nvim-dap-python',
  ft = 'python',
  dependencies = {
    -- https://github.com/mfussenegger/nvim-dap
    'mfussenegger/nvim-dap',
  },
  config = function()
    -- Update the path passed to setup to point to your system or virtual env python binary
    require('dap-python').setup(python_path)
  end
}
return M
