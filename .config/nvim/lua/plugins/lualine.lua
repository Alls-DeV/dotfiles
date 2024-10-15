return {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		require('lualine').setup {
			options = {
				icons_enabled = true,
				ignore_focus = {},
				globalstatus = false,
				refresh = {
					statusline = 1,
					tabline = 1000,
					winbar = 1000,
				},
				component_separators = "",
    			section_separators = "",
				disabled_filetypes = {
				  statusline = { 'terminal' },
				  winbar = { 'terminal' },
				},
			},
			sections = {
				lualine_a = {{'filename', path = 1, separator = {left = '▒▓', right = '▓▒░'}}},
				lualine_b = {
				  {'branch', separator = {right = '▓▒░'}},
				  -- {'diff', symbols = {added = ' ', modified = ' ', removed = ' '}, separator = {right = '▓▒░'}},
				  {'diff', symbols = {added = '+', modified = '~', removed = '-'}, separator = {right = '▓▒░'}},
				},
    			lualine_c = {'diagnostics'},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {{'progress', separator = {left = '░▒▓'}}}
			},
			inactive_sections = {
				lualine_a = {{'filename', path = 1}},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {}
			},
			tabline = {
  				lualine_a = {},
  				lualine_b = {'buffers'},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {}
			}
		}
	end,
}
