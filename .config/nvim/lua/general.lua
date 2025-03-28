vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.matchpairs:append("<:>")
vim.opt.hlsearch = true
vim.opt.swapfile = false
vim.opt.scrolloff = 8
vim.opt.showmode = false
vim.api.nvim_create_autocmd('TextYankPost', { callback = function() vim.highlight.on_yank() end, })
