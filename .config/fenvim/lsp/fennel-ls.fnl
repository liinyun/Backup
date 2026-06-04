(local blink (require :blink.cmp))
(local lsp_capabilities
       (blink.get_lsp_capabilities {:offsetEncoding [:utf-8 :utf-16]}))

{:cmd [:fennel-ls :--server]
 :filetypes [:fennel]
 ; :root_markers ["flsproject.fnl" 
 ; 	".git"]
 ; :capabilities {:offsetEncoding [:utf-8 :utf-16]}
 :root_dir (fn [bufnr on_dir]
             (let [fname (vim.api.nvim_buf_get_name bufnr)
                   has_fls_project_cfg? (fn [path]
                                          (= (. (or (vim.uv.fs_stat (vim.fs.joinpath path
                                                                                     :flsproject.fnl))
                                                    {})
                                                :type)
                                             :file))]
               (on_dir (or (-> (vim.fs.parents fname)
                               (vim.iter)
                               (: :find has_fls_project_cfg?))
                           (vim.fs.root 0 :.git)))))
 ; :on_attach (fn [_bufnr] (require :conjure))
 :capabilities lsp_capabilities
 :settings {:workspace {:library (vim.api.nvim_list_runtime_paths)}
            :diagnostics {:globals [:vim]}}}

