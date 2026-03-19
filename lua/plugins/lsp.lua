return {
	{
		"mason-org/mason.nvim",
		opts = {
			ui = {
				border = "rounded",
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},

	-- Bridge: mason ↔ lspconfig
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"lua_ls", -- Lua
				"pyright", -- Python
				"gopls", -- Go
				"ts_ls", -- TypeScript/JavaScript
			},
			-- automatically calls vim.lsp.enable() for installed servers
			automatic_enable = true,
		},
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
	},

	-- Better Lua LSP for Neovim configs specifically
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},

	-- LSP config + keymaps + diagnostics UI
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			-- Diagnostic signs in the gutter
			vim.diagnostic.config({
				virtual_text = {
					prefix = "●",
				},
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = {
					border = "rounded",
					source = true,
				},
			})

			-- Keymaps only active when LSP attaches to a buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspKeys", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
					end

					map("gd", vim.lsp.buf.definition, "Go to definition")
					map("gr", vim.lsp.buf.references, "Go to references")
					map("<leader>lh", function()
						vim.lsp.buf.hover({ border = "rounded", title = " docs ", max_width = 80 })
					end, "Hover documentation")
				end,
			})

			vim.api.nvim_set_hl(0, "FloatBorder", { link = "DiagnosticHint" })

			-- Override lua_ls to know about vim globals
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = { checkThirdParty = false },
					},
				},
			})

			-- Auto-detect .venv for pyright
			local function find_venv()
				local dir = vim.fn.getcwd()
				while dir ~= "/" do
					local venv = dir .. "/.venv"
					if vim.fn.isdirectory(venv) == 1 then
						return venv
					end
					dir = vim.fn.fnamemodify(dir, ":h")
				end
			end

			local venv_path = find_venv()
			if venv_path then
				vim.lsp.config("pyright", {
					settings = {
						python = {
							pythonPath = venv_path .. "/bin/python",
						},
					},
				})
			end
		end,
	},
}
