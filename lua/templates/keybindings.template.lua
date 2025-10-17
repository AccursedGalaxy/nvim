-- ============================================================================
-- CUSTOM KEYBINDINGS TEMPLATE
-- ============================================================================
-- Description: Template for adding custom keybindings for new features
-- Dependencies: None
-- Usage: Add to core/keymaps.lua or create as separate module
--
-- STEPS TO ADD KEYBINDINGS:
-- 1. Copy this file: cp keybindings.template.lua [feature]-keys.lua
-- 2. Replace FEATURE placeholders with actual details
-- 3. Add keybindings following the namespace convention
-- 4. Add to init.lua: require("config.[feature]-keys") (if separate file)
-- 5. Test with :ConfigReload

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ============================================================================
-- [FEATURE] KEYBINDINGS
-- ============================================================================
-- Description: Keybindings for [feature description]
-- Namespace: <leader>[k]* (choose an unused letter for 'k')

-- Example keybindings (replace with your actual bindings)

-- Main feature commands
-- keymap("n", "<leader>k", ":FeatureCommand<CR>", opts)           -- Main action
-- keymap("n", "<leader>kt", ":FeatureToggle<CR>", opts)           -- Toggle feature
-- keymap("n", "<leader>ko", ":FeatureOpen<CR>", opts)             -- Open feature
-- keymap("n", "<leader>kc", ":FeatureClose<CR>", opts)            -- Close feature

-- Sub-feature commands
-- keymap("n", "<leader>ka", ":FeatureAction<CR>", opts)           -- Action
-- keymap("n", "<leader>ks", ":FeatureSearch<CR>", opts)           -- Search
-- keymap("n", "<leader>kf", ":FeatureFormat<CR>", opts)           -- Format

-- ============================================================================
-- VISUAL MODE KEYBINDINGS (Optional)
-- ============================================================================

-- Visual mode equivalents
-- keymap("v", "<leader>k", ":FeatureCommand<CR>", opts)           -- Visual action
-- keymap("v", "<leader>ks", ":FeatureSearch<CR>", opts)           -- Visual search

-- ============================================================================
-- INSERT MODE KEYBINDINGS (Optional)
-- ============================================================================

-- Insert mode shortcuts (use sparingly)
-- keymap("i", "<C-k>", "<Esc>:FeatureComplete<CR>a", opts)        -- Quick completion

-- ============================================================================
-- KEYBINDING CONVENTIONS
-- ============================================================================

-- Follow these conventions for consistency:

-- NAMESPACE USAGE:
-- <leader>f* : Find/Search operations (Telescope)
-- <leader>h* : Harpoon navigation
-- <leader>l* : LSP operations
-- <leader>g* : Git operations
-- <leader>c* : Configuration/Development tools
-- <leader>q* : Session/Quick operations
-- <leader>t* : Terminal/Toggle operations
-- <leader>m* : Miscellaneous (use as last resort)

-- MODIFIERS:
-- <leader> alone : Most common action
-- <leader><letter> : Main commands
-- <leader><letter><letter> : Sub-commands

-- EXAMPLES FROM THIS CONFIG:
-- <leader>ff : Find files (Telescope)
-- <leader>fg : Live grep (Telescope)
-- <leader>gs : Git status (Fugitive)
-- <leader>ld : Go to definition (LSP)
-- <leader>la : Code actions (LSP)

-- ============================================================================
-- COMMON KEYBINDING PATTERNS
-- ============================================================================

-- PATTERN 1: Simple command execution
-- keymap("n", "<leader>k", ":Command<CR>", opts)

-- PATTERN 2: Lua function call
-- keymap("n", "<leader>k", function() require("module").function() end, opts)

-- PATTERN 3: Conditional execution
-- keymap("n", "<leader>k", function()
--     if vim.bo.filetype == "lua" then
--         vim.cmd("Luafmt")
--     else
--         vim.cmd("Format")
--     end
-- end, opts)

-- PATTERN 4: With description for which-key
-- keymap("n", "<leader>k", ":Command<CR>", { desc = "Description" })

-- ============================================================================
-- TESTING KEYBINDINGS
-- ============================================================================

-- To test your keybindings:
-- 1. Source the file: :ConfigReload
-- 2. Try the keybindings in appropriate contexts
-- 3. Check for conflicts: :verbose map <key>
-- 4. Use :messages to see any errors

-- ============================================================================
-- AVOIDING CONFLICTS
-- ============================================================================

-- Check for existing mappings before adding new ones:
-- :verbose map <leader>k
-- :verbose map <C-k>
-- :verbose map gk

-- Common conflict areas:
-- - <C-j/k/h/l> (used by tmux navigation)
-- - <leader> + single letters (check existing usage)
-- - Function keys <F1-F12>
-- - Common Vim keys like 'q', 'w', etc.

-- ============================================================================
-- DOCUMENTATION
-- ============================================================================

-- After adding keybindings, update:
-- 1. KEYBINDINGS.md with new mappings
-- 2. This file's header comments
-- 3. Any relevant feature documentation
