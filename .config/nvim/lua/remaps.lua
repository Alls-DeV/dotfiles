vim.api.nvim_set_keymap('v', '<leader>y', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>s', ':s/\\<<C-r><C-w>\\>//gc<Left><Left><Left>', { noremap = true, silent = false })

vim.api.nvim_set_keymap('n', 'x', '"_x', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'x', '"_x', { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

vim.api.nvim_set_keymap('n', '<Tab>', ':bn<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-Tab>', ':bp<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>q', ':bd!<CR>', { noremap = true, silent = true })
