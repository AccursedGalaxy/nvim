-- Use a protected call in case the plugin isn’t installed yet.
local status, render = pcall(require, "render-markdown")
if not status then
	vim.notify("render-markdown.nvim not found!", vim.log.levels.ERROR)
	return
end

-- Setup the plugin with your desired configuration.
render.setup({
	-- Preview settings: these options are examples; adjust as needed.
	preview = {
		enable = true, -- Enable live preview when editing Markdown
		auto_update = true, -- Automatically update preview as you edit
		layout = "vertical", -- Options: "vertical", "horizontal", or "float"
	},
	border = "rounded", -- Border style for the preview window; other options include "single", "double", etc.
	-- You can add further options as documented by the plugin.
})

-- Optional: Create a key mapping to toggle the Markdown preview.
vim.api.nvim_set_keymap("n", "<leader>rm", "<cmd>RenderMarkdownToggle<CR>", { noremap = true, silent = true })
