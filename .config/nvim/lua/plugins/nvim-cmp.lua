-- Auto-completion / Snippets
return {
  -- https://github.com/hrsh7th/nvim-cmp
  'hrsh7th/nvim-cmp',
  -- 表示这个插件只会在insert 模式下加载
  event = 'InsertEnter',
  dependencies = {
    -- Snippet engine & associated nvim-cmp source
    -- https://github.com/L3MON4D3/LuaSnip
    -- 代码片段引擎，是用来加载和使用代码片段的，代码片段可以自己写也可以从下面的friendly-snippets中加载
    -- 但是这仅仅是个管理代码片段的，并不能够在候选框中出现
    'L3MON4D3/LuaSnip',
    -- https://github.com/saadparwaiz1/cmp_luasnip
    -- 这是将代码片段转为补全源的插件。有代码片段，能够使用代码片段不代表可以直接放在候选框里，需要转换成
    -- 补全源后才能进入候选框
    -- 事实上代码片段是可以直接插入的，这个和出现在提示框中是两回事，出现在提示框中的是补全源
    'saadparwaiz1/cmp_luasnip',

    -- LSP completion capabilities
    -- https://github.com/hrsh7th/cmp-nvim-lsp
    -- 这个是lsp 中的补全源，这样 nvim-cmp 就可以从lsp 中获得补全源了
    'hrsh7th/cmp-nvim-lsp',

    -- Additional user-friendly snippets
    -- https://github.com/rafamadriz/friendly-snippets
    -- 这个是代码片段库，这里代码片段和下面的三个是不一样的
    -- 代码片段比如是不同语言的for 循环之类的，但是下面的是看本地条件和当前文件的，不是预设好的
    -- 任何语言都有代码片段，这些都是死的。但是不同的电脑有不同的路径，不同的文件有不同的变量
    -- 代码片段引擎是无法直接在候选框中使用的，需要变成补全源后才能出现在候选框中，那么就需要上面的cmp_luasnip 将代码片段变为补全源
    'rafamadriz/friendly-snippets',
    -- https://github.com/hrsh7th/cmp-buffer
    -- 这个是buffer就是当前文件中使用过的变量之类的补全源
    'hrsh7th/cmp-buffer',
    -- https://github.com/hrsh7th/cmp-path
    -- 这个是路径填充的补全源
    'hrsh7th/cmp-path',
    -- https://github.com/hrsh7th/cmp-cmdline
    -- 这个是命令行的补全源
    'hrsh7th/cmp-cmdline',
  },
  config = function()
    -- require('cmp') 类似pyhon 中的import 这里是加载 cmp 这个模块
    -- ok,还可以回顾一下,虽然.config/nvim 文件夹中没有 cmp 这个模块,但是在runtimepath 中是有这个模块的
    -- 所以这里可以直接require 这个模块.require 只能require 模块名,不能直接require 一个路径的
    -- 要么添加到require 的搜索路径中,要么添加到runtimepath 中,下面的那个也是同理的
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    -- 添加 vscode 中的片段系统,这个是luasnip自带的加载器，并不是引擎。这个仅仅是从片段库中加载代码片段，得到的是代码片段
    -- 后续还需要luasnip转为补全源
    require('luasnip.loaders.from_vscode').lazy_load()
    -- luasnip 没有什么设置需要加载
    luasnip.config.setup({})
    -- 进行设置和初始化
    cmp.setup({
      -- 这里的意思就是 nvim-cmp 补全的时候如果使用luasnip 中的代码片段进行补全,就会使用下面的函数
      -- 这里仅仅是代码片段的部分，后面的source 是补全源的部分
      -- 这个snippet 也是 cmp_luasnip 这个插件起作用的地方，如果没有这个插件
      -- 让 nvim-cmp 直接调用 luasnip.lsp_expand 的话，并不能让候选框中显示代码片段，因为这个代码片段还不是补全源
      -- 这个时候就需要 cmp_luasnip 在显示代码片段的时候转为补全源来显示
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      -- 这个是补全菜单的设置，进行补全的时候会启动补全菜单
      -- 就算只有一个也会启用菜单
      -- 不会自动将菜单的第一个进行填充
      completion = {
        completeopt = 'menu,menuone,noinsert',
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-j>'] = cmp.mapping.select_next_item(), -- next suggestion
        ['<C-k>'] = cmp.mapping.select_prev_item(), -- previous suggestion
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),    -- scroll backward
        ['<C-f>'] = cmp.mapping.scroll_docs(4),     -- scroll forward
        ['<C-Space>'] = cmp.mapping.complete {},    -- show completion suggestions
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        -- Tab through suggestions or when a snippet is active, tab to the next argument
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        -- Tab backwards through suggestions or when a snippet is active, tab to the next argument
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      },
      -- 这里定义的是补全源，事实上 luasnip 提供的是代码片段，但是cmp会判断，如果是代码片段的话
      -- 会直接调用snippet,如果不是的话，会直接添加进候选框
      sources = cmp.config.sources({
        { name = "nvim_lsp" }, -- lsp
        { name = "luasnip" },  -- snippets
        { name = "buffer" },   -- text within current buffer
        { name = "path" },     -- file system paths
      }),
      window = {
        -- Add borders to completions popups
        -- 这个是补全窗口，是可以往这个函数里面添加参数进行美化的
        completion = cmp.config.window.bordered(),
        -- 这个是文档窗口，是可以往这个函数里面添加参数进行美化的
        -- 文档里面的内容大多是lsp 中的注释
        documentation = cmp.config.window.bordered(),
      },
    })
  end,
}
