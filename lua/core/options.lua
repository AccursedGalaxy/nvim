-- ~/.config/nvim/lua/core/options.lua
local opt = vim.opt  -- vim.opt is a Lua table that maps to :set in vimscript

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Tabs / indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true    -- override ignorecase if search has uppercase
opt.hlsearch = false    -- don't keep matches highlighted after search
opt.incsearch = true

-- Appearance
opt.termguicolors = true
opt.signcolumn = "yes"  -- always show, prevents layout shift
opt.cursorline = true
opt.scrolloff = 8       -- keep 8 lines above/below cursor

-- Behaviour
opt.wrap = false
opt.clipboard = "unnamedplus"  -- use system clipboard
opt.splitright = true
opt.splitbelow = true
opt.undofile = true     -- persistent undo across sessions
opt.updatetime = 250    -- faster CursorHold events (used by LSP)
