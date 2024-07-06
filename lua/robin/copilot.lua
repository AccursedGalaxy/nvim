-- Disable default Copilot tab mapping
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true

-- Configure Copilot Lua integration
require("copilot").setup({
	suggestion = { enabled = false },
	panel = { enabled = false },
})
