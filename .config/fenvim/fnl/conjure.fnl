(vim.pack.add [{:src "https://github.com/Olical/conjure.git" :confirm false } ] ) 
(local {: autoload} (require :conjure.nfnl.module))
(local a (autoload :conjure.aniseed.core))
(local str (autoload :conjure.aniseed.string))
(local stdio (autoload :conjure.remote.stdio))
(local config (autoload :conjure.config))
(local mapping (autoload :conjure.mapping))
(local client (autoload :conjure.client))
(local log (autoload :conjure.log))
(local ts (autoload :conjure.tree-sitter))


(set (. vim.g "conjure#mapping#doc_word") "K")
(config.merge
  {:client
   {:scheme
    {:stdio
     {:command "petite"
      :prompt_pattern "> $?"
     }
    }
    :fennel     
 {:stdio
     {:command "fennel"
      :prompt_pattern "> $?"
      :aliases ["fnl" "fennel"]}}
   }
  }
)






















