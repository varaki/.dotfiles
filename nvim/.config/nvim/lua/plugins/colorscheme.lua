return {
  -- Gruvbox colorscheme
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = function()
    local gruvbox = require("gruvbox")
    gruvbox.setup({
      terminal_colors = true, -- add neovim terminal colors
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = false,
        emphasis = false,
        comments = false,
        operators = false,
        folds = false,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = true, -- invert background for search, diffs, statuslines and errors
      contrast = "", -- can be "hard", "soft" or empty string
      palette_overrides = {},
      overrides = {
        Normal = { bg = "none" },
        SignColumn = { bg = "none" },
        -- NormalFloat = { bg = "none" },
      },
      dim_inactive = false,
      transparent_mode = false,
    })

    -- Set colorscheme
    vim.o.background = "dark"
    vim.cmd([[colorscheme gruvbox]])
  end,
}
