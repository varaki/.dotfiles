return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        -- Lua
        null_ls.builtins.formatting.stylua.with({
          extra_args = {
            "--indent-type",
            "Spaces",
            "--indent-width",
            "2",
          },
        }),

        -- Shell
        null_ls.builtins.formatting.shfmt.with({
          extra_args = {
            "--indent",
            "4",
            "--case-indent",
          },
        }),
        null_ls.builtins.formatting.beautysh.with({
          extra_args = {
            "--indent-size",
            "4",
          },
        }),

        -- Prettier (html, json, yaml, markdown, toml)
        null_ls.builtins.formatting.prettier.with({
          filetypes = { "html", "json", "yaml", "markdown" },
          extra_filetypes = { "toml" },
        }),

        -- Python
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.black.with({
          extra_args = {
            "--line-length=120",
            "--skip-string-normalization",
          },
        }),
      },
    })

    -- Keybindings
    local options = { noremap = true, silent = true }
    vim.keymap.set("n", "FF", function()
      vim.lsp.buf.format({ async = true })
    end, options)
  end,
}
