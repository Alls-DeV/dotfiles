return { 
	{
		"ellisonleao/gruvbox.nvim",
	},
	{
		"neanias/everforest-nvim",
		config = function()
			require("everforest").setup({
				background = "hard",
				italics = true,
			})
			vim.opt.background = "dark"
			vim.cmd.colorscheme("everforest")
		end,
	}
}
