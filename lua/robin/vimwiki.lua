-- VimWiki configuration

local g = vim.g -- a table to access global variables

g.vimwiki_list = {
	{
		path = "~/vimwiki/",
		syntax = "markdown",
		ext = ".md",
	},
}

-- set hotkey
vim.api.nvim_set_keymap("n", "<leader>ww", "<Plug>VimwikiIndex", {})
