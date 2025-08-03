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
			text = {
				spinner = "dots",
			},
			align = {
				bottom = true,
				right = true,
			},
			timer = {
				spinner_rate = 125,
				fidget_decay = 2000,
				task_decay = 1000,
			},
			window = {
				blend = 0,
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

-- Setup lazy.nvim with the specified plugins
require("lazy").setup({
	spec = LAZY_PLUGIN_SPEC,
})