return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {},
	config = function()
		vim.cmd("colorscheme tokyonight-night")
	end,
}
-- return {
-- 	"rebelot/kanagawa.nvim",
-- 	config = function()
-- 		vim.cmd("colorscheme kanagawa-dragon")
-- 	end,
-- }
-- return {
-- 	"ellisonleao/gruvbox.nvim",
-- 	priority = 1000,
-- 	config = function()
-- 		vim.cmd("colorscheme gruvbox")
-- 	end,
-- }
-- return {
-- 	"loctvl842/monokai-pro.nvim",
-- 	config = function()
-- 		require("monokai-pro").setup()
-- 		vim.cmd("colorscheme monokai-pro")
-- 	end,
-- }
