local status_ok, yazi = pcall(require, "yazi")
if not status_ok then
	return
end

-- Configure yazi options
local config = {
	-- Set to false by default, but you can enable if you want
	open_for_directories = false,
	-- Floating window border style
	yazi_floating_window_border = "rounded",
	-- Window scaling and transparency
	floating_window_scaling_factor = 0.9,
	yazi_floating_window_winblend = 0,
}

-- Register Yazi command
vim.api.nvim_create_user_command("Yazi", function()
	yazi.yazi(config)
end, {})

-- Set up key mappings
vim.keymap.set("n", "<leader>ya", "<cmd>Yazi<CR>", { noremap = true, silent = true, desc = "Open Yazi" })
