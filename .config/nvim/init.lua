-- ///////////////
-- //  OPTIONS  //
-- ///////////////
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.breakindent = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.cursorline = true

-- Store undos between sessions
vim.opt.undofile = true

vim.opt.mouse = "a"

vim.opt.showmode = false

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes"

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.scrolloff = 8

vim.opt.hlsearch = true

vim.opt.swapfile = false

vim.opt.matchpairs:append("<:>")

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Variable highlight faster
vim.o.updatetime = 100



-- //////////////
-- //  REMAPS  //
-- //////////////
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', 'x', '"_x', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'x', '"_x', { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

-- TODO: check if I can use tabs instead of buffers
vim.api.nvim_set_keymap('n', '<Tab>', ':bn<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-Tab>', ':bp<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>q', ':bd<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<Esc>", ":noh<CR>", { noremap = true, silent = true })



-- ///////////////
-- //  PLUGINS  //
-- ///////////////
vim.pack.add({
    { src = "https://github.com/brenoprata10/nvim-highlight-colors" },
    { src = "https://github.com/craftzdog/solarized-osaka.nvim" },
    { src = "https://github.com/stevearc/conform.nvim" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/echasnovski/mini.files" },
    { src = "https://github.com/folke/snacks.nvim" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-telescope/telescope-symbols.nvim" },
    { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
    { src = "https://github.com/christoomey/vim-tmux-navigator" },
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
})

-- nvim-highlight-colors
require('nvim-highlight-colors').setup{}
vim.opt.termguicolors = true

-- solarized-osaka.nvim
require("solarized-osaka").setup({
    transparent = false,
})
vim.o.background = "dark"
vim.cmd("colorscheme solarized-osaka")

-- conform.nvim
require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
    },
})

-- gitsigns.nvim
require("gitsigns").setup({
    signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "│" },
    },
    on_attach = function(bufnr)
        local gitsigns = require("gitsigns")

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]h", function()
            if vim.wo.diff then
                vim.cmd.normal({ "]c", bang = true })
            else
                gitsigns.nav_hunk("next")
            end
        end)

        map("n", "[h", function()
            if vim.wo.diff then
                vim.cmd.normal({ "[c", bang = true })
            else
                gitsigns.nav_hunk("prev")
            end
        end)

        map("n", "<leader>hs", gitsigns.stage_hunk)
        map("n", "<leader>hr", gitsigns.reset_hunk)

        map("v", "<leader>hs", function()
            gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)

        map("v", "<leader>hr", function()
            gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)

        map("n", "<leader>hS", gitsigns.stage_buffer)
        map("n", "<leader>hR", gitsigns.reset_buffer)
        map("n", "<leader>hi", gitsigns.preview_hunk_inline)

        map("n", "<leader>hb", function()
            gitsigns.blame_line({ full = true })
        end)

        map("n", "<leader>hd", gitsigns.diffthis)
    end,
})

-- mini.files
require("mini.files").setup({
    options = {
        permanent_delete = false,
        use_as_default_explorer = true,
    },
    mappings = {
        close = "q",
        go_in = "l",
        go_in_plus = "",
        go_out = "h",
        go_out_plus = "",
        mark_goto = "",
        mark_set = "",
        reset = "",
        reveal_cwd = "",
        show_help = "g?",
        synchronize = "=",
        trim_left = "<",
        trim_right = ">",
    },
    windows = {
        preview = true,
        width_focus = 25,
        width_preview = 55,
    },
})

vim.keymap.set(
    "n",
    "<leader>b",
    ":lua MiniFiles.open()<cr>",
    { desc = "MiniFiles Open", noremap = true, silent = false }
)

-- snacks.nvim
require("snacks").setup({
    indent = { enabled = true },
    statuscolumn = { enabled = true },
})

-- telescope.nvim
require("telescope").setup({
    defaults = {
        layout_strategy = "vertical",
        file_ignore_patterns = {
            "%.git/",
        },
    },
    pickers = {
        find_files = {
            hidden = true,
        },
        live_grep = {
            additional_args = function(_)
                return { "--hidden" }
            end,
        },
    },
})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[S]earch [B]uffers" })
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

-- vim-tmux-navigator
vim.g.tmux_navigator_no_mappings = 1
local opts = { silent = true }
vim.keymap.set('n', '<C-h>', '<cmd>TmuxNavigateLeft<cr>', opts)
vim.keymap.set('n', '<C-j>', '<cmd>TmuxNavigateDown<cr>', opts)
vim.keymap.set('n', '<C-k>', '<cmd>TmuxNavigateUp<cr>', opts)
vim.keymap.set('n', '<C-l>', '<cmd>TmuxNavigateRight<cr>', opts)
vim.keymap.set('n', '<C-\\>', '<cmd>TmuxNavigatePrevious<cr>', opts)

-- lualine.nvim
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
