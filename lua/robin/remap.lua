local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader key shortcuts
keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- This is a fix for the <C-i> key being the same as <Tab>
keymap("n", "<C-i>", "<C-i>", opts)

-- Back to netrw
keymap("n", "<leader>pv", ":Ex<CR>", opts)

-- tabulate lines without going back into normal mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move lines up and down
keymap("n", "<C-j>", ":m .+1<CR>==", opts)
keymap("n", "<C-k>", ":m .-2<CR>==", opts)

-- Move lines up and down in visual mode
keymap("v", "<C-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<C-k>", ":m '<-2<CR>gv=gv", opts)

-- Move half page up and down and keep cursor in the middle
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)

-- Move to Start or End of File
keymap("n", "K", "gg", opts)
keymap("n", "J", "G", opts)

-- Move to the beginning/end of line with H and L
keymap("n", "H", "^", opts)
keymap("n", "L", "$", opts)
keymap("v", "H", "^", opts)
keymap("v", "L", "$", opts)

-- Create Splits out of netrw
keymap("n", "<leader>sv", ":vsplit<CR>", opts)
keymap("n", "<leader>sh", ":split<CR>", opts)

-- Navigate splits with Ctrl + hjkl
-- keymap("n", "<C-H>", "<C-w>h", opts)
-- keymap("n", "<C-J>", "<C-w>j", opts)
-- keymap("n", "<C-K>", "<C-w>k", opts)
-- keymap("n", "<C-L>", "<C-w>l", opts)

-- Find forward and backward with f and F
keymap("n", "f", "f", opts)
keymap("n", "F", "F", opts)

-- Find and replace
keymap("n", "<leader>rr", ":%s//g<Left><Left>", opts)

-- telescope shortcuts
-- function to get the current directory and subdirectories, should also work in netrw
function _G.project_files()
	require("telescope.builtin").find_files({
		prompt_title = "< Project Files >",
		cwd = vim.fn.expand("%:p:h"),
	})
end

-- function to get the current git repository files
function _G.git_files()
	require("telescope.builtin").git_files({
		prompt_title = "< Git Files >",
		cwd = vim.fn.expand("%:p:h"),
	})
end

keymap("n", "<leader>pf", ":lua project_files()<CR>", opts)
keymap("n", "<leader>gf", ":lua git_files()<CR>", opts)

-- Telescope search for text within files
keymap("n", "<leader>ss", ":Telescope live_grep<CR>", opts)

-- Telescope git pickers
keymap("n", "<leader>gb", ":Telescope git_branches<CR>", opts)
keymap("n", "<leader>gc", ":Telescope git_commits<CR>", opts)
keymap("n", "<leader>gs", ":Telescope git_status<CR>", opts)

-- Todo Comments Stuff
vim.keymap.set("n", "gt", function()
	require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "gT", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })
