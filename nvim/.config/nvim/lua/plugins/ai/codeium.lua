return {
  "Exafunction/codeium.vim",
  tag = "1.8.80",
  config = function()
    -- Change '<C-g>' here to any keycode you like.
    vim.keymap.set("i", "<TAB>", function() return vim.fn["codeium#Accept"]() end, { expr = true, silent = true })
    vim.keymap.set("i", "<c-;>", function() return vim.fn["codeium#CycleCompletions"](1) end, { expr = true, silent = true })
    vim.keymap.set("i", "<c-,>", function() return vim.fn["codeium#CycleCompletions"](-1) end, { expr = true, silent = true })
    vim.keymap.set("i", "<c-x>", function() return vim.fn["codeium#Clear"]() end, { expr = true, silent = true })

    -- Set server config
    vim.cmd([[
            let g:codeium_server_config = {
                \ 'portal_url': 'https://codingbuddy.onprem.gic.ericsson.se',
                \ 'api_url': 'https://codingbuddy.onprem.gic.ericsson.se/_route/api_server',
            \ }
        ]])
    vim.cmd([[let g:codeium_enabled = v:true]])
  end,
}
