(vim.opt.clipboard:append :unnamedplus)
; (set vim.opt.clipboard (.. vim.opt.clipboard :unnamedplus)) ; I don't understand why this line have error, I will disable this line first. 

(set vim.g.mapleader " ")
(set vim.opt.number true)
(set vim.opt.termguicolors true)
; (set vim.opt.shiftwidth 2)
(set vim.opt.tabstop 2)

(require :lsp)
(require :lang)
(require :common)
(require :conjure)
(require :keymaps)
(require :treesitter)
(require :formatter)

(local OSName (. (vim.uv.os_uname) :sysname))

; (vim.cmd "colorscheme catppuccin")
(vim.api.nvim_set_hl 0 :Normal {:bg :none})

(when (= OSName :Linux) ; 这个是支持ssh 的时候将 nvim 复制的东西传到本地的剪切板
  (do
    (set vim.g.clipboard
         {:name "OSC 52"
          :copy {:+ ((. (require :vim.ui.clipboard.osc52) :copy) "+")
                 :* ((. (require :vim.ui.clipboard.osc52) :copy) "*")}
          :paste {:+ ((. (require :vim.ui.clipboard.osc52) :paste) "+")
                  :* ((. (require :vim.ui.clipboard.osc52) :paste) "*")}})
    (vim.api.nvim_create_autocmd :BufReadPost
                                 {:group (vim.api.nvim_create_augroup :OpenPDFWithZathura
                                                                      {:clear true})
                                  :pattern [:*.pdf]
                                  :callback (fn []
                                              (vim.fn.system (.. "zathura "
                                                                 (vim.fn.expand "%")
                                                                 " &")))}) ; this is a bug, that nvim can't recognize xlsx file. I will just let this autocmd exist until they fix it
    (vim.api.nvim_create_autocmd :BufReadCmd
                                 {:group (vim.api.nvim_create_augroup :OpenEXCELWithWPS
                                                                      {:clear true})
                                  :pattern [:*.xlsx :*.xls :*.doc]
                                  :callback (fn []
                                              (vim.fn.system (.. "wps "
                                                                 (vim.fn.expand "%")
                                                                 " &")))}) ; 先判断是不是在 ssh 中，如果不在 ssh 中，就启用这个 命令，否则就不启用
    ; 因为在os_name = "Linux" 中，所以这个条件我就不再写了 ; judge if it is in linux at the same time ; if vim.fn.getenv("SSH_TTY") == vim.NIL and os_name == "Linux" then
    (local (status _) (vim.fn.system "which fcitx5-remote"))
    (when (= (vim.fn.getenv :SSH_TTY) vim.NIL)
      (vim.api.nvim_create_autocmd :InsertLeave
                                   {:pattern "*"
                                    :callback (fn []
                                                (if status
                                                    (do
                                                      (vim.fn.system "fcitx5-remote -c")
                                                      nil)
                                                    ; switch to English input method)
                                                    (do
                                                      (print "haven't installed fcitx5-remote yet ")
                                                      nil)))}))))

(when (= OSName :Windows_NT)
  ((require :core.scripts.utils) :vim.opt.shadafile :NONE))

(vim.filetype.add {:filename {:pages.json :jsonc
                              :manifest.json :jsonc
                              :coc-settings.json :jsonc}})

