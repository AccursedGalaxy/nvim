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

-- Session management keybindings (persistence plugin)
keymap("n", "<leader>qs", ':lua require("persistence").load()<CR>', opts)      -- Load last session
keymap("n", "<leader>ql", ':lua require("persistence").load({ last = true })<CR>', opts)  -- Load last session
keymap("n", "<leader>qd", ':lua require("persistence").stop()<CR>', opts)     -- Stop session saving

-- Trouble keybindings (better diagnostics)
keymap("n", "<leader>xx", ":Trouble diagnostics toggle<CR>", opts)           -- Toggle diagnostics
keymap("n", "<leader>xX", ":Trouble diagnostics toggle filter.buf=0<CR>", opts) -- Buffer diagnostics
keymap("n", "<leader>cs", ":Trouble symbols toggle focus=false<CR>", opts)   -- Symbols
keymap("n", "<leader>cl", ":Trouble lsp toggle focus=false win.position=right<CR>", opts) -- LSP info
keymap("n", "<leader>xL", ":Trouble loclist toggle<CR>", opts)               -- Location list
keymap("n", "<leader>xQ", ":Trouble qflist toggle<CR>", opts)                -- Quickfix list

-- Spectre keybindings (global search/replace)
keymap("n", "<leader>S", ':lua require("spectre").toggle()<CR>', opts)                   -- Toggle Spectre
keymap("n", "<leader>sw", ':lua require("spectre").open_visual({select_word=true})<CR>', opts) -- Search word
keymap("n", "<leader>sp", ':lua require("spectre").open_file_search({select_word=true})<CR>', opts) -- Search file

-- Development Tools (for config development and testing)
keymap("n", "<leader>cr", ":ConfigReload<CR>", opts)        -- Reload configuration
keymap("n", "<leader>ch", ":ConfigHealth<CR>", opts)        -- Health check
keymap("n", "<leader>cb", ":ConfigBackup<CR>", opts)        -- Backup config
keymap("n", "<leader>cp", ":ConfigProfile<CR>", opts)       -- Plugin performance profile
keymap("n", "<leader>ce", ":ConfigEdit ", opts)             -- Edit config file (with completion)
keymap("n", "<leader>ct", ":ConfigTestLSP<CR>", opts)       -- Test LSP functionality
keymap("n", "<leader>cg", ":SetupGuide<CR>", opts)          -- Interactive setup guide

-- Note: Plugin-specific keybindings will be defined in their respective config modules:
-- - <leader>f* namespace: Telescope (find operations)
-- - <leader>h* namespace: Harpoon (quick file navigation)
-- - <leader>g* namespace: Git operations (Fugitive)
-- - <leader>l* namespace: LSP operations
-- - <leader>y: Yazi file manager
-- - Ctrl+H/J/K/L: Tmux-Navigator for seamless pane navigation between tmux and nvim
