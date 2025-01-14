-- [[ OPTIONS ]] --
require("options")

-- [[ PACKAGE MANAGER ]] --
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- [[ PLUGINS ]] --
require("lazy").setup({
  -- Import plugins
  { import = "plugins" },
  { import = "plugins.lsp" },
  { import = "plugins.ai" },
}, {
  -- Plugin manager options
  install = {
    colorscheme = { "gruvbox" },
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})

-- [[ KEYBINDINGS ]] --
require("keybindings")
