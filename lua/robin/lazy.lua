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
spec("nvim-telescope/telescope.nvim")
spec("ThePrimeagen/harpoon")
spec({
	"mikavilpas/yazi.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
})

-- Language Support - LSP and Completion
spec("williamboman/mason.nvim")
spec("neovim/nvim-lspconfig")

-- Completion System
spec("hrsh7th/nvim-cmp")
spec("hrsh7th/cmp-nvim-lsp")
spec("hrsh7th/cmp-buffer")
spec("hrsh7th/cmp-path")

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
spec("tpope/vim-fugitive")

-- UI Components
spec("nvim-lualine/lualine.nvim")
spec({
	"j-hui/fidget.nvim",
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
spec("nvim-treesitter/nvim-treesitter")
spec("terrortylor/nvim-comment")
spec("folke/todo-comments.nvim")

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