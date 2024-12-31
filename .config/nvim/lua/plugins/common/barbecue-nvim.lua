-- Display LSP-based breadcrumbs
-- 这个是显示路径的，因为你看这个路径是不是像一个烤串
-- 不止显示路径，还能显示当前在哪个函数中，还是比较有用的
return {
  -- https://github.com/utilyre/barbecue.nvim
  "utilyre/barbecue.nvim",
  name = "barbecue",
  version = "*",
  dependencies = {
    -- https://github.com/SmiteshP/nvim-navic
    "SmiteshP/nvim-navic",
    -- https://github.com/nvim-tree/nvim-web-devicons
    "nvim-tree/nvim-web-devicons", -- optional dependency
  },
  opts = {
    -- configurations go here
  },
}
