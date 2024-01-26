return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local nvim_tree = require("nvim-tree")
    nvim_tree.setup({
      hijack_cursor = true,
      filters = {
        dotfiles = true,
        custom = {},
        exclude = {},
      },
      view = {
        adaptive_size = true,
      },
    })

    -- Keybindings
    local options = { noremap = true, silent = true }
    vim.keymap.set("n", "<leader>n", ":NvimTreeToggle<CR>", options)
    vim.keymap.set("n", "<leader>f", ":NvimTreeFocus<CR>", options)
  end,
}
