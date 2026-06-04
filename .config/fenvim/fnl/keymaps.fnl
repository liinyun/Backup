; =====================================================================================
; ================================== select mode ======================================
; =====================================================================================
(vim.keymap.del :s "<Tab>" )
(vim.keymap.del :s "<S-Tab>")
(vim.keymap.set :v :J ":m '>+1<CR>gv=gv" {:noremap true :silent true})
(vim.keymap.set :v :K ":m '<-2<CR>gv=gv" {:noremap true :silent true})

; =====================================================================================
; ================================== normal mode ======================================
; =====================================================================================

(vim.api.nvim_set_keymap :n :U "<C-r>" {:noremap true})
; project "Alt+j" to '*' in normal mode, to find the next same word
(vim.api.nvim_set_keymap :n "<M-j>" "*" {:noremap true})
; project "Alt+k" to find the same word above (#)
(vim.api.nvim_set_keymap :n "<M-k>" "#" {:noremap true})
; it is a stupid shortcut totally waste of key. it works to merge the next line to the current line
; I can't image which coding language would do this frequently
(vim.api.nvim_set_keymap :n :J "<nop>" {:noremap true})

(vim.keymap.set :n :yyy :yy { :noremap true :silent true :desc "Yank current line" })


; ==================== plugins ==================== 
(fn quit-floating-win []
  (let [win-id (vim.api.nvim_get_current_win)
        config (vim.api.nvim_win_get_config win-id)
	flag (~= config.relative "" )
	]
    (when flag
      (vim.api.nvim_win_close win-id true))))


(vim.keymap.set :n "<Esc>" #(quit-floating-win) {:noremap true} )


(vim.keymap.set :n "<M-\\>" "<cmd>lua vim.diagnostic.open_float()<CR>" {:noremap true} )


(vim.keymap.set :n "[d" #(vim.diagnostic.jump {:count -1}) {:noremap true})
(vim.keymap.set :n "]d" #(vim.diagnostic.jump {:count 1}) {:noremap true})

(vim.keymap.set :c "<C-j>" "<C-n>" {:noremap true :silent true })
(vim.keymap.set :c "<C-k>" "<C-p>" {:noremap true :silent true })


