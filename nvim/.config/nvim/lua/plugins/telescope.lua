return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
  },
  config = function()
    local telescope = require("telescope")
    local telescope_actions = require("telescope.actions")
    telescope.setup({
      defaults = {
        file_ignore_patterns = {
          "^.git/",
          "^.local/share/nvim",
        },
        mappings = {
          i = {
            ["<esc>"] = telescope_actions.close,
            ["<C-Down>"] = telescope_actions.cycle_history_next,
            ["<C-Up>"] = telescope_actions.cycle_history_prev,
          },
        },
        prompt_prefix = "   ",
      },
    })

    -- Keybindings
    local telescope_builtin = require("telescope.builtin")
    local options = { noremap = true, silent = true }
    vim.keymap.set("n", "ff", function()
      telescope_builtin.find_files({ hidden = true })
    end, options)
    vim.keymap.set("n", "fg", function()
      telescope_builtin.live_grep({
        additional_args = function()
          return { "--hidden" }
        end,
      })
    end, options)
    vim.keymap.set("n", "fd", telescope_builtin.diagnostics, options)
    vim.keymap.set("n", "fb", telescope_builtin.buffers, options)
    vim.keymap.set("n", "fh", telescope_builtin.help_tags, options)
  end,
}
