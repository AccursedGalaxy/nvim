require("toggleterm").setup({
	-- size can be a number or function which returns a number
	size = 20,
	open_mapping = [[<leader>tt]],
	hide_numbers = true,
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "float", -- or 'vertical' or 'horizontal'
})

function _G.set_terminal_keymaps()
	local opts = { noremap = true }
	--  Navigate between windows
	vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

function _G.open_python_repl()
	require("toggleterm.terminal").Terminal:new({ cmd = "python", hidden = true }):toggle()
end

vim.api.nvim_set_keymap("n", "<leader>py", "<cmd>lua open_python_repl()<CR>", { noremap = true, silent = true })
