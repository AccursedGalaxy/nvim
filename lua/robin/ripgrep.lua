-- First, ensure that you have nvim-ripgrep installed.
-- You can typically do this with your Neovim plugin manager. For example, with packer.nvim:
-- use { 'rinx/nvim-ripgrep' }

-- Require the nvim-ripgrep module
local rg = require("nvim-ripgrep")

-- Configure the nvim-ripgrep plugin
rg.setup({
	-- Set the default options for ripgrep.
	-- These are the arguments that will be passed to the ripgrep command.
	-- You can customize this according to your preferences.
	default_opts = {
		"--ignore-case", -- Ignore case
		"--hidden", -- Search hidden files
		"--follow", -- Follow symlinks
		"--no-heading", -- No heading in search results
		"--line-number", -- Show line numbers
		"--color=never", -- No color in output (as it will be in Neovim)
	},

	-- Customize the appearance and behavior of the search results buffer.
	-- These options are Neovim buffer/window settings applied to the results buffer.
	result_opts = {
		win_height = 10, -- Height of the results window
		win_width = 0.8, -- Width of the results window (percentage of total width)
		border = "rounded", -- Border style ('single', 'double', 'rounded', etc.)
		prompt_title = "[Ripgrep]", -- Title of the search prompt
	},

	-- Customize the mappings within the search prompt and results buffer.
	-- These are mappings for navigating and manipulating the search results.
	mappings = {
		open_file = "<CR>", -- Key to open a file from the results
		open_file_vsplit = "<C-v>", -- Key to open a file in a vertical split
		open_file_tab = "<C-t>", -- Key to open a file in a new tab
		preview_file = "p", -- Key to preview the file
		close_window = "<Esc>", -- Key to close the results window
	},
})

-- Optionally, you can set up command aliases or key mappings to trigger searches.
-- For example, you might want to map a key to search the current word under the cursor.
vim.api.nvim_set_keymap("n", "<leader>rg", ':lua require("nvim-ripgrep").grep()<CR>', { noremap = true, silent = true })
