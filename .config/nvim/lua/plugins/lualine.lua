return {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		local copilot = require("plugins.components.copilot_status")
		require('lualine').setup {
			options = {
				icons_enabled = true,
				ignore_focus = {},
				globalstatus = false,
				refresh = {
					statusline = 1
				},
				component_separators = '',
				section_separators = '',
			},
			sections = {
				lualine_a = {
					{'filename', path = 1, separator = {right = ''}},
				},
				lualine_b = {
					{'diff', symbols = {added = '+', modified = '~', removed = '-'}, separator = {right = ''}},
					{'branch', separator = {right = ''}},
				},
				lualine_c = {
					'diagnostics',
				},
				lualine_x = {
					{
						require("noice").api.status.mode.get,
						cond = require("noice").api.status.mode.has,
					},
					{
						require("noice").api.status.search.get,
						cond = require("noice").api.status.search.has,
					},
					{
						require("noice").api.status.command.get,
						cond = require("noice").api.status.command.has,
					},
				},
				lualine_y = {
					{copilot.copilot_status, separator = {left = ''}},
					{'location', separator = {left = ''}},
				},
				lualine_z = {
					{'progress', separator = {left = ''}},
				}
			},
			inactive_sections = {
				lualine_a = {{'filename', path = 1}},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {}
			},
			extensions = {}
		}
	end,
}
