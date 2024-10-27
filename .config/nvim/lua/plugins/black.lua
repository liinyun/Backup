-- Python formatter
return {
  -- https://github.com/psf/black
  'psf/black',
  ft = 'python',
  config = function()
    -- Automatically format file buffer when saving
    -- 这里的 vim.api.nvim_create_autocmd 是创建一个命令的意思
    -- BufWritePre 表示每次在保存文件之前都会执行这个命令
    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
      -- 只会在 python 文件被保存的时候触发
      pattern = "*.py",
      callback = function()
        vim.cmd("Black")
      end,
    })
  end
}
