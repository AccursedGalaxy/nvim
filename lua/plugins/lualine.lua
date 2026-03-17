return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "cursed.nvim" },
	config = function()
		local lualine = require("lualine")
		local ok, cursed = pcall(require, "cursed.statusline")

		lualine.setup({
			options = { theme = "everforest" },
			sections = {
				lualine_x = ok and { cursed.component } or {},
			},
		})
	end,
}
