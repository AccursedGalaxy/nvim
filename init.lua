if vim.g.vscode then
	require("robin.vsremap")
else
	-- Initial Configuration
	require("robin.lazy") -- Lazy loading of plugins
	require("robin.options") -- Basic Neovim options and settings

	-- Load colorscheme
	vim.cmd([[colorscheme solarized-osaka]])

	local augroup = vim.api.nvim_create_augroup
	local Robin = augroup("Robin", {})

	local autocmd = vim.api.nvim_create_autocmd
	local yank_group = augroup("HighlightYank", {})

	function R(name)
		require("plenary.reload").reload_module(name)
	end

	autocmd("TextYankPost", {
		group = yank_group,
		pattern = "*",
		callback = function()
			vim.highlight.on_yank({
				higroup = "IncSearch",
				timeout = 40,
			})
		end,
	})

	autocmd({ "BufWritePre" }, {
		group = Robin,
		pattern = "*",
		command = [[%s/\s\+$//e]],
	})

	vim.g.netrw_browse_split = 0
	vim.g.netrw_banner = 0
	vim.g.netrw_winsize = 25

	-- Key Mappings
	require("robin.remap") -- Custom key mappings

	-- Language Server Protocol (LSP) and Syntax Highlighting
	require("robin.lspconfig") -- LSP configuration
	require("robin.treesitter") -- Treesitter for advanced syntax highlighting
	require("robin.none-ls") -- Non-LSP diagnostics and formatting

	-- Plugins Configuration
	require("robin.mason") -- Mason for managing LSP and other tools
	require("robin.vimwiki") -- Vimwiki for personal wiki and note-taking
	require("robin.telescope") -- Telescope for fuzzy finding and searching
	require("robin.copilot") -- GitHub Copilot for AI-assisted coding
	require("robin.nvim-comment") -- Nvim-comment for easy commenting
	require("robin.cmp") -- Nvim-cmp for autocompletion
	require("robin.harpoon") -- Harpoon for quick file navigation
	require("robin.gitgutter") -- Gitgutter for git diff in the sign column
	require("robin.fugitive") -- Fugitive for git integration
	require("robin.ripgrep") -- Ripgrep for fast text search
	require("robin.noice") -- Noice for command line popup
	require("robin.notify")
	require("robin.toggleterm") -- Toggleterm for terminal in a floating window
	require("robin.neoscroll") -- Neoscroll for smooth scrolling
	require("robin.zenmode") -- Zenmode for distraction-free writing
	require("robin.trouble") -- Trouble for displaying diagnostics
	require("robin.undotree") -- Undotree for visualizing undo history
	require("robin.refactoring") -- Refactoring by ThePrimeagen
	require("robin.cloak") -- Cloak for hiding sensitive information
	require("robin.lsp") -- LSP configuration

	-- UI Enhancements
	require("robin.lualine") -- Lualine for better status line
end
