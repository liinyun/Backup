-- 我现在想想好像，这个插件我真的用的非常少，事实上，我每次退出nvim 的成本非常小，完全没必要一定在nvim 中切换虚拟环境
-- 这个插件 是要配合着lsp 使用的，所以如果使用coc的话，这就没什么用处了
-- return {
--   "linux-cultist/venv-selector.nvim",
--   dependencies = {
--     "neovim/nvim-lspconfig",
--     -- "mfussenegger/nvim-dap", "mfussenegger/nvim-dap-python", --optional
--     { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
--   },
--   lazy = false,
--   branch = "regexp", -- This is the regexp branch, use this for the new version
--   config = function()
--     require("venv-selector").setup()
--   end,
--   keys = {
--     { ",v", "<cmd>VenvSelect<cr>" },
--   },
-- }
return {
  'linux-cultist/venv-selector.nvim',
  dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python' },
  event = 'VeryLazy', -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
  branch = "regexp",  -- This is the regexp branch, use this for the new version
  config = function()
    require('venv-selector').setup {
      -- Your options go here
      -- name = "venv",
      -- auto_refresh = false
    }
  end,
  keys = {
    -- Keymap to open VenvSelector to pick a venv.
    { '<leader>vs', '<cmd>VenvSelect<cr>' },
    -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
    -- { '<leader>vc', '<cmd>VenvSelectCached<cr>' },
  },
}
