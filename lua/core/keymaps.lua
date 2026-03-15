-- ~/.config/nvim/lua/core/keymaps.lua
vim.g.mapleader = " "  -- Space as leader, must be set before lazy.nvim loads
vim.g.maplocalleader = "\\"

local map = vim.keymap.set
-- signature: map(mode, lhs, rhs, opts)
-- mode: "n" normal, "i" insert, "v" visual, "x" visual-only, "t" terminal

-- Back to file nav
map("n", "<leader>pv", "<cmd>:Ex<CR>", { desc = "Save file" })

-- Move to top and bottom
map("n", "<S-j>", "G", { desc = "move to bottom" })
map("n", "<S-k>", "gg", { desc = "move to top" })

-- Move to start and end
map("n", "<S-h>", "0", { desc = "move to start" })
map("n", "<S-l>", "$", { desc = "move to end" })

-- Move selected lines
map("v", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
