-- Enable Git Gutter
vim.g.gitgutter_enabled = 1

-- Disable default key mappings
vim.g.gitgutter_map_keys = 0

-- Custom sign definitions
vim.g.gitgutter_sign_added = "▌"
vim.g.gitgutter_sign_modified = "▌"
vim.g.gitgutter_sign_removed = "▁"
vim.g.gitgutter_sign_removed_first_line = "▔"
vim.g.gitgutter_sign_removed_above_and_below = "▔"

-- Function to set highlight groups for signs
local function set_gitgutter_highlights()
	vim.api.nvim_command("highlight GitGutterAdd guifg=#009900 ctermfg=2")
	vim.api.nvim_command("highlight GitGutterChange guifg=#bbbb00 ctermfg=3")
	vim.api.nvim_command("highlight GitGutterDelete guifg=#ff2222 ctermfg=1")
end

-- Call the function to set highlights
set_gitgutter_highlights()

-- Debounce (in milliseconds) to improve performance
vim.g.gitgutter_debounce = 100

-- Set updatetime for CursorHold (optional)
vim.o.updatetime = 250

-- Custom key mappings
vim.api.nvim_set_keymap("n", "<leader>ga", ":GitGutterToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>gh", ":GitGutterLineHighlightsToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>gs", ":GitGutterStageHunk<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>gr", ":GitGutterRevertHunk<CR>", { noremap = true, silent = true })

-- Jump between hunks
vim.api.nvim_set_keymap("n", "<leader>gn", ":GitGutterPrevHunk<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>gp", ":GitGutterNextHunk<CR>", { noremap = true, silent = true })

-- Automatically update signs after file write
vim.api.nvim_command("autocmd BufWritePost * GitGutter")

-- Optional: Turn off Git Gutter in certain file types
vim.api.nvim_command("autocmd FileType markdown,plaintext let b:gitgutter_enabled = 0")
