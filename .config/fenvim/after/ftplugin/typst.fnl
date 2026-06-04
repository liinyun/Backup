(fn TinymistCompileToPdf []
  (let [params {:textDocument {:uri (vim.uri_from_bufnr 0)}
                ; We include the text to ensure the server is perfectly in sync
                :text (table.concat (vim.api.nvim_buf_get_lines 0 0 -1 false)
                                    "\n")}]
    (vim.lsp.buf_notify 0 :textDocument/didSave params)))

(vim.api.nvim_create_autocmd :ModeChanged
                             {:pattern "i*:*"
                              ;  nested = true,
                              :callback TinymistCompileToPdf})

