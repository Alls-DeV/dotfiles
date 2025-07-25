return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-symbols.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			require("telescope").setup({
				defaults = {
					layout_strategy = "vertical",
				},
			})

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set(
				"n",
				"<leader>sd",
				":Telescope diagnostics bufnr=0<CR>",
				{ desc = "[S]earch [d]iagnostics in actual buffer" }
			)
			vim.keymap.set(
				"n",
				"<leader>sD",
				builtin.diagnostics,
				{ desc = "[S]earch [D]iagnostics in the entire workspace" }
			)
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sc", function()
				builtin.find_files({
					prompt_title = "Neovim Config",
					search_dirs = { vim.fn.expand("~/.config/nvim") },
				})
			end, { desc = "[S]earch neovim [C]onfig files" })
		end,
	},
}
