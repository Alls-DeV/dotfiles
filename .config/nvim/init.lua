-- minimal vim
-- set ts=4 sw=4 ai cul nu rnu mps+=<:> hls noswf so=8
-- let mapleader=" "
-- vnoremap <leader>y "+y
-- nnoremap <leader>s :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>
-- vnoremap > >gv
-- vnoremap < <gv
-- nnoremap x "_x
-- vnoremap x "_x
-- nnoremap <Tab> :bn<CR>
-- nnoremap <S-Tab> :bp<CR>
-- nnoremap <leader>q :bd<CR>
-- autocmd TextChanged,TextChangedI * silent! write


-- minimal neovim
-- vim.opt.tabstop = 4
-- vim.opt.shiftwidth = 4
-- vim.opt.autoindent = true
-- vim.opt.cursorline = true
-- vim.opt.number = true
-- vim.opt.relativenumber = true
-- vim.opt.matchpairs:append("<:>")
-- vim.opt.hlsearch = true
-- vim.opt.swapfile = false
-- vim.opt.scrolloff = 8
-- vim.cmd([[colorscheme habamax]])
-- vim.g.mapleader = " "
-- vim.api.nvim_set_keymap('v', '<leader>y', '"+y', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>s', ':%s/\\<<C-r><C-w>\\>//gc<Left><Left><Left>', { noremap = true, silent = false })
-- vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', 'x', '"_x', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('v', 'x', '"_x', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<Tab>', ':bn<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<S-Tab>', ':bp<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>q', ':bd<CR>', { noremap = true, silent = true })
-- vim.api.nvim_create_autocmd({'TextChanged', 'TextChangedI'}, { pattern = '*', command = 'silent! write' })


require("general")
require("remaps") 
require("config.lazy")
