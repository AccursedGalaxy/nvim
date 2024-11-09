require("telescope").load_extension("harpoon")
require("telescope").load_extension("git_worktree")
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader key shortcuts
keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- This is a fix for the <C-i> key being the same as <Tab>
keymap("n", "<C-i>", "<C-i>", opts)

keymap("n", "<leader>q", ":q<CR>", opts)

-- Back to netrw
keymap("n", "<leader>pv", ":Ex<CR>", opts)

-- tabulate lines without going back into normal mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move lines up and down in visual mode
keymap("v", "<C-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<C-k>", ":m '<-2<CR>gv=gv", opts)

-- Select Word
keymap("n", "<leader>w", "viw", opts)

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

-- Move between splits
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "Q", "<nop>")
keymap("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
keymap("n", "<leader>f", vim.lsp.buf.format)

keymap("n", "<leader><leader>", ":nohlsearch<CR>", opts)

-- Find and replace
keymap("n", "<leader>rr", ":%s//g<Left><Left>", opts)

-- Go To Definition
keymap("n", "<leader>gd", ":lua vim.lsp.buf.definition()<CR>", opts)

-- telescope shortcuts
-- function to get the current directory and subdirectories, should also work in netrw
function _G.project_files()
	require("telescope.builtin").find_files({
		prompt_title = "< Project Files >",
		cwd = vim.fn.expand("%:p:h"),
	})
end

keymap("n", "<leader>pf", ":lua project_files()<CR>", opts)
keymap("n", "<leader>gf", ":Telescope git_files<CR>", opts)

-- Telescope shortcuts
keymap("n", "<leader>ss", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>sb", ":Telescope buffers<CR>", opts)

-- Search inside git files with live_grep and git_files
keymap(
	"n",
	"<leader>sg",
	":lua require('telescope.builtin').live_grep({ search_dirs = { vim.fn.expand('%:p:h') } })<CR>",
	opts
)
vim.keymap.set("n", "<leader>sm", ":Telescope harpoon marks<CR>", { desc = "Harpoon [M]arks" }) -- Search marks with Telescope

-- Go To Definition
keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)

-- Todo Comments Stuff
vim.keymap.set("n", "gt", function()
	require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "gT", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })
