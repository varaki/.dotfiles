-- Disable builtins
-- vim.g.loaded_gzip = 1
-- vim.g.loaded_zip = 1
-- vim.g.loaded_zipPlugin = 1
-- vim.g.loaded_tar = 1
-- vim.g.loaded_tarPlugin = 1

vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1

vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1

vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0

-- Use utf-8 encoding
vim.g.encoding = "utf-8"

-- Set space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Automatically read changed files
vim.opt.autoread = true

-- Use system clipboard
vim.opt.clipboard = "unnamedplus"

-- Enable mouse
vim.opt.mouse = "a"

-- Show numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Show whitespace
vim.opt.list = true
-- vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "eol:↴"

-- Disable errorbells
vim.opt.errorbells = false

-- Set tabstops
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Enable smartindent
vim.opt.smartindent = true

-- Every wrapped line will continue visually indented (same amount of space as the beginning of that line)
vim.opt.breakindent = true

-- Enable text wrap
vim.opt.wrap = true

-- Disable backup (.swp) file creation
vim.opt.swapfile = false
vim.opt.backup = false

-- Search options
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Window management
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Enable gui colors
vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime = 50

-- Don't pass messages to |ins-completion-menu|.
vim.opt.shortmess:append("c")

-- Completion
vim.opt.completeopt = { "menuone", "noselect" }

-- Folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false
