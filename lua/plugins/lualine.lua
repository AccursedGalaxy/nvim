return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "cursed.nvim" },
	config = function()
		local lualine = require("lualine")
		local ok_cursed, cursed = pcall(require, "cursed.statusline")

		local colors_path = vim.fn.expand("~/.local/state/quickshell/user/generated/neovim_colors.lua")

		local function build_theme()
			local ok, c = pcall(dofile, colors_path)
			if not ok or not c then
				return "everforest"
			end
			local none = "NONE"
			return {
				normal = {
					a = { fg = c.on_primary, bg = c.primary },
					b = { fg = c.on_surface_variant, bg = none },
					c = { fg = c.outline, bg = none },
				},
				insert = {
					a = { fg = c.on_tertiary, bg = c.tertiary },
					b = { fg = c.on_surface_variant, bg = none },
					c = { fg = c.outline, bg = none },
				},
				visual = {
					a = { fg = c.on_secondary, bg = c.secondary },
					b = { fg = c.on_surface_variant, bg = none },
					c = { fg = c.outline, bg = none },
				},
				replace = {
					a = { fg = c.on_error, bg = c.error },
					b = { fg = c.on_surface_variant, bg = none },
					c = { fg = c.outline, bg = none },
				},
				command = {
					a = { fg = c.on_primary_container, bg = c.primary_container },
					b = { fg = c.on_surface_variant, bg = none },
					c = { fg = c.outline, bg = none },
				},
				inactive = {
					a = { fg = c.outline, bg = none },
					b = { fg = c.outline, bg = none },
					c = { fg = c.outline, bg = none },
				},
			}
		end

		local function setup_lualine()
			lualine.setup({
				options = { theme = build_theme() },
				sections = {
					lualine_x = ok_cursed and { cursed.component } or {},
				},
			})
		end

		setup_lualine()

		vim.api.nvim_create_autocmd("User", {
			pattern = "MaterialYouReload",
			callback = setup_lualine,
		})
	end,
}
