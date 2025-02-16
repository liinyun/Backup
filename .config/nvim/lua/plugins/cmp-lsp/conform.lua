-- this plugin is to format the codes 
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      "<leader>f",
      function()
        require("conform").format({ async = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  -- This will provide type hinting with LuaLS
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    -- Define your formatters
    formatters_by_ft = {
      lua = { "stylua" },
      htmldjango = { "djlint" },
      html = { "djlint" },
      python = { "isort", "black", stop_after_first = true },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      -- htmldjango = { "djlint", "djlint-reformat", "djlint-django", "djlint-reformat-django" }
    },
    -- Set default options
    -- default_format_opts = {
    --   lsp_format = "fallback",
    -- },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
    -- Set up format-on-sav
    formatters = {
      -- this is formatter for sh
      shfmt = {
        prepend_args = { "-i", "2" },
      },
      djlint = {
        command = vim.fn.stdpath("data") .. "/mason/bin/djlint",
        args = {
          "--reformat",
          "-",
          "--indent", "2",
          "--profile", "django", }, -- "-" tells it to read from stdin
        stdin = true,
      },
    },
  },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    -- change the default formater to this plugin's formater
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
