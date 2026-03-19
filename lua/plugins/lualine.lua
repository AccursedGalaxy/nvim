return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "cursed.nvim" },
	config = function()
		local lualine = require("lualine")
		local ok, cursed = pcall(require, "cursed.statusline")

		-- Custom theme using terminal palette colors (from matugen/Material You)
		local t = {}
		for i = 0, 15 do
			t[i] = vim.g["terminal_color_" .. i]
		end
		-- Fallback: if terminal colors aren't set yet, use cterm indices
		local function fg(idx)
			return t[idx] and { fg = t[idx], bg = "NONE" } or { fg = idx, bg = "NONE", cterm = {} }
		end
		local colors = {
			normal = { a = fg(4), b = fg(7), c = fg(8) },
			insert = { a = fg(2), b = fg(7), c = fg(8) },
			visual = { a = fg(5), b = fg(7), c = fg(8) },
			replace = { a = fg(1), b = fg(7), c = fg(8) },
			command = { a = fg(3), b = fg(7), c = fg(8) },
			inactive = { a = fg(8), b = fg(8), c = fg(8) },
		}

		lualine.setup({
			options = { theme = colors },
			sections = {
				lualine_x = ok and { cursed.component } or {},
			},
		})
	end,
}
