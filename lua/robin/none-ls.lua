-- TODO: Implement None LS Configuraion
local none_ls = require("null-ls")

-- Configuring non-LSP diagnostics, formatting, etc.
none_ls.setup({
	sources = {
		-- Add sources here
		none_ls.builtins.formatting.stylua,
		none_ls.builtins.formatting.black,
		none_ls.builtins.formatting.isort,
		none_ls.builtins.formatting.autoflake,
	},
	formatters = {
		{
			command = "stylua", -- Lua formatter
			filetypes = { "lua" },
		},
		{
			command = "black", -- Python formatter
			filetypes = { "python" },
		},
		{
			command = "isort", -- Python import sorter
			filetypes = { "python" },
		},
		{
			command = "autoflake",
			filetypes = { "python" },
		},
	},
	-- Example of setting up a linter (add your preferred linters)
	linters = {
		{
			command = "flake8",
			filetypes = { "python" },
		},
	},
})

local group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.lua", "*.py" },
	callback = function()
		local bufnr = vim.api.nvim_get_current_buf()
		vim.lsp.buf.format({ bufnr = bufnr })
	end,
	group = group,
})
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.py",
	callback = function()
		local bufnr = vim.api.nvim_get_current_buf()
		vim.lsp.buf.format({ bufnr = bufnr, async = false })
	end,
})
