return{}
-- return {
--   "neovim/nvim-lspconfig",
--   -- 缓冲区加载之前或者在新建缓冲区的时候会触发这个插件
--   -- event = 'VeryLazy',
--   dependencies = {
--     -- 为什么这里还要启动这个插件
--     -- 放在dependencies 是为了让这个插件和lsp 一起启动，当然也是可以使用require来启动的
--     -- 因为 cmp-nvim-lsp 并不存储任何的补全源，这个插件能提供补全源的前提是有lsp 服务器在启动
--     -- 所以只有这两个都启动了，lsp 的补全才能使用
--     -- 如果能保证 需要补全的时候这两个插件都启动，那么也没什么。这里直接就不去思考那些条件了
--     -- 直接就是在启动lsp 的时候就启动 cmp-nvim-lsp 保证使用lsp 补全的时候插件们都是启动的
--     { 'williamboman/mason-lspconfig.nvim' },
--     "hrsh7th/cmp-nvim-lsp",
--     { "antosha417/nvim-lsp-file-operations", config = true },
--     { "folke/neodev.nvim",                   opts = {} },
--   },
--   config = function()
--     -- import lspconfig plugin
--     local lspconfig = require("lspconfig")

--     -- import mason_lspconfig plugin
--     local mason_lspconfig = require("mason-lspconfig")

--     -- import cmp-nvim-lsp plugin
--     local cmp_nvim_lsp = require("cmp_nvim_lsp")

--     local keymap = vim.keymap -- for conciseness

--     vim.api.nvim_create_autocmd("LspAttach", {
--       group = vim.api.nvim_create_augroup("UserLspConfig", {}),
--       callback = function(ev)
--         -- Buffer local mappings.
--         -- See `:help vim.lsp.*` for documentation on any of the below functions
--         -- 表示某个动作，设置什么的都局限在当前缓冲区，并不会破坏全局的设置
--         local opts = { buffer = ev.buf, silent = true }

--         -- set keybinds
--         opts.desc = "Show LSP references"
--         -- 表示 这个键位映射只在当前 缓冲区中有效
--         keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

--         opts.desc = "Go to declaration"
--         keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

--         opts.desc = "Show LSP definitions"
--         keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

--         opts.desc = "Show LSP implementations"
--         keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

--         opts.desc = "Show LSP type definitions"
--         keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

--         opts.desc = "See available code actions"
--         keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

--         opts.desc = "Smart rename"
--         keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

--         opts.desc = "Show buffer diagnostics"
--         keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

--         opts.desc = "Show line diagnostics"
--         keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

--         opts.desc = "Go to previous diagnostic"
--         keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

--         opts.desc = "Go to next diagnostic"
--         keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

--         opts.desc = "Show documentation for what is under cursor"
--         keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

--         opts.desc = "Restart LSP"
--         keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
--       end,
--     })

--     -- used to enable autocompletion (assign to every lsp server config)
--     -- 这个是 cmp_nvim_lsp 是用来确保补全功能的
--     -- cmp_nvim_lsp 这个变量在前面被定义过
--     local capabilities = cmp_nvim_lsp.default_capabilities()

--     -- Change the Diagnostic symbols in the sign column (gutter)
--     -- (not in youtube nvim video)
--     -- 这里是定义诊断标识符
--     local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
--     --
--     for type, icon in pairs(signs) do
--       local hl = "DiagnosticSign" .. type
--       vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
--     end
--     -- 这里的 setup_handlers 是可以让不同的lsp server 使用不同的配置
--     mason_lspconfig.setup_handlers({
--       -- default handler for installed servers
--       -- 这个是默认的lsp 配置。如果这个lsp 没有在下面配置过的话，就会默认使用这个配置
--       function(server_name)
--         lspconfig[server_name].setup({
--           capabilities = capabilities,
--         })
--       end,
--       ["svelte"] = function()
--         -- configure svelte server
--         lspconfig["svelte"].setup({
--           capabilities = capabilities,
--           on_attach = function(client, bufnr)
--             vim.api.nvim_create_autocmd("BufWritePost", {
--               pattern = { "*.js", "*.ts" },
--               callback = function(ctx)
--                 -- Here use ctx.match instead of ctx.file
--                 client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
--               end,
--             })
--           end,
--         })
--       end,
--       ["graphql"] = function()
--         -- configure graphql language server
--         lspconfig["graphql"].setup({
--           capabilities = capabilities,
--           filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
--         })
--       end,
--       ["emmet_ls"] = function()
--         -- configure emmet language server
--         lspconfig["emmet_ls"].setup({
--           capabilities = capabilities,
--           filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
--         })
--       end,
--       ["lua_ls"] = function()
--         -- configure lua server (with special settings)
--         lspconfig["lua_ls"].setup({
--           capabilities = capabilities,
--           settings = {
--             Lua = {
--               -- make the language server recognize "vim" global
--               diagnostics = {
--                 globals = { "vim" },
--               },
--               completion = {
--                 callSnippet = "Replace",
--               },
--             },
--           },
--         })
--       end,
--     })
--   end,
-- }
