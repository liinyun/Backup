local M = {}
M = {
  "neoclide/coc.nvim",
  branch = "release",    -- 使用稳定分支
  build = "npm install", -- 安装依赖
  config = function()
    -- 添加 coc.nvim 的配置
    vim.g.coc_global_extensions = {
      -- "coc-pyright", -- Python 补全
      "coc-basedpyright",          -- Python 补全
      "coc-json",                  -- JSON 支持
      "coc-tsserver",              -- TypeScript/JavaScript 补全
      "coc-html",                  -- HTML 补全
      "coc-css",                   -- CSS 补全
      "@yaegassy/coc-volar",       -- Volar (Fast Vue Language Support) extension for coc.nvim
      "@yaegassy/coc-volar-tools", -- Additional features of coc-volar
      "coc-lua",                   -- lua lsp for coc
      "coc-explorer",              -- file explorer in coc
      "coc-pairs",                 -- autopair plugin
      "coc-translator",            -- translator plugin
      -- "coc-typescript-vue-plugin"  -- TypeScript Vue Plugin (Volar) for coc.nvim
    }
    -- https://raw.githubusercontent.com/neoclide/coc.nvim/master/doc/coc-example-config.lua

    -- Some servers have issues with backup files, see #649
    -- 不创建备份文件
    vim.opt.backup = false
    -- 因为前面false 了，所以这里也要false 这里的意思是保存文件的时候先写入备份文件然后覆盖，而不是直接覆盖
    vim.opt.writebackup = false

    -- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
    -- delays and poor user experience
    vim.opt.updatetime = 300

    -- Always show the signcolumn, otherwise it would shift the text each time
    -- diagnostics appeared/became resolved
    vim.opt.signcolumn = "yes"

    local keyset = vim.keymap.set
    -- Autocomplete
    -- 这里其实是最初为了照顾 tab 进行补全的时候设置的函数，如果光标前面没有字符，那么tab 的时候，就不会补全
    -- 对于我而言其实没什么必要了，因为我现在基本都是直接 ctrl+j 根本没有这种烦恼
    -- 我迟早把这里改掉，因为下面有快捷键用了这个了
    function _G.check_back_space()
      local col = vim.fn.col(".") - 1
      return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
    end

    -- Use <c-j> for trigger completion with characters ahead and navigate
    -- NOTE: There's always a completion item selected by default, you may want to enable
    -- no select by setting `"suggest.noselect": true` in your configuration file
    -- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
    -- other plugins before putting this into your config
    local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
    -- keyset("i", "<c-j>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)

    -- keyset(
    --   "i",
    --   "<TAB>",
    --   'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()',
    --   opts
    -- )
    -- change the default shortcut of coc#snippets#next and coc#snippets#prev
    vim.g.coc_snippet_next = "<c-n>"
    vim.g.coc_snippet_prev = "<c-p>"
    keyset("i", "<c-j>", [[coc#pum#visible() ? coc#pum#next(1) : "<Nop>" ]], opts)
    keyset("i", "<c-k>", [[coc#pum#visible() ? coc#pum#prev(1) : "<Nop>"]], opts)
    -- 这里的 \<c-h> 我其实不是很理解有什么用处，但我不是很想改了
    -- keyset("i", "<c-k>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
    -- this is to jump into the floating windows
    -- vim.keymap.set('n', '<C-f>', function()
    --   return vim.fn['coc#float#has_float']() and vim.fn['coc#float#jump']() or '<C-f>'
    -- end, { expr = true })
    -- this is the inlayhint highlight
    vim.api.nvim_set_hl(0, "CocInlayHint", { fg = "#888888", bg = "NONE", italic = true })

    -- Make <CR> to accept selected completion item or notify coc.nvim to format
    -- 这个 <CR> 就是 回车
    -- <C-g>u breaks current undo, please make your own choice
    keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

    -- Use tab to trigger snippets
    -- keyset("i", "<TAB>", "<Plug>(coc-snippets-expand-jump)")
    -- Use <c-space> to trigger completion
    -- 我这里不使用<c-space> 这种快捷键，因为和我的输入法重了
    -- keyset("i", "<c-space>", "coc#refresh()", { silent = true, expr = true })

    -- Use `[g` and `]g` to navigate diagnostics
    -- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
    keyset("n", "[d", "<Plug>(coc-diagnostic-prev)", { silent = true })
    keyset("n", "]d", "<Plug>(coc-diagnostic-next)", { silent = true })

    -- GoTo code navigation

    -- 我为什么使用gd而不使用 leader gd 之类的，因为gd 是 nvim 默认的快捷键
    -- 而且normal 模式使用gd 一点问题没有，gd 只是显示信息，并不做修改
    keyset("n", "gd", "<Plug>(coc-definition)", { silent = true })
    keyset("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
    keyset("n", "gi", "<Plug>(coc-implementation)", { silent = true })
    keyset("n", "gr", "<Plug>(coc-references)", { silent = true })

    -- Use K to show documentation in preview window
    function _G.show_docs()
      local cw = vim.fn.expand("<cword>")
      if vim.fn.index({ "vim", "help" }, vim.bo.filetype) >= 0 then
        vim.api.nvim_command("h " .. cw)
      elseif vim.api.nvim_eval("coc#rpc#ready()") then
        -- vim.fn.CocActionAsync("doHover")
        vim.fn.CocActionAsync("definitionHover")
      else
        vim.api.nvim_command("!" .. vim.o.keywordprg .. " " .. cw)
      end
    end

    function _G.quit_floating_win()
      local win_id = vim.api.nvim_get_current_win()
      local config = vim.api.nvim_win_get_config(win_id)
      local flag = config.relative ~= ""
      if flag then
        vim.api.nvim_win_close(win_id, true)
      end
    end

    function _G.definition_show_jump()
      if vim.fn["coc#float#has_float"]() == 1 then
        vim.fn["coc#float#jump"]()
      else
        _G.show_docs()
      end
    end

    function _G.diagnostic_show_jump()
      if vim.fn["coc#float#has_float"]() == 1 then
        vim.fn["coc#float#jump"]()
      else
        vim.fn.CocActionAsync("diagnosticInfo")
      end
    end

    -- show the doc, if the dock is shown, it will jump into the doc like nvim
    keyset("n", "K", "<CMD>lua _G.definition_show_jump()<CR>")
    -- exit the doc, like q in nvim setting
    keyset("n", "<Esc>", "<CMD>lua _G.quit_floating_win()<CR>")
    -- keyset("n", "K", "<CMD>lua _G.show_docs()<CR>", { silent = true })
    keyset("n", "<leader>t", "<Plug>(coc-translator-p)")
    -- keyset("n", "<M-\\>", "<Plug>(coc-diagnostic-info)", { noremap = true, silent = true })
    keyset("n", "<M-\\>", "<CMD>lua _G.diagnostic_show_jump()<CR>", { noremap = true, silent = true })


    -- Highlight the symbol and its references on a CursorHold event(cursor is idle)
    vim.api.nvim_create_augroup("CocGroup", {})
    vim.api.nvim_set_hl(0, "CocHighlightText", { bg = "#2b4e6f", bold = false, underline = true })
    vim.api.nvim_create_autocmd("CursorHold", {
      group = "CocGroup",
      command = "silent call CocActionAsync('highlight')",
      desc = "Highlight symbol under cursor on CursorHold",
    })

    -- Symbol renaming
    keyset("n", "<leader>rn", "<Plug>(coc-rename)", { silent = true })

    -- Formatting selected code
    keyset("x", "<leader>f", "<Plug>(coc-format-selected)", { silent = true })
    keyset("n", "<leader>f", "<Plug>(coc-format-selected)", { silent = true })

    -- Setup formatexpr specified filetype(s)
    vim.api.nvim_create_autocmd("FileType", {
      group = "CocGroup",
      pattern = "typescript,json",
      command = "setl formatexpr=CocAction('formatSelected')",
      desc = "Setup formatexpr specified filetype(s).",
    })

    -- Update signature help on jump placeholder
    vim.api.nvim_create_autocmd("User", {
      group = "CocGroup",
      pattern = "CocJumpPlaceholder",
      command = "call CocActionAsync('showSignatureHelp')",
      desc = "Update signature help on jump placeholder",
    })

    -- Apply codeAction to the selected region
    -- Example: `<leader>aap` for current paragraph
    -- ---@diagnostic disable-next-line: redefined-local
    opts = { silent = true, nowait = true }
    keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
    keyset("n", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)

    -- Remap keys for apply code actions at the cursor position.
    keyset("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", opts)
    -- keyset("n", "<M-CR>", "<Plug>(coc-codeaction-cursor)", opts)
    -- Remap keys for apply source code actions for current file.
    keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", opts)
    -- Apply the most preferred quickfix action on the current line.
    keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)

    -- Remap keys for apply refactor code actions.
    keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
    keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
    keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

    -- Run the Code Lens actions on the current line
    keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)

    -- Map function and class text objects
    -- NOTE: Requires 'textDocument.documentSymbol' support from the language server
    keyset("x", "if", "<Plug>(coc-funcobj-i)", opts)
    keyset("o", "if", "<Plug>(coc-funcobj-i)", opts)
    keyset("x", "af", "<Plug>(coc-funcobj-a)", opts)
    keyset("o", "af", "<Plug>(coc-funcobj-a)", opts)
    keyset("x", "ic", "<Plug>(coc-classobj-i)", opts)
    keyset("o", "ic", "<Plug>(coc-classobj-i)", opts)
    keyset("x", "ac", "<Plug>(coc-classobj-a)", opts)
    keyset("o", "ac", "<Plug>(coc-classobj-a)", opts)

    -- Remap <C-f> and <C-b> to scroll float windows/popups
    ---@diagnostic disable-next-line: redefined-local
    -- local opts = { silent = true, nowait = true, expr = true }
    -- keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
    -- keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
    -- keyset("i", "<C-f>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
    -- keyset("i", "<C-b>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
    -- keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
    -- keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)

    -- Use CTRL-S for selections ranges
    -- Requires 'textDocument/selectionRange' support of language server
    keyset("n", "<C-s>", "<Plug>(coc-range-select)", { silent = true })
    keyset("x", "<C-s>", "<Plug>(coc-range-select)", { silent = true })

    -- Add `:Format` command to format current buffer
    vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

    -- " Add `:Fold` command to fold current buffer
    vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", { nargs = "?" })

    -- Add `:OR` command for organize imports of the current buffer
    vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

    -- Add (Neo)Vim's native statusline support
    -- NOTE: Please see `:h coc-status` for integrations with external plugins that
    -- provide custom statusline: lightline.vim, vim-airline
    vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

    -- Mappings for CoCList
    -- code actions and coc stuff
    -- ---@diagnostic disable-next-line: redefined-local
    opts = { silent = true, nowait = true }
    -- Show all diagnostics
    keyset("n", "<space>a", ":<C-u>CocList diagnostics<cr>", opts)
    -- Manage extensions
    -- keyset("n", "<space>e", ":<C-u>CocList extensions<cr>", opts)
    -- Show commands
    keyset("n", "<space>c", ":<C-u>CocList commands<cr>", opts)
    -- Find symbol of current document
    keyset("n", "<space>o", ":<C-u>CocList outline<cr>", opts)
    -- Search workspace symbols
    keyset("n", "<space>s", ":<C-u>CocList -I symbols<cr>", opts)
    -- Do default action for next item
    keyset("n", "<space>j", ":<C-u>CocNext<cr>", opts)
    -- Do default action for previous item
    keyset("n", "<space>k", ":<C-u>CocPrev<cr>", opts)
    -- Resume latest coc list
    keyset("n", "<space>p", ":<C-u>CocListResume<cr>", opts)
  end,
}
return M
