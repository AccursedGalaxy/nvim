-- LSP module: Mason + lspconfig + completion + Copilot
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Mason Setup
require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗"
		}
	}
})

-- LSP Configuration
local lspconfig = require("lspconfig")

-- LSP keybindings - <leader>l* namespace
local on_attach = function(client, bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	
	-- LSP actions
	keymap("n", "<leader>ld", vim.lsp.buf.definition, bufopts)
	keymap("n", "<leader>lr", vim.lsp.buf.references, bufopts)
	keymap("n", "<leader>lh", vim.lsp.buf.hover, bufopts)
	keymap("n", "<leader>li", vim.lsp.buf.implementation, bufopts)
	keymap("n", "<leader>ls", vim.lsp.buf.signature_help, bufopts)
	keymap("n", "<leader>lt", vim.lsp.buf.type_definition, bufopts)
	keymap("n", "<leader>la", vim.lsp.buf.code_action, bufopts)
	keymap("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, bufopts)
	keymap("n", "<leader>lR", vim.lsp.buf.rename, bufopts)
	
	-- Diagnostics
	keymap("n", "<leader>le", vim.diagnostic.open_float, bufopts)
	keymap("n", "[d", vim.diagnostic.goto_prev, bufopts)
	keymap("n", "]d", vim.diagnostic.goto_next, bufopts)
	keymap("n", "<leader>lq", vim.diagnostic.setloclist, bufopts)
end

-- Configure LSP servers
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Python
lspconfig.pyright.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "basic",
				autoImportCompletions = true,
			}
		}
	}
})

-- Go
lspconfig.gopls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
			gofumpt = true,
		},
	},
})

-- TypeScript
lspconfig.ts_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		typescript = {
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
		},
		javascript = {
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
		},
	},
})

-- Completion Setup (nvim-cmp)
local cmp = require("cmp")

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = cmp.config.sources({
		{ name = "copilot", group_index = 2 },
		{ name = "nvim_lsp", group_index = 2 },
		{ name = "path", group_index = 2 },
	}, {
		{ name = "buffer", group_index = 2 },
	}),
	formatting = {
		format = function(entry, vim_item)
			vim_item.menu = ({
				copilot = "[Copilot]",
				nvim_lsp = "[LSP]",
				buffer = "[Buffer]",
				path = "[Path]",
			})[entry.source.name]
			return vim_item
		end,
	},
})

-- Copilot integration is handled by the plugin configuration in plugins/init.lua