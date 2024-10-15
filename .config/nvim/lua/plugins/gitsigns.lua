return {
	'lewis6991/gitsigns.nvim',
	config = function()
		require('gitsigns').setup{
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
			},
			on_attach = function(bufnr)
				local gitsigns = require('gitsigns')

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map('n', ']g', function()
					if vim.wo.diff then
						vim.cmd.normal({']c', bang = true})
					else
						gitsigns.nav_hunk('next')
					end
				end)

				map('n', '[g', function()
					if vim.wo.diff then
						vim.cmd.normal({'[c', bang = true})
					else
						gitsigns.nav_hunk('prev')
					end
				end)

				-- Actions
				map('n', '<leader>gr', gitsigns.reset_hunk)
				map('n', '<leader>gp', gitsigns.preview_hunk)
				map('n', '<leader>gb', function() gitsigns.blame_line{full=true} end)
				map('n', '<leader>gd', gitsigns.diffthis)
				map('n', '<leader>gD', function() gitsigns.diffthis('~') end)
			end
		}
	end,
}
