return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = ":call mkdp#util#install()",
  -- This does not work:
  -- build = function()
  --   vim.fn["mkdp#util#install"]()
  -- end,
}
