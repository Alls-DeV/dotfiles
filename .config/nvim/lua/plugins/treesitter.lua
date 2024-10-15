return {
	"nvim-treesitter/nvim-treesitter",
	build = ':TSUpdate',
	main = 'nvim-treesitter.configs',
	config = function()
		vim.opt.modeline = false
		vim.wo.foldmethod = 'expr'
		vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
		vim.wo.foldenable = false
		---@diagnostic disable-next-line
		require("nvim-treesitter.configs").setup({
			ensure_installed = { 'bash', 'c', 'cpp', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
