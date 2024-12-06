return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "<Leader>t", "<cmd>lua require('nvim-tree.api').tree.toggle()<CR>", desc = "NvimTree" },
	},
	config = function()
		require("nvim-tree").setup {}
	end,
}
