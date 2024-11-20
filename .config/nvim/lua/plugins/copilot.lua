return {
    "github/copilot.vim",
    config = function()
        vim.g.copilot_filetypes = {
            ["*"] = true
        }
        vim.g.copilot_on = true
        local function toggle_copilot()
            if vim.g.copilot_on then
                vim.cmd('Copilot disable')
                vim.g.copilot_on = false
                print("Copilot Disabled")
            else
                vim.cmd('Copilot enable')
                vim.g.copilot_on = true
                print("Copilot Enabled")
            end
            if vim.fn.exists(':LualineRefresh') == 2 then
                vim.cmd('LualineRefresh')
            else
                require('lualine').refresh()
            end
        end
        vim.keymap.set('n', '<M-;>', toggle_copilot, { noremap = true, silent = true })
        vim.keymap.set('i', '<M-;>', toggle_copilot, { noremap = true, silent = true })
        vim.keymap.set('i', '<M-]>', '<Plug>(copilot-next)', { noremap = true, silent = true })
    end
}

