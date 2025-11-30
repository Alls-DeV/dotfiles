local colors = require("solarized-osaka.colors").setup({ transform = true })

local diagnostic_icons = {
	ERROR = " ",
	WARN = " ",
	HINT = " ",
	INFO = " ",
}

local custom_solarized_osaka = require 'lualine.themes.solarized-osaka'
custom_solarized_osaka.normal.a.bg = colors.cyan
custom_solarized_osaka.inactive.a.fg = colors.cyan

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	config = function()
		require("lualine").setup({
			options = {
                theme = custom_solarized_osaka,
				icons_enabled = true,
				ignore_focus = {},
				globalstatus = false,
				refresh = {
					statusline = 1,
					tabline = 1,
				},
				component_separators = "",
				section_separators = "",
			},

			sections = {
				lualine_a = {
					{ "filename", path = 1 },
				},
				lualine_b = {},
				lualine_c = {
					{
						"diagnostics",
						symbols = {
							error = diagnostic_icons.ERROR,
							warn = diagnostic_icons.WARN,
							info = diagnostic_icons.INFO,
							hint = diagnostic_icons.HINT,
						},
					},
				},
				lualine_x = {
					"diff",
				},
				lualine_y = {
					{ "branch" },
				},
				lualine_z = {
					{ "location", icon = "" },
				},
			},
			inactive_sections = {
				lualine_a = { { "filename", path = 1 } },
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {
				lualine_a = { "buffers" },
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			extensions = {},
		})
	end,
}
