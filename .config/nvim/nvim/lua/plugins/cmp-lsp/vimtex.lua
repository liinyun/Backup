-- 这里我就没有自己定义编译链了，因为 latexmk 的编译链很厉害，能够自动处理这些问题
local vimtex = {
  "lervag/vimtex",
  lazy = false, -- we don't want to lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- VimTeX configuration goes here, e.g.
    -- 这个是设置外部 默认 pdf 查看器
    -- 但是用处不大，因为下面那一行只要指定了 zathura就不用了，所以我这里直接注释了
    -- vim.g.vimtex_view_general_viewer = 'zathura'
    vim.g.vimtex_view_method = "zathura"
    -- 这里是设置 zathura 为 pdf 查看器
    vim.g.tex_flavor = "latex"
    -- 使用 latexmk 编译
    vim.g.vimtex_compiler_method = 'latexmk'
    -- -- 配置 latexmk 使用 xelatex 替换 pdftex 编译
    vim.g.vimtex_compiler_latexmk = {
      continuous = 1,
      -- callback = 1,
      --   build_dir = '', -- 可选，指定编译输出目录
      --   options = {
      --     '-xelatex',   -- 使用 xelatex 编译
      --     '-file-line-error',
      --     '-synctex=1',
      --     '-interaction=nonstopmode',
      -- },
    }
    -- -- 这个是在报错的时候立刻打印错误信息
    vim.g.vimtex_quickfix_mode = 1
    -- 这个可以让 latex 代码中的一些符号直接表示出来，比如 \alpha 会转成 那个字母之类的
    -- 可以取的值有 0,1,2,3 还是自己要用的时候到时候查一下吧
    -- 但是现在想想其实没有那么必要
    vim.opt.conceallevel = 0
    -- 这个是和上面的那个一起使用的，既然上面的那个我没开启的话，我这里就直接注释掉了
    -- vim.g.tex_conceal = 'abdmg'
    -- 这个是本地 leader 键，只对某些文件生效。我这里就先不配置了，以后需要的时候再配置
    -- 因为我感觉现在还不是需要使用这些快捷键的时候
    -- vim.g.maplocalleader = ","
  end
}

return vimtex
