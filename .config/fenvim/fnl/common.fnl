(vim.pack.add [{:src "https://github.com/ibhagwan/fzf-lua.git" :confirm false}])
(local fzf_cmd (require :fzf-lua))

(vim.keymap.set :n :<leader>ff fzf_cmd.files {:desc "Telescope find files"})
(vim.keymap.set :n :<leader>fg fzf_cmd.live_grep {:desc "Telescope live grep"})

(vim.keymap.set :n :<leader>fb fzf_cmd.buffers {:desc "Telescope buffers"})
(vim.keymap.set :n :<leader>fs fzf_cmd.lsp_document_symbols
                {:desc "Telescope buffers"})

(vim.keymap.set :n :<leader>fw fzf_cmd.lsp_workspace_symbols
                {:desc "Telescope buffers"})

(vim.keymap.set :n :<leader>fi fzf_cmd.lsp_implementations
                {:desc "Telescope buffers"})

; ===================================neotree=========================================
(vim.pack.add [;; Neotree itself
               {:src "https://github.com/nvim-neo-tree/neo-tree.nvim"
                :branch :v3.x}
               ;; Core dependencies
               {:src "https://github.com/nvim-lua/plenary.nvim"}
               {:src "https://github.com/nvim-tree/nvim-web-devicons"}
               {:src "https://github.com/MunifTanjim/nui.nvim"}])

(let [neotree (require :neo-tree)]
  (neotree.setup {:enable_git_status true
                  :enable_diagnostics true
                  :defaults_components_configs {:indent {:with_markers true
                                                         :indent_marker "│"
                                                         :last_indent_marker "└"
                                                         :indent_size 3}
                                                :icon {:folder_closed ""
                                                       :folder_open ""
                                                       :folder_empty "󰜌"
                                                       :provider (fn [icon
                                                                      node
                                                                      state]
                                                                   "default icon provider utilizes nvim-web-devicons if available"
                                                                   (if (or (= node.type
                                                                              :file)
                                                                           (= node.type
                                                                              :terminal))
                                                                       (let [(success web_devicons) (pcall require
                                                                                                           :nvim-web-devicons)
                                                                             name (if (= node.type
                                                                                         :terminal)
                                                                                      :terminal
                                                                                      node.name)]
                                                                         (if success
                                                                             (let [(devicon hl) (web_devicons.get_icon name)]
                                                                               (set icon.text
                                                                                    (or devicon
                                                                                        icon.text))
                                                                               (set icon.highlight
                                                                                    (or hl
                                                                                        icon.highlight)))))))
                                                       ;; The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
                                                       ;; then these will never be used.
                                                       :default "*"
                                                       :highlight :NeoTreeFileIcon}}
                  :filesystem {:filtered_items {:visible false
                                                ;; :hide_dotfiles false
                                                ;; :hide_hidden false
                                                }}
                  :window {:position :float
                           :mappings {:p {1 :toggle_preview
                                          :config {:use_float true
                                                   :use_image_nvim true}}
                                      :P {1 :paste_from_clipboard}
                                      :<Tab> {1 :toggle_node}}}}))

;; (vim.keymap.set :n "<leader>ee" ":Neotree float<CR>") ;; open as float window
(vim.keymap.set :n :<leader>ee ":Neotree reveal<cr>"
                {:desc "Open Neo-tree reveal"})

; ===================================ui2=========================================
(: (require :vim._core.ui2) :enable
   {:enable true
    :msg {:targets :msg
          :cmd {; Options related to messages in the cmdline window.
                :height 0.5
                ; Maximum height while expanded for messages beyond 'cmdheight'.
                }
          :dialog {; Options related to dialog window.
                   :height 0.5
                   ; Maximum height.
                   }
          :msg {; Options related to msg window.
                :height 0.5
                ; Maximum height.
                :timeout 4000
                ; Time a message is visible in the message window.
                }
          :pager {; Options related to message window.
                  :height 1
                  ; Maximum height.
                  }}})

; ================================persisted======================================
(vim.pack.add [{:src "https://github.com/olimorris/persisted.nvim.git"
                :confirm false}])

(let [persisted (require :persisted)]
  (persisted:setup {:autostart true
                    ; automatically start the plugin on load
                    :autoload true
                    ; automatically load the session for he cwd on neovim startup
                    :config true
                    :save_dir (vim.fn.expand (.. (vim.fn.stdpath :data)
                                                 :/sessions/))
                    :follow_cwd true
                    :use_git_branch true}))

(values)

