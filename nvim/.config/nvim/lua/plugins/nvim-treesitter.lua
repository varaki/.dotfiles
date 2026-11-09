return {
  "nvim-treesitter/nvim-treesitter",
  -- Pin to the legacy `master` branch. The new default `main` branch is a full,
  -- incompatible rewrite that removed the `nvim-treesitter.configs` module and
  -- the `.setup()` API used below, and it requires Neovim 0.12+ (nightly).
  -- `master` is locked but kept for backward compatibility with Neovim 0.11.
  branch = "master",
  dependencies = {
    { "nvim-treesitter/nvim-treesitter-textobjects", branch = "master" },
  },
  build = ":TSUpdate",
  config = function()
    vim.defer_fn(function()
      require("nvim-treesitter.install").compilers = { "gcc" }
      require("nvim-treesitter.configs").setup({
        -- Add languages to be installed here that you want installed for treesitter
        ensure_installed = {
          "bash",
          "c",
          "comment",
          "cpp",
          "css",
          "dockerfile",
          "gitattributes",
          "go",
          "gomod",
          "gowork",
          "graphql",
          "html",
          "http",
          "java",
          "javascript",
          "jsdoc",
          "json",
          "json5",
          "jsonnet",
          "kotlin",
          "lua",
          "markdown",
          "markdown_inline",
          "perl",
          "php",
          "python",
          "regex",
          "sql",
          "toml",
          "vim",
          "vimdoc",
          "yaml",
        },

        -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
        auto_install = false,

        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
              ["<leader>A"] = "@parameter.inner",
            },
          },
        },
      })
    end, 0)
  end,
}
