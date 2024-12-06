return { 
	-- {
		-- "ellisonleao/gruvbox.nvim",
		-- config = function()
		-- 	require("gruvbox").setup({})
		-- 	vim.opt.background = "dark"
		-- 	vim.cmd.colorscheme("gruvbox")
		-- end,
	-- },
	-- {
	-- 	"neanias/everforest-nvim",
	-- 	config = function()
	-- 		require("everforest").setup({
	-- 			background = "hard"
	-- 		})
	-- 		vim.opt.background = "dark"
	-- 		vim.cmd.colorscheme("everforest")
	-- 	end,
	-- },
	{
		"folke/tokyonight.nvim",
		config = function()
			vim.cmd.colorscheme("tokyonight-night")
		end,
	}
}
