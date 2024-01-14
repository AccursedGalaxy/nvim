-- Initial Configuration
require("robin.lazy") -- Lazy loading of plugins
require("robin.options") -- Basic Neovim options and settings

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
require("robin.todo-comments") -- Todo-comments for enhanced TODOs visibility
require("robin.nvim-comment") -- Nvim-comment for easy commenting
require("robin.cmp") -- Nvim-cmp for autocompletion
require("robin.harpoon") -- Harpoon for quick file navigation
require("robin.nerdtree") -- NERDTree for file tree navigation
require("robin.gitgutter") -- Gitgutter for git diff in the sign column
require("robin.fugitive") -- Fugitive for git integration
require("robin.ripgrep") -- Ripgrep for fast text search

-- UI Enhancements
require("robin.lualine") -- Lualine for better status line
