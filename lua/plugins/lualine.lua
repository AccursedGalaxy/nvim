return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "cursed.nvim" },
	config = function()
		local lualine = require("lualine")
		local ok, cursed = pcall(require, "cursed.statusline")

		-- Build a transparent theme from everforest colors
		local colors = require("lualine.themes.everforest")
		for _, mode in pairs(colors) do
			for _, section in pairs(mode) do
				section.bg = "NONE"
			end
		end

		lualine.setup({
			options = { theme = colors },
			sections = {
				lualine_x = ok and { cursed.component } or {},
			},
		})
	end,
}
