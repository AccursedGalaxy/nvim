return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2", -- Use the latest version (harpoon2)
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local harpoon = require("harpoon")

			harpoon:setup({
				settings = {
					save_on_toggle = true,
					sync_on_ui_close = true,
					-- Use the current working directory as the key for project-specific lists
					key = function()
						return vim.uv.cwd() or ""
					end,
				},
				-- Default list configuration (can be customized further)
				default = {},
			})

			-- Keybindings for core functionality
			vim.keymap.set("n", "<C-a>", function()
				harpoon:list():add()
			end, { desc = "Harpoon: Add file" })
			vim.keymap.set("n", "<leader>hh", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
				local win = vim.api.nvim_get_current_win()
				local cfg = vim.api.nvim_win_get_config(win)
				if cfg.relative ~= "" then
					vim.wo[win].winblend = 0
					vim.wo[win].winhighlight = "NormalFloat:Normal"
				end
			end, { desc = "Harpoon: Toggle menu" })

			-- Quick select keymaps for first 4 slots (customize as needed)
			vim.keymap.set("n", "<C-s>", function()
				harpoon:list():select(1)
			end, { desc = "Harpoon: Go to 1" })
			vim.keymap.set("n", "<C-t>", function()
				harpoon:list():select(2)
			end, { desc = "Harpoon: Go to 2" })
			vim.keymap.set("n", "<C-n>", function()
				harpoon:list():select(3)
			end, { desc = "Harpoon: Go to 3" })
			vim.keymap.set("n", "<C-p>", function()
				harpoon:list():select(4)
			end, { desc = "Harpoon: Go to 4" })
		end,
	},
}
