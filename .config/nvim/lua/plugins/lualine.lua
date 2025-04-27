local diagnostic_icons = {
	ERROR = " ",
	WARN = " ",
	HINT = " ",
	INFO = " ",
}

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- Custom Lualine component to show attached language server
		local clients_lsp = function()
			local bufnr = vim.api.nvim_get_current_buf()

			local clients = vim.lsp.get_clients()
			if next(clients) == nil then
				return ""
			end

			local c = {}
			for _, client in pairs(clients) do
				table.insert(c, client.name)
			end
			return " " .. table.concat(c, "|")
		end

		local custom_theme = require("lualine.themes.auto")
		custom_theme.normal.c.bg = "#181616"

		require("lualine").setup({
			options = {
				theme = custom_theme,
				icons_enabled = true,
				ignore_focus = {},
				globalstatus = false,
				refresh = {
					statusline = 1,
					tabline = 1,
				},
				component_separators = "",
				section_separators = { left = "", right = "" },
			},

			sections = {
				lualine_a = {
					{ "filename", path = 1, separator = { right = "", left = "" } },
				},
				lualine_b = {
					{ "branch" },
				},
				lualine_c = {
					{
						"diff",
						symbols = { added = "+", modified = "~", removed = "-" },
					},
				},
				lualine_x = {
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
				lualine_y = { { clients_lsp, separator = { left = "" } } },
				lualine_z = {
					{ "location", separator = { left = "", right = " " }, icon = "" },
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
