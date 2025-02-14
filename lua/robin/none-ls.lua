-- TODO: Implement None LS Configuraion
local none_ls = require("null-ls")

-- Configuring non-LSP diagnostics, formatting, etc.
none_ls.setup({
	sources = {
		-- Lua formatting
		none_ls.builtins.formatting.stylua,
		
		-- Python formatting
		none_ls.builtins.formatting.black,
		none_ls.builtins.formatting.isort,
		
		-- Python linting - uncomment after installing flake8
		-- none_ls.builtins.diagnostics.flake8,
	},
})

-- Create format on save autocommand group
local group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true })

-- Format on save for Lua and Python files
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.lua", "*.py" },
	callback = function()
		vim.lsp.buf.format({ async = false })
	end,
	group = group,
})
