-- I move it from common to lsp group for it does not provide lsp detect for coc
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  config = function()
    require("neo-tree").setup({
      enable_git_status = true,
      enable_diagnostics = true,
      defaults_components_configs = {
        indent = {
          with_markers = true,
          indent_marker = "│",
          last_indent_marker = "└",
          indent_size = 3,
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "󰜌",
          provider = function(icon, node, state) -- default icon provider utilizes nvim-web-devicons if available
            if node.type == "file" or node.type == "terminal" then
              local success, web_devicons = pcall(require, "nvim-web-devicons")
              local name = node.type == "terminal" and "terminal" or node.name
              if success then
                local devicon, hl = web_devicons.get_icon(name)
                icon.text = devicon or icon.text
                icon.highlight = hl or icon.highlight
              end
            end
          end,
          -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
          -- then these will never be used.
          default = "*",
          highlight = "NeoTreeFileIcon",
        },
      },

      filesystem = {
        filtered_items = {
          visible = false,
          -- hide_dotfiles = false,
          -- hide_hidden = false,
        },
      },
      window = {
        position = "float",
        -- position = "left",
        mappings = {
          ["p"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
          ["P"] = { "paste_from_clipboard" },
          ["<Tab>"] = { "toggle_node" },
        },
      },
    })
    -- vim.keymap.set('n', '<leader>ee', ':Neotree float<CR>') -- open as float window
    vim.keymap.set("n", "<leader>ee", ":Neotree reveal<cr>") -- open as float window
  end,
}
