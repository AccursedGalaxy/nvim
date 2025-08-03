-- Navigation module: Telescope + Harpoon + Yazi
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Telescope Configuration
require("telescope").setup({
	defaults = {
		prompt_prefix = " ",
		selection_caret = " ",
		path_display = { "truncate" },
		file_ignore_patterns = {
			".git/",
			"node_modules/",
			"target/",
			"dist/",
			"build/",
		},
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.55,
				results_width = 0.8,
			},
			vertical = {
				mirror = false,
			},
			width = 0.87,
			height = 0.80,
			preview_cutoff = 120,
		},
	},
	pickers = {
		find_files = {
			theme = "dropdown",
			previewer = false,
		},
		live_grep = {
			theme = "ivy",
		},
	},
})

-- Telescope keybindings - <leader>f* namespace
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fh", ":Telescope help_tags<CR>", opts)
keymap("n", "<C-p>", ":Telescope git_files<CR>", opts) -- Legacy shortcut

-- Project files function (current directory and subdirectories)
function _G.project_files()
	require("telescope.builtin").find_files({
		prompt_title = "< Project Files >",
		cwd = vim.fn.expand("%:p:h"),
	})
end
keymap("n", "<leader>pf", ":lua project_files()<CR>", opts)

-- Harpoon Configuration (Harpoon2)
local harpoon = require("harpoon")
harpoon:setup({
	settings = {
		save_on_toggle = true,
		sync_on_ui_close = true,
	},
})

-- Harpoon keybindings - <leader>h* namespace
keymap("n", "<leader>ha", function() harpoon:list():add() end, opts)
keymap("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, opts)

-- Navigate to specific harpoon files
keymap("n", "<leader>h1", function() harpoon:list():select(1) end, opts)
keymap("n", "<leader>h2", function() harpoon:list():select(2) end, opts)
keymap("n", "<leader>h3", function() harpoon:list():select(3) end, opts)
keymap("n", "<leader>h4", function() harpoon:list():select(4) end, opts)

-- Toggle previous & next buffers stored within Harpoon list
keymap("n", "<C-S-P>", function() harpoon:list():prev() end, opts)
keymap("n", "<C-S-N>", function() harpoon:list():next() end, opts)

-- Yazi Configuration
require("yazi").setup({
	open_for_directories = true,
	keymaps = {
		show_help = "<f1>",
	},
})

-- Yazi keybinding
keymap("n", "<leader>y", ":Yazi<CR>", opts)