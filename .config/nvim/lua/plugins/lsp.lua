local diagnostic_icons = {
	ERROR = "",
	WARN = "",
	HINT = "",
	INFO = "",
}

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", opts = {} },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- Define the diagnostic signs.
		for severity, icon in pairs(diagnostic_icons) do
			local hl = "DiagnosticSign" .. severity:sub(1, 1) .. severity:sub(2):lower()
			vim.fn.sign_define(hl, { text = icon, texthl = hl })
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				local bufnr = event.buf

				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				-- Rename the variable under your cursor.
				--  Most Language Servers support renaming across files, etc.
				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

				-- Execute a code action, usually your cursor needs to be on top of an error
				-- or a suggestion from your LSP for this to activate.
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

				-- Find references for the word under your cursor.
				map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

				-- Jump to the implementation of the word under your cursor.
				--  Useful when your language has ways of declaring types without an actual implementation.
				map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

				-- Jump to the definition of the word under your cursor.
				--  This is where a variable was first declared, or where a function is defined, etc.
				--  To jump back, press <C-t>.
				map("grd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

				-- WARN: This is not Goto Definition, this is Goto Declaration.
				--  For example, in C this would take you to the header.
				map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				if client and client.supports_method("textDocument/documentHighlight") then
					-- Crea un gruppo di autocomandi per gestire l'evidenziazione.
					-- `clear = true` assicura che non vengano aggiunti duplicati al ricaricamento della config.
					local highlight_augroup = vim.api.nvim_create_augroup("LspDocumentHighlights", { clear = true })

					-- Evidenzia i riferimenti quando il cursore si ferma.
					vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave" }, {
						buffer = bufnr,
						group = highlight_augroup,
						desc = "Highlight references under the cursor",
						callback = vim.lsp.buf.document_highlight,
					})

					-- Pulisci le evidenziazioni quando il cursore si muove o si entra in modalità inserimento.
					vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter" }, {
						buffer = bufnr,
						group = highlight_augroup,
						desc = "Clear highlight references",
						callback = vim.lsp.buf.clear_references,
					})
				end
			end,
		})

		vim.lsp.inlay_hint.enable()
		-- Diagnostic Config
		-- See :help vim.diagnostic.Opts
		vim.diagnostic.config({
			underline = {
				severity = {
					vim.diagnostic.severity.WARN,
					vim.diagnostic.severity.ERROR,
				},
			},
			virtual_text = { current_line = true },
			float = {
				source = "if_many",
				border = "rounded",
				-- Show severity icons as prefixes.
				prefix = function(diag)
					local level = vim.diagnostic.severity[diag.severity]
					local prefix = string.format(" %s ", diagnostic_icons[level])
					return prefix, "Diagnostic" .. level:gsub("^%l", string.upper)
				end,
			},
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = diagnostic_icons.ERROR,
					[vim.diagnostic.severity.WARN] = diagnostic_icons.WARN,
					[vim.diagnostic.severity.INFO] = diagnostic_icons.INFO,
					[vim.diagnostic.severity.HINT] = diagnostic_icons.HINT,
				},
			},
		})
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.goto_prev()
		end, opts)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.goto_next()
		end, opts)
		vim.keymap.set("n", "[e", function()
			vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
		end, opts)
		vim.keymap.set("n", "]e", function()
			vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
		end, opts)

		-- LSP servers and clients are able to communicate to each other what features they support.
		--  By default, Neovim doesn't support everything that is in the LSP specification.
		--  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
		--  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
		local original_capabilities = vim.lsp.protocol.make_client_capabilities()
		local capabilities = require("blink.cmp").get_lsp_capabilities(original_capabilities)

		-- Enable the following language servers
		--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
		--
		--  Add any additional override configuration in the following tables. Available keys are:
		--  - cmd (table): Override the default command used to start the server
		--  - filetypes (table): Override the default list of associated filetypes for the server
		--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
		--  - settings (table): Override the default settings passed when initializing the server.
		--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
		local servers = {
			clangd = {},
			pyright = {},
			lua_ls = {},
		}

		-- Ensure the servers and tools above are installed
		--
		-- To check the current status of installed tools and/or manually install
		-- other tools, you can run
		--    :Mason
		--
		-- You can press `g?` for hlp in this menu.
		--
		-- `mason` had to be setup earlier: to configure its options see the
		-- `dependencies` table for `nvim-lspconfig` above.
		--
		-- You can add other tools here that you want Mason to install
		-- for you, so that they are available from within Neovim.
		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"stylua", -- Used to format Lua code
		})
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		require("mason-lspconfig").setup({
			ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
			automatic_installation = false,
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					-- This handles overriding only values explicitly passed
					-- by the server configuration above. Useful when disabling
					-- certain features of an LSP (for example, turning off formatting for ts_ls)
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
