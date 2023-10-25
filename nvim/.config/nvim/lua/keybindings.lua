local options = { noremap = true, silent = true, }

-- Keymaps for better default experience
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Preserve cursor position while joining lines
vim.keymap.set('n', 'J', 'mzJ`z')

-- Remove trailing whitespaces
vim.keymap.set('n', '<leader>ws', ':%s/\\s\\+$//e<CR>', options)

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({
            timeout = 200,
        })
    end,
    group = highlight_group,
    pattern = "*",
})
