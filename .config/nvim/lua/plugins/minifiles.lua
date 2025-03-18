return {
	'echasnovski/mini.files',
	version = '*',
	config = function()
		local map = vim.keymap.set
		require("mini.files").setup({
			options = {
				permanent_delete = false,
				use_as_default_explorer = true,
			},
			mappings = {
				close       = 'q',
				go_in       = 'l',
				go_in_plus  = '',
				go_out      = 'h',
				go_out_plus = '',
				mark_goto   = "",
				mark_set    = '',
				reset       = '',
				reveal_cwd  = '',
				show_help   = 'g?',
				synchronize = '=',
				trim_left   = '<',
				trim_right  = '>',
			},
			windows = {
				preview = true,
				width_preview = 55
			},
		})

		map(
			"n",
			"<leader>et",
			":e ~/.local/share/nvim/mini.files/trash/<cr>",
			{ desc = "MiniFiles Trash", noremap = true, silent = true }
		)
		map("n", "<leader>b", ":lua MiniFiles.open()<cr>", { desc = "MiniFiles Open", noremap = true, silent = false })
	end,
}
