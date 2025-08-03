-- Minimal entry point for streamlined Neovim configuration
if vim.g.vscode then
	-- VSCode integration has been removed as part of streamlining
	return
end

-- Essential setup before loading plugins
vim.opt.termguicolors = true -- Start with true for plugin compatibility

-- Load plugin manager and plugins
require("plugins")

-- Load core configuration
require("core.options")
require("core.keymaps")

-- Configure colorscheme with transparency
vim.opt.termguicolors = false -- Disable for wal.vim compatibility
vim.cmd([[colorscheme wal]])

-- Load feature configurations
require("config.navigation") -- Telescope + Harpoon + Yazi
require("config.lsp")        -- Mason + LSP + Completion + Copilot
require("config.ui")         -- lualine + fidget + wal theme
require("config.editing")    -- Treesitter + comment + todo-comments + auto-pairs
require("config.git")        -- Fugitive
