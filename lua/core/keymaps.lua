-- Organized keybindings with consistent namespaces
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader key setup
keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- General keybindings
keymap("n", "<leader>q", ":q<CR>", opts)
keymap("n", "Q", "<nop>")
keymap("n", "<leader><leader>", ":nohlsearch<CR>", opts)

-- Text manipulation
keymap("v", "<", "<gv", opts) -- Outdent and stay in visual mode
keymap("v", ">", ">gv", opts) -- Indent and stay in visual mode
keymap("v", "<C-j>", ":m '>+1<CR>gv=gv", opts) -- Move selection down
keymap("v", "<C-k>", ":m '<-2<CR>gv=gv", opts) -- Move selection up
keymap("n", "<leader>w", "viw", opts) -- Select word

-- Navigation
keymap("n", "H", "^", opts) -- Move to beginning of line
keymap("n", "L", "$", opts) -- Move to end of line
keymap("v", "H", "^", opts)
keymap("v", "L", "$", opts)
keymap("n", "K", "gg", opts) -- Move to start of file
keymap("n", "J", "G", opts) -- Move to end of file

-- Window management
keymap("n", "<leader>sv", ":vsplit<CR>", opts) -- Split vertically
keymap("n", "<leader>sh", ":split<CR>", opts) -- Split horizontally

-- Search and replace
keymap("n", "<leader>rr", ":%s//g<Left><Left>", opts) -- Find and replace

-- Note: Plugin-specific keybindings will be defined in their respective config modules:
-- - <leader>f* namespace: Telescope (find operations)
-- - <leader>h* namespace: Harpoon (quick file navigation)
-- - <leader>g* namespace: Git operations (Fugitive)
-- - <leader>l* namespace: LSP operations
-- - <leader>y: Yazi file manager
-- - Ctrl+H/J/K/L: Tmux-Navigator for seamless pane navigation between tmux and nvim
