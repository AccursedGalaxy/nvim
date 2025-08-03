-- Git integration module: Fugitive
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Git keybindings - <leader>g* namespace
keymap("n", "<leader>gs", ":Git<CR>", opts)          -- Git status
keymap("n", "<leader>gc", ":Git commit<CR>", opts)   -- Git commit
keymap("n", "<leader>gp", ":Git push<CR>", opts)     -- Git push
keymap("n", "<leader>gl", ":Git pull<CR>", opts)     -- Git pull
keymap("n", "<leader>ga", ":Git add .<CR>", opts)    -- Git add all
keymap("n", "<leader>gb", ":Git blame<CR>", opts)    -- Git blame
keymap("n", "<leader>gd", ":Gdiffsplit<CR>", opts)   -- Git diff split
keymap("n", "<leader>gh", ":Git log<CR>", opts)      -- Git history/log

-- Fugitive is configured through its default settings
-- No additional setup required - it works out of the box