-- Simple wrapper to load our custom theme
require("robin.lualine_wal_theme").setup()

-- We're using the custom setup from lualine_wal_theme.lua
-- This file is kept minimal to avoid any syntax issues

-- Empty setup to prevent the default from overriding our custom setup
local lualine = require("lualine")

local wal_theme = require("robin.lualine_wal_theme")
local theme = wal_theme.generate_theme()

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = theme,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {},
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", { "diagnostics", sources = { "nvim_diagnostic" } } },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
