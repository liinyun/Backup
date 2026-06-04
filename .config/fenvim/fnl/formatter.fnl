; (vim.pack.add [
; 	{ :src "https://github.com/eraserhd/parinfer-rust.git" :confirm false }])

(vim.pack.add [{:src "https://github.com/stevearc/conform.nvim.git"
                :confirm false}])

(let [conform (require :conform)]
  (conform.setup {:formatters_by_ft {:lua [:stylua]
                                     :fennel [:fnlfmt]
                                     ; :htmldjango [:djlint]
                                     ; html = { "djlint" },
                                     ; -- python = { "isort", "black", stop_after_first = true },
                                     ; python = { "ruff" },
                                     ; javascript = { "prettier", stop_after_first = true },
                                     ; -- jsonc = { "prettierd", "prettier", stop_after_first = true },
                                     ; jsonc = { "biome" },
                                     ; -- htmldjango = { "djlint", "djlint-reformat", "djlint-django", "djlint-reformat-django" }
                                     ; hurl = { "hurlfmt" },
                                     :julia [:jlfmt]
                                     :toml [:taplo]
                                     :rust [:rustfmt]
                                     :kdl [:kdlfmt]
                                     :xml [:xmllint]}
                  ; Set default options
                  ; default_format_opts = {
                  ;   lsp_format = "fallback",
                  ; },
                  :format_on_save {:timeout_ms 500 :lsp_format :fallback}
                  ; Set up format-on-sav
                  :formatters {; this is formatter for sh
                               :shfmt {:prepend_args [:-i :2]}
                               ; ruff = {
                               ; 	command = "ruff",
                               ; 	args = {
                               ; 		"--unfixable",
                               ; 		"F401",
                               ; 	},
                               ; },
                               :djlint {; command = vim.fn.stdpath("data") .. "/mason/bin/djlint",
                                        :command :djlint
                                        :args [:--reformat
                                               "-"
                                               :--indent
                                               :2
                                               :--profile
                                               :django]
                                        ; "-" tells it to read from stdin
                                        :stdin true}
                               :jlfmt {:command :jlfmt :args ["-"] :stdin true}
                               :xml {:command :xmllint :args [:--format "-"]}}}))

(vim.keymap.set :n :<leader>f
                (fn []
                  ((. (require :conform) :format) {:async true}))
                {:desc "Format buffer"})

; (vim.keymap.set "n" "<leader>f" 
;                 (fn [] ((. (require :conform) :format) {:async true}))
;                 {:desc "Format buffer"})

