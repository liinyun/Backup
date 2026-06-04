(vim.pack.add [{:src "https://github.com/nvim-treesitter/nvim-treesitter.git" :confirm false } ] ) 

(let [treesitter (require :nvim-treesitter)] 
  (treesitter.install [:fennel]))

(vim.api.nvim_create_autocmd :FileType
  {:pattern :fennel
   :callback #(vim.treesitter.start nil :fennel)})

