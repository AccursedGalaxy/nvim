-- UI module: lualine + fidget + wal theme
require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto", -- Will use wal colorscheme
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = true,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		}
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" }
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {}
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = { "fugitive" }
})

-- Fidget configuration is handled by the plugin setup in plugins/init.lua

-- Wal colorscheme integration and transparency
local function setup_transparency()
	-- Remove backgrounds to maintain transparency
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })
	vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none" })
end

-- Color reload functionality
local function reload_colors()
	vim.cmd("colorscheme wal")
	setup_transparency()
end

-- Set up autocommand for color reloading
vim.api.nvim_create_user_command("ReloadColors", reload_colors, {})

-- Apply transparency after colorscheme loads
vim.defer_fn(setup_transparency, 100)