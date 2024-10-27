return{
  "olimorris/onedarkpro.nvim",
  priority = 1000, -- Ensure it loads first
  config = function()
    -- 设置主题
    require("onedarkpro").setup({
        options = {
            transparency = true,
        },
    })
    -- 应用 OneDark 主题
    vim.cmd("colorscheme onedark")
  end,
}
