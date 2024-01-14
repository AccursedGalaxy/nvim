-- Fugitive configuration
-- Function to create key mappings
local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Key mappings for Fugitive
map("n", "<leader>gs", ":G<CR>", { silent = true }) -- Open Fugitive status window
map("n", "<leader>gc", ":Git commit<CR>", { silent = true }) -- Quick commit
map("n", "<leader>gp", ":Git push<CR>", { silent = true }) -- Push changes
map("n", "<leader>gf", ":Git fetch<CR>", { silent = true }) -- Fetch changes
map("n", "<leader>gl", ":Git pull<CR>", { silent = true }) -- Pull changes
map("n", "<leader>gd", ":Gvdiffsplit!<CR>", { silent = true }) -- Open vertical diff split
map("n", "<leader>gb", ":Git blame<CR>", { silent = true }) -- Git blame
map("n", "<leader>gr", ":Gread<CR>", { silent = true }) -- Read from the index
map("n", "<leader>gw", ":Gwrite<CR>", { silent = true }) -- Write to the index

-- Additional commands for enhanced workflow
vim.api.nvim_command("command! -nargs=* Gclog Git log --oneline --decorate <args>") -- Custom log command
