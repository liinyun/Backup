(local OSName (. (vim.uv.os_uname) :sysname))

(vim.pack.add [{:src "https://github.com/folke/lazydev.nvim.git"
                :confirm false}])

(: (require :lazydev) :setup
   {:library [; Library paths can be absolute
              ; "~/projects/my-awesome-lib",
              ; Or relative, which means they will be resolved from the plugin dir.
              :lazy.nvim
              ; It can also be a table with trigger words / mods
              ; Only load luvit types when the `vim.uv` word is found
              {:path "${3rd}/luv/library" :words ["vim%.uv"]}
              ; always load the LazyVim library
              ; "LazyVim",
              ; Only load the lazyvim library when the `LazyVim` global is found
              ; { path = "LazyVim", words = { "LazyVim" } },
              ; Load the wezterm types when the `wezterm` module is required
              ; Needs `justinsgithub/wezterm-types` to be installed
              {:path :wezterm-types :mods [:wezterm]}
              ; Load the xmake types when opening file named `xmake.lua`
              ; Needs `LelouchHe/xmake-luals-addon` to be installed
              {:path :xmake-luals-addon/library :files [:xmake.lua]}]
    ; always enable unless `vim.g.lazydev_enabled = false`
    ; This is the default
    ; enabled = function(root_dir)
    ;   return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
    ; end,
    ; disable when a .luarc.json file is found
    :enabled (fn [root_dir]
               (not (vim.uv.fs_stat (.. root_dir :/.luarc.json))))})

(vim.pack.add [{:src "https://github.com/rafamadriz/friendly-snippets.git"
                :confirm false}])

(vim.pack.add [{:src "https://github.com/Kaiser-Yang/blink-cmp-dictionary.git"
                :confirm false}])

(vim.pack.add [{:src "https://github.com/L3MON4D3/LuaSnip.git" :confirm false}])

(let [luasnip (require :luasnip)
      ft_funcs (require :luasnip.extras.filetype_functions)]
  (-> (require :luasnip.loaders.from_vscode) (: :lazy_load {}))
  (vim.keymap.set [:i :s] :<c-n> (fn [] (luasnip.jump 1)) {:silent true})
  (vim.keymap.set [:i :s] :<c-p>
                  (fn [] ((luasnip.jump -1))
                    {:silent true})
                  (luasnip.setup {:load_ft_func (ft_funcs.extend_load_ft {:htmldjango [:html]})}))
  ; ===================================blink===========================================
  (vim.pack.add [{:src "https://github.com/saghen/blink.cmp.git"
                  :version :v1.10.2
                  :confirm false}])
  (let [blink (require :blink.cmp)]
    (blink.setup {:keymap {:preset :none
                           :<Up> [:select_prev :fallback]
                           :<Down> [:select_next :fallback]
                           :<tab> [:select_next :fallback]
                           :<C-k> [:select_prev :fallback]
                           :<C-j> [:select_next :fallback]
                           :<CR> [:accept :fallback]
                           :<c-n> [:snippet_forward :fallback]
                           :<c-p> [:snippet_backward :fallback]
                           :<c-tab> [:show]}
                  :appearance {; :highlight_ns [(vim.api.nvim_create_namespace "blink_cmp")]
                               ; Sets the fallback highlight groups to nvim-cmp's highlight groups
                               ; Useful for when your theme doesn't support blink.cmp
                               ; Will be removed in a future release
                               :use_nvim_cmp_as_default false
                               ; Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                               ; Adjusts spacing to ensure icons are aligned
                               :nerd_font_variant :mono
                               :kind_icons {:Text "  "
                                            :Method "  "
                                            :Function "  "
                                            :Constructor "  "
                                            :Field "  "
                                            :Variable "  "
                                            :Class "  "
                                            :Interface "  "
                                            :Module "  "
                                            :Property "  "
                                            :Unit "  "
                                            :Value "  "
                                            :Enum "  "
                                            :Keyword "  "
                                            :Snippet "  "
                                            :Color "  "
                                            :File "  "
                                            :Reference "  "
                                            :Folder "  "
                                            :EnumMember "  "
                                            :Constant "  "
                                            :Struct "  "
                                            :Event "  "
                                            :Operator "  "
                                            :TypeParameter "  "}}
                  :completion {:keyword {:range :full}
                               :documentation {:auto_show true}
                               :list {:selection {:preselect true
                                                  :auto_insert false}}
                               :menu {:auto_show true
                                      :draw {:columns [{1 :label
                                                        2 :label_description
                                                        :gap 1}
                                                       [:kind_icon :kind]]}}
                               :ghost_text {:enabled true
                                            ; Show the ghost text when an item has been selected
                                            ; show_with_selection = true,
                                            ; Show the ghost text when no item has been selected, defaulting to the first item
                                            :show_without_selection false
                                            ; Show the ghost text when the menu is open
                                            :show_with_menu true
                                            ; Show the ghost text when the menu is closed
                                            :show_without_menu true}}
                  :snippets {:preset :luasnip}
                  :sources {:default (if (or (= OSName :Linux)
                                             (= OSName :Windows_NT))
                                         [:lsp
                                          :path
                                          :snippets
                                          :lazydev
                                          :buffer
                                          :dictionary]
                                         [:lsp
                                          :path
                                          :snippets
                                          :lazydev
                                          :buffer])
                            :providers {:lsp {:score_offset 100}
                                        :lazydev {:name :LazyDev
                                                  :module :lazydev.integrations.blink
                                                  ; make lazydev completions top priority (see `:h blink.cmp`)
                                                  :score_offset 80}
                                        :dictionary (if (or (= OSName :Linux)
                                                            (= OSName
                                                               :Windows_NT))
                                                        {:module :blink-cmp-dictionary
                                                         :name :Dict
                                                         :score_offset 10
                                                         ; Make sure this is at least 2.
                                                         ; 3 is recommended
                                                         :min_keyword_length 3
                                                         :opts {; options for blink-cmp-dictionary
                                                                :dictionary_files [(vim.fn.expand "~/.config/fenvim/dictionary/words.txt")]
                                                                :dictionary_directories [(vim.fn.expand "~/.config/fennvim/dictionary")]}}
                                                        [nil]
                                                        ;Set to nil or an empty table to effectively comment it out/disable it
                                                        )
                                        :path {:score_offset 120}
                                        :snippets {:score_offset 80}
                                        :buffer {:score_offset 80}}}
                  :fuzzy {:implementation :prefer_rust_with_warning}})))

(values)

