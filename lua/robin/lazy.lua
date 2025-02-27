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

-- Layz Colorschemes
spec({
	"morhetz/gruvbox",
	as = "gruvbox.nvim",
})
spec("folke/tokyonight.nvim")
spec("sainnhe/everforest")
spec("sainnhe/gruvbox-material")
spec("sainnhe/sonokai")
spec("sainnhe/edge")
spec({
	"craftzdog/solarized-osaka.nvim",
	lazy = true,
})
spec("arcticicestudio/nord-vim")
spec({
	"rose-pine/neovim",
	name = "rose-pine",
})

-- load transparent and run :TransparentEnable
spec({ "xiyaowong/nvim-transparent", run = ":TransparentEnable" })

-- Lazy plugins
spec("MunifTanjim/nui.nvim")
spec("neovim/nvim-lspconfig")
spec("williamboman/nvim-lsp-installer")
spec("b0o/schemastore.nvim")
spec("folke/lsp-colors.nvim")
spec("vimwiki/vimwiki")
spec("folke/todo-comments.nvim")
spec("nvim-lualine/lualine.nvim")
spec("terrortylor/nvim-comment")
spec("nvimtools/none-ls.nvim")
spec("ThePrimeagen/harpoon")
spec("akinsho/toggleterm.nvim")
spec({ "ellisonleao/glow.nvim", config = true, cmd = "Glow" })
spec({
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {},
})

-- Noice Nvim
spec("folke/noice.nvim")
spec("MunifTanjim/nui.nvim")
spec("rcarriga/nvim-notify")

-- CMP Setup including dependencies
spec("hrsh7th/nvim-cmp")
spec("hrsh7th/cmp-nvim-lsp")
spec("hrsh7th/cmp-buffer")
spec("hrsh7th/cmp-path")
spec("hrsh7th/cmp-cmdline")
spec("vonheikemen/lsp-zero.nvim")
spec("saadparwaiz1/cmp_luasnip")
spec("github/copilot.vim")
spec("L3MON4D3/LuaSnip")
spec("rafamadriz/friendly-snippets")
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
	after = { "copilot.lua" },
	config = function()
		require("copilot_cmp").setup()
	end,
})

-- Mason Setup
spec("williamboman/mason.nvim")

-- Telescope
spec("nvim-lua/plenary.nvim")
spec("nvim-telescope/telescope.nvim")
spec("nvim-telescope/telescope-project.nvim")
spec("nvim-telescope/telescope-symbols.nvim")
spec("nvim-telescope/telescope-frecency.nvim")
spec("rinx/nvim-ripgrep")
spec("ThePrimeagen/git-worktree.nvim")

-- Hyperland - hyprparse
spec("hyprland-community/hyprparse")

-- Better UI
spec("kyazdani42/nvim-web-devicons")
spec("akinsho/nvim-bufferline.lua")
spec("glepnir/galaxyline.nvim")
spec("akinsho/nvim-toggleterm.lua")
spec("folke/which-key.nvim")
spec("folke/zen-mode.nvim")
spec("karb94/neoscroll.nvim")
spec({
	"j-hui/fidget.nvim",
	config = function()
		require("fidget").setup({
			-- You can customize options here. The default setup should be enough in most cases.
			text = {
				spinner = "dots", -- Choose your preferred spinner animation
			},
			align = {
				bottom = true, -- Align spinners at the bottom of the screen
				right = true, -- Align spinners to the right
			},
			timer = {
				spinner_rate = 125, -- Spinner update rate in milliseconds
				fidget_decay = 2000, -- How long to keep around completed fidget
				task_decay = 1000, -- How long to keep completed tasks
			},
			window = {
				blend = 0, -- Transparency of the window (0 = opaque, 100 = fully transparent)
			},
		})
	end,
})

-- Cloak for Hiding Sensative Information
-- spec("laytan/cloak.nvim")

-- Fugitive and GitGutter
spec("tpope/vim-fugitive")
spec("airblade/vim-gitgutter")

-- Load Treesitter and do :TSUpdate
spec({
	"nvim-treesitter/nvim-treesitter",
	run = ":TSUpdate",
})

-- Folke Trouble
spec({
	"folke/trouble.nvim",
	opts = {}, -- Configure default options here
	cmd = "Trouble",
})
-- UndoTree
spec("mbbill/undotree")

-- Refactoring - By The One And Only ThePrimeagen
spec({
	"ThePrimeagen/refactoring.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	lazy = false,
	config = function()
		require("refactoring").setup()
	end,
})

spec({
	"christoomey/vim-tmux-navigator",
	cmd = {
		"TmuxNavigateLeft",
		"TmuxNavigateDown",
		"TmuxNavigateUp",
		"TmuxNavigateRight",
		"TmuxNavigatePrevious",
	},
	keys = {
		{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
		{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
		{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
		{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
		{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
	},
})

-- Obsidian Plugin
spec({
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended to use latest release
	lazy = true,
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- Optional, for completion
		"hrsh7th/nvim-cmp",
		-- Optional, for search and quick-switch functionality
		"nvim-telescope/telescope.nvim",
		-- Optional, alternative to telescope for search and quick-switch functionality
		"ibhagwan/fzf-lua",
	},
})

-- Yazi file manager
spec({
	"mikavilpas/yazi.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	lazy = false,
})

-- Setup lazy.nvim with the specified plugins
require("lazy").setup({
	spec = LAZY_PLUGIN_SPEC,
})
