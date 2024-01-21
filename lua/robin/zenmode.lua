-- Zen Mode configuration file for Neovim
require("zen-mode").setup({
	window = {
		backdrop = 0.95,
		height = 0.9,
		width = 0.9,
		options = {
			signcolumn = "no",
			number = false,
			relativenumber = false,
			cursorline = false,
			cursorcolumn = false,
			foldcolumn = "0",
			list = false,
		},
	},
	plugins = {
		options = {
			enabled = true,
			ruler = false,
			showcmd = false,
		},
		gitsigns = { enabled = false },
		tmux = { enabled = false },
		twilight = { enabled = false },
		kitty = {
			enabled = false,
			font = "+4",
		},
	},
	on_open = function(win)
		vim.cmd("IndentBlanklineDisable")
	end,
	on_close = function()
		vim.cmd("IndentBlanklineEnable")
	end,
})
