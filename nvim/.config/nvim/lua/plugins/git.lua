return {
    {
        "tpope/vim-fugitive",
    },

    {
        -- Adds git related signs to the gutter, as well as utilities for managing changes
        "lewis6991/gitsigns.nvim",
        opts = {
            -- See `:help gitsigns.txt`
            signs                   = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol", -- "eol" | "overlay" | "right_align"
                delay = 500,
                ignore_whitespace = false,
            },
            on_attach               = function(bufnr)
                -- Keybindings
                local gs = package.loaded.gitsigns
                vim.keymap.set("n", "<leader>hp", gs.preview_hunk)
                vim.keymap.set({ "n", "v" }, "<leader>hs", gs.stage_hunk)
                vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk)
                vim.keymap.set({ "n", "v" }, "<leader>hr", gs.reset_hunk)
                vim.keymap.set({ "o", "x" }, "ih", gs.select_hunk)
                vim.keymap.set("n", "<leader>hS", gs.stage_buffer)
                vim.keymap.set("n", "<leader>hR", gs.reset_buffer)
                vim.keymap.set("n", "<leader>lb", gs.blame_line)
                vim.keymap.set("n", "<leader>tb", gs.toggle_current_line_blame)
                vim.keymap.set("n", "<leader>td", gs.toggle_deleted)
                vim.keymap.set("n", "<leader>hd", gs.diffthis)

                vim.keymap.set({ "n", "v" }, "]c", function()
                    if vim.wo.diff then
                        return "]c"
                    end
                    vim.schedule(function()
                        gs.next_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
                vim.keymap.set({ "n", "v" }, "[c", function()
                    if vim.wo.diff then
                        return "[c"
                    end
                    vim.schedule(function()
                        gs.prev_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })
            end,
        },
    },

}
