vim.cmd([[
  autocmd FileType tex lua DynamicCompiler()
]])


function DynamicCompiler()
  local filepath = vim.fn.expand('%:p')
  local content = vim.fn.readfile(filepath)

  -- 检查文件是否包含 ctexart 或其他 CTeX 相关文档类
  if vim.fn.matchlist(content[1], '\\documentclass.*{ctex') ~= nil then
    vim.g.vimtex_compiler_latexmk = {
      executable = 'latexmk',
      options = { '-xelatex', '-file-line-error', '-synctex=1', '-interaction=nonstopmode' },
    }
  else
    vim.g.vimtex_compiler_latexmk = {
      executable = 'latexmk',
      options = { '-pdf', '-file-line-error', '-synctex=1', '-interaction=nonstopmode' },
    }
  end
end
