-- Code Tree Support / Syntax Highlighting
return {
  -- https://github.com/nvim-treesitter/nvim-treesitter
  'nvim-treesitter/nvim-treesitter',
  event = 'VeryLazy',
  dependencies = {
    -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    'nvim-treesitter/nvim-treesitter-textobjects',
    -- 这个是用来自动补全前端的括号的，事实上我感觉放在这里作为依赖有点不太合适，应该单独拿出来和autopairs放一起的
    "windwp/nvim-ts-autotag",
  },
  -- 这里的意思是每次 treesitter 插件安装或者更新后都会自动更新他的解析器
  -- 这里的 treesitter 和treesitter 的解析器 不是
  build = ':TSUpdate',
  opts = {
    highlight = {
      enable = true,
    },
    indent = { enable = true },
    auto_install = true, -- automatically install syntax support when entering new file type buffer
    autotag = {
      enable = true,
    },
    ensure_installed = {
      'json',
      'javascript',
      'typescript',
      'tsx',
      'yaml',
      'html',
      'css',
      'prisma',
      'lua',
      'vim',
      'svelte',
      'graphql',
      'bash',
      'dockerfile',
      'gitignore',
      'query',
      'c',
      'markdown_inline',
      'markdown',
    },
  },
  config = function(_, opts)
    local configs = require("nvim-treesitter.configs")
    configs.setup(opts)
  end
}
