-- ~/.config/nvim/lua/core/keymaps.lua
vim.g.mapleader = " " -- Space as leader, must be set before lazy.nvim loads
vim.g.maplocalleader = "\\"

local map = vim.keymap.set
-- signature: map(mode, lhs, rhs, opts)
-- mode: "n" normal, "i" insert, "v" visual, "x" visual-only, "t" terminal

-- Back to file nav
map("n", "<leader>pv", "<cmd>Ex<CR>", { desc = "Open Netrw" })

-- Move to top-bottom/start-end in normal mode
map("n", "<S-j>", "G", { desc = "move to bottom" })
map("n", "<S-k>", "gg", { desc = "move to top" })
map("n", "<S-h>", "0", { desc = "move to start" })
map("n", "<S-l>", "$", { desc = "move to end" })

-- Move to top-bottom/start-end in visual mode
map("v", "<S-j>", "G", { desc = "move to bottom" })
map("v", "<S-k>", "gg", { desc = "move to top" })
map("v", "<S-h>", "0", { desc = "move to start" })
map("v", "<S-l>", "$", { desc = "move to end" })

-- Move selected lines
map("v", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Stay in visual mode when indenting
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Run command in a new tmux pane below
map("n", "<leader>tr", function()
	vim.fn.system("tmux split-window -v -l 15 ; $SHELL")
end, { desc = "Run command in tmux pane below" })
