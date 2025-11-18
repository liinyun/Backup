local markdown_config = {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = function() vim.fn["mkdp#util#install"]() end,
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
    vim.g.mkdp_browser = 'wyeb'
    vim.g.mkdp_preview_title = '${name}'
  end,
  ft = { "markdown" },
}

return markdown_config
