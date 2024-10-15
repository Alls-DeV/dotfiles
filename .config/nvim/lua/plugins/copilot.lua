return {
    "github/copilot.vim",
    config = function()
        -- Disable Copilot for all filetypes by default
        vim.g.copilot_filetypes = {
            ["*"] = false,
        }

        vim.api.nvim_set_keymap('i', '<M-;>', '<Plug>(copilot-suggest)', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('i', '<M-]>', '<Plug>(copilot-next)', { noremap = true, silent = true })
    end
}

