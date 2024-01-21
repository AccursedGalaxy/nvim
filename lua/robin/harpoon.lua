-- Require the Harpoon module
local harpoon = require("harpoon")
local harpoon_ui = require("harpoon.ui")
local harpoon_mark = require("harpoon.mark")

-- Set up keymaps (using a generic function to map keys)
local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Open Harpoon menu with Ctrl+e
map("n", "<leader>e", ':lua require("harpoon.ui").toggle_quick_menu()<CR>')

-- Add and remove marks
map("n", "<C-m>", ':lua require("harpoon.mark").add_file()<CR>')

-- Set up the Harpoon menu
harpoon.setup({
	global_settings = {
		save_on_toggle = true,
		save_on_change = true,
	},
})

-- Set shortcuts to quickly navigate between marks
map("n", "<C-b>", ':lua require("harpoon.ui").nav_file(1)<CR>')
map("n", "<C-t>", ':lua require("harpoon.ui").nav_file(2)<CR>')
map("n", "<C-s>", ':lua require("harpoon.ui").nav_file(3)<CR>')
map("n", "<C-n>", ':lua require("harpoon.ui").nav_file(4)<CR>')
