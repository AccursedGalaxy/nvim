return {
	"sainnhe/everforest",
	priority = 1000, -- load first
	config = function()
		vim.g.everforest_background = "soft" -- hard, medium, soft
		vim.g.everforest_better_performance = 1
		vim.cmd.colorscheme("everforest")
		-- Make backgrounds transparent to match terminal opacity
		local groups = {
			"Normal",
			"NormalNC",
			"NormalFloat",
			"CursorLine",
			"CursorLineNr",
			"SignColumn",
			"EndOfBuffer",
			"StatusLine",
			"StatusLineNC",
		}
		for _, group in ipairs(groups) do
			local hl = vim.api.nvim_get_hl(0, { name = group })
			hl.bg = nil
			hl.ctermbg = nil
			vim.api.nvim_set_hl(0, group, hl --[[@as vim.api.keyset.highlight]])
		end
	end,
}
