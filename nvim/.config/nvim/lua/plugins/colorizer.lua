return {
  "NvChad/nvim-colorizer.lua",
  config = function()
    local colorizer = require("colorizer")
    colorizer.setup({
      user_default_options = {
        rgb_fn = true,
        buftypes = {
          "*",
          -- exclude prompt and popup buftypes from highlight
          "!prompt",
          "!popup",
        },
      },
    })
  end,
}
