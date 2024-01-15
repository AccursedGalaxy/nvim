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

-- load transparent and run :TransparentEnable
spec("xiyaowong/nvim-transparent")
vim.cmd("autocmd VimEnter * TransparentEnable")

-- Lazy plugins
spec("github/copilot.vim")
spec("neovim/nvim-lspconfig")
spec("williamboman/nvim-lsp-installer")
spec("b0o/schemastore.nvim")
spec("folke/lsp-colors.nvim")
spec("folke/trouble.nvim")
spec("vimwiki/vimwiki")
spec("folke/todo-comments.nvim")
spec("nvim-lualine/lualine.nvim")
spec("terrortylor/nvim-comment")
spec("nvimtools/none-ls.nvim")
spec("ThePrimeagen/harpoon") -- Harpoon
spec("christoomey/vim-tmux-navigator") -- Tmux Navigator

-- Noice Nvim
spec("folke/noice.nvim")
spec("MunifTanjim/nui.nvim")
spec("rcarriga/nvim-notify")

-- CMP Setup including dependencies
spec("hrsh7th/nvim-cmp")
spec("hrsh7th/cmp-nvim-lsp") -- LSP completion source
spec("hrsh7th/cmp-buffer") -- Buffer completion source
spec("hrsh7th/cmp-path") -- Path completion source
spec("hrsh7th/cmp-cmdline") -- Cmdline completion source
spec("saadparwaiz1/cmp_luasnip") -- Snippet completion source
spec("L3MON4D3/LuaSnip") -- Snippet engine
spec("rafamadriz/friendly-snippets") -- Snippet collection

-- Mason Setup
spec("williamboman/mason.nvim")

-- telescope
spec("nvim-lua/plenary.nvim")
spec("nvim-telescope/telescope.nvim")
spec("nvim-telescope/telescope-project.nvim")
spec("nvim-telescope/telescope-symbols.nvim")
spec("nvim-telescope/telescope-frecency.nvim")
spec("rinx/nvim-ripgrep")
spec("ThePrimeagen/git-worktree.nvim")

-- Better UI
spec("kyazdani42/nvim-web-devicons")
spec("akinsho/nvim-bufferline.lua")
spec("glepnir/galaxyline.nvim")
spec("akinsho/nvim-toggleterm.lua")
spec("folke/which-key.nvim")
spec("folke/zen-mode.nvim")

-- fugitive and gitgutter
spec("tpope/vim-fugitive")
spec("airblade/vim-gitgutter")

-- Load Treesitter and do :TSUpdate
spec({
	"nvim-treesitter/nvim-treesitter",
	run = ":TSUpdate",
})

require("lazy").setup({
	spec = LAZY_PLUGIN_SPEC,
})
