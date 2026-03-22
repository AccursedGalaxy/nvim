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
			automatic_enable = {
				exclude = { "glint" },
			},
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
					local function hover()
						vim.lsp.buf.hover({ border = "rounded", title = " docs ", max_width = 80 })
					end
					map("K", hover, "Hover documentation")
					map("<leader>lh", hover, "Hover documentation")
					map("<leader>lr", vim.lsp.buf.rename, "Rename symbol")
				end,
			})

			-- Override lua_ls to know about vim globals
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = { checkThirdParty = false },
					},
				},
			})

			-- Auto-detect .venv for pyright, re-evaluated on dir changes
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

			local function update_pyright_venv()
				local venv_path = find_venv()
				if venv_path then
					local clients = vim.lsp.get_clients({ name = "pyright" })
					for _, client in ipairs(clients) do
						client.settings = vim.tbl_deep_extend("force", client.settings or {}, {
							python = { pythonPath = venv_path .. "/bin/python" },
						})
						client:notify("workspace/didChangeConfiguration", { settings = client.settings })
					end
				end
			end

			local venv_group = vim.api.nvim_create_augroup("UserPyrightVenv", { clear = true })
			vim.api.nvim_create_autocmd("LspAttach", {
				group = venv_group,
				callback = function(ev)
					local client = vim.lsp.get_client_by_id(ev.data.client_id)
					if client and client.name == "pyright" then
						update_pyright_venv()
					end
				end,
			})
			vim.api.nvim_create_autocmd("DirChanged", {
				group = venv_group,
				callback = update_pyright_venv,
			})
		end,
	},
}
