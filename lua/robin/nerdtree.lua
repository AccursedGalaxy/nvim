-- NERDTree Configuration

-- Turn on netrw on startup
vim.g.NERDTreeHijackNetrw = 0

-- Don't show the help banner
vim.g.NERDTreeMinimalUI = 1

-- Don't show the file system tree on startup
vim.g.NERDTreeQuitOnOpen = 1

-- better shortcuts to open NERDTree and navigate in and out of it
vim.api.nvim_set_keymap("n", "<leader>t", ":NERDTreeToggle<CR>", { noremap = true, silent = true })
