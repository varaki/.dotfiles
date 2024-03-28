return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- Setup mason
    local mason = require("mason")
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    -- Setup mason-lspconfig
    local servers = {
      -- bash
      bashls = {},

      -- docker
      dockerls = {},

      -- go
      gopls = {},

      -- html
      html = {},

      -- json
      jsonls = {},

      -- perl
      perlnavigator = {},

      -- xml
      lemminx = {},

      -- lua
      lua_ls = {
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            checkThirdParty = false,
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
          telemetry = { enable = false },
          -- let stylua with null-ls do the formatting
          format = { enable = false },
        },
      },

      -- markdown
      marksman = {},

      -- python
      pyright = {
        python = {
          analysis = {
            typeCheckingMode = "off",
          },
        },
      },

      -- toml
      taplo = {},

      -- yaml
      yamlls = {},
    }

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
    local mason_lspconfig = require("mason-lspconfig")
    mason_lspconfig.setup({
      ensure_installed = vim.tbl_keys(servers),
    })

    mason_lspconfig.setup_handlers({
      function(server_name)
        require("lspconfig")[server_name].setup({
          capabilities = capabilities,
          settings = servers[server_name],
          filetypes = (servers[server_name] or {}).filetypes,
        })
      end,
    })

    -- Setup mason-tool-installer
    local mason_tool_installer = require("mason-tool-installer")
    mason_tool_installer.setup({
      ensure_installed = {
        "prettier", -- generic formatter for multiple filetypes
        "shfmt", -- shell formatter
        "stylua", -- lua formatter
        "isort", -- python formatter
        "black", -- python formatter
      },
    })

    -- Keybindings
    local options = { noremap = true, silent = true }
    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, options)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, options)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, options)
    vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, options)

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, options)
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, options)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, options)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, options)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, options)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, options)
    vim.keymap.set("n", "<leader>ds", vim.lsp.buf.signature_help, options)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, options)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, options)
  end,
}
