local home = vim.fn.expand("~")

return {
	"epwalsh/obsidian.nvim",
	version = "*", -- use the latest release
	lazy = true,
	event = {
		-- This pattern matches markdown files in any vault (e.g., ~/vaults/personal, ~/vaults/work, etc.)
		"BufReadPre "
			.. home
			.. "/vaults/*/*.md",
		"BufNewFile " .. home .. "/vaults/*/*.md",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		workspaces = {
			{
				name = "personal",
				path = home .. "/vaults/personal",
			},
			{
				name = "work",
				path = home .. "/vaults/work",
			},
			-- Uncomment or add more workspaces if needed
			-- {
			--   name = "lifenotes",
			--   path = home .. "/vaults/lifenotes",
			-- },
		},
		-- Additional options can be added here.
	},
}
