local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

LAZY_PLUGIN_SPEC = {}

function spec(item)
	table.insert(LAZY_PLUGIN_SPEC, item)
end

-- Essential Colorscheme
spec("dylanaraps/wal.vim")

-- Core Navigation Stack
spec("nvim-lua/plenary.nvim") -- Required dependency for telescope and harpoon
spec({
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
		{ "<C-p>", "<cmd>Telescope git_files<cr>", desc = "Git Files" },
	},
})
spec({
	"ThePrimeagen/harpoon", 
	dependencies = { "nvim-lua/plenary.nvim" }
})
spec({
	"mikavilpas/yazi.nvim",
	event = "VeryLazy",
	keys = {
		{ "<leader>y", "<cmd>Yazi<cr>", desc = "Open Yazi" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
})

-- Language Support - LSP and Completion
spec({
	"williamboman/mason.nvim",
	cmd = "Mason",
	event = "BufReadPre",
})
spec({
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
})

-- Completion System
spec({
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
	},
})

-- Copilot AI Integration
spec({
	"zbirenbaum/copilot.lua",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			suggestion = { enabled = false },
			panel = { enabled = false },
		})
	end,
})
spec({
	"zbirenbaum/copilot-cmp",
	dependencies = { "copilot.lua" },
	config = function()
		require("copilot_cmp").setup()
	end,
})

-- Git Integration
spec({
	"tpope/vim-fugitive",
	cmd = { "Git", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse", "GRemove", "GRename", "Glgrep", "Gedit" },
	keys = {
		{ "<leader>gs", "<cmd>Git<cr>", desc = "Git Status" },
	},
})

-- UI Components
spec({
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
})
spec({
	"j-hui/fidget.nvim",
	event = "LspAttach",
	config = function()
		require("fidget").setup({
			-- Options related to LSP progress subsystem
			progress = {
				poll_rate = 0,                -- How and when to poll for progress messages
				suppress_on_insert = false,   -- Suppress new messages while in insert mode
				ignore_done_already = false,  -- Ignore new tasks that are already complete
				ignore_empty_message = false, -- Ignore new tasks that don't contain a message
				
				-- Options related to how LSP progress messages are displayed as notifications
				display = {
					render_limit = 16,          -- How many LSP messages to show at once
					done_ttl = 3,               -- How long a message should persist after completion
					done_icon = "✔",            -- Icon shown when all LSP progress tasks are complete
					done_style = "Constant",    -- Highlight group for completed LSP tasks
					progress_ttl = math.huge,   -- How long a message should persist when in progress
					progress_icon = { "dots" }, -- Icon shown when LSP progress tasks are in progress
					progress_style = "WarningMsg", -- Highlight group for in-progress LSP tasks
					group_style = "Title",      -- Highlight group for group name (LSP server name)
					icon_style = "Question",    -- Highlight group for group icons
					priority = 30,              -- Ordering priority for LSP notification group
					skip_history = true,        -- Whether progress notifications should be omitted from history
				},
			},

			-- Options related to notification subsystem
			notification = {
				poll_rate = 10,               -- How frequently to update and render notifications
				filter = vim.log.levels.INFO, -- Minimum notifications level
				history_size = 128,           -- Number of removed messages to retain in history
				override_vim_notify = false,  -- Automatically override vim.notify() with Fidget
				
				-- Options related to how notifications are rendered as text
				view = {
					stack_upwards = true,       -- Display notification items from bottom to top
					icon_separator = " ",       -- Separator between group name and icon
					group_separator = "---",    -- Separator between notification groups
					group_separator_hl = "Comment", -- Highlight group used for group separator
				},

				-- Options related to the notification window and buffer
				window = {
					normal_hl = "Comment",      -- Base highlight group in the notification window
					winblend = 0,              -- Background color opacity in the notification window (was blend)
					border = "none",           -- Border around the notification window
					zindex = 45,               -- Stacking priority of the notification window
					max_width = 0,             -- Maximum width of the notification window
					max_height = 0,            -- Maximum height of the notification window
					x_padding = 1,             -- Padding from right edge of window boundary
					y_padding = 0,             -- Padding from bottom edge of window boundary
					align = "bottom",          -- How to align the notification window (was in align table)
					relative = "editor",       -- What the notification window position is relative to
				},
			},

			-- Options related to logging
			logger = {
				level = vim.log.levels.WARN,  -- Minimum logging level
				max_size = 10000,             -- Maximum log file size, in KB
				float_precision = 0.01,       -- Limit the number of decimals displayed for floats
			},
		})
	end,
})

-- Essential Editing
spec({
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
})
spec({
	"terrortylor/nvim-comment",
	keys = {
		{ "gcc", mode = "n", desc = "Comment line" },
		{ "gc", mode = "v", desc = "Comment selection" },
	},
})
spec({
	"folke/todo-comments.nvim",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = { "nvim-lua/plenary.nvim" },
})

-- Auto-pairs for bracket/quote completion
spec({
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = function()
		require("nvim-autopairs").setup({})
	end,
})

-- Tmux + Neovim seamless navigation
spec({
	"christoomey/vim-tmux-navigator",
	keys = {
		{ "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Go to left pane" },
		{ "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Go to lower pane" },
		{ "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Go to upper pane" },
		{ "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Go to right pane" },
	},
})

-- Setup lazy.nvim with the specified plugins
require("lazy").setup({
	spec = LAZY_PLUGIN_SPEC,
})