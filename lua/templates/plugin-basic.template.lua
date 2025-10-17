-- ============================================================================
-- BASIC PLUGIN TEMPLATE
-- ============================================================================
-- Description: Template for adding a simple plugin with basic configuration
-- Dependencies: None (plugin will be installed automatically)
-- Usage: Copy to lua/config/ and require in init.lua, or configure in plugins/init.lua
--
-- STEPS TO ADD A NEW PLUGIN:
-- 1. Copy this file: cp plugin-basic.template.lua [plugin-name].lua
-- 2. Replace PLUGIN placeholders with actual plugin details
-- 3. Add plugin spec to plugins/init.lua
-- 4. Add to init.lua: require("config.[plugin-name]") (if separate config file)
-- 5. Test with :ConfigReload

-- ============================================================================
-- PLUGIN: [PLUGIN-NAME]
-- ============================================================================
-- Description: Brief description of what this plugin does
-- Repository: https://github.com/author/plugin-name
-- Purpose: Why you're adding this plugin

-- Basic plugin setup (uncomment and modify as needed)
-- require("[plugin-name]").setup({
--     -- Basic configuration options
--     enabled = true,
--
--     -- Example options (replace with actual plugin options)
--     -- option1 = "value1",
--     -- option2 = 42,
--     -- option3 = true,
-- })

-- ============================================================================
-- KEYBINDINGS (Optional)
-- ============================================================================

-- local keymap = vim.keymap.set
-- local opts = { noremap = true, silent = true }

-- Add keybindings for the plugin (if needed)
-- keymap("n", "<leader>p", ":PluginCommand<CR>", opts)

-- ============================================================================
-- COMMON PLUGIN PATTERNS
-- ============================================================================

-- PATTERN 1: Simple setup with default config
-- require("plugin-name").setup()

-- PATTERN 2: Setup with configuration table
-- require("plugin-name").setup({
--     setting1 = "value",
--     setting2 = true,
-- })

-- PATTERN 3: Setup with callback configuration
-- require("plugin-name").setup(function()
--     -- Configuration logic here
-- end)

-- PATTERN 4: No setup function needed
-- (Some plugins work out of the box)

-- ============================================================================
-- EXAMPLES OF POPULAR PLUGINS
-- ============================================================================

-- EXAMPLE 1: vim-commentary (simple plugin, no setup needed)
-- Just add to plugins/init.lua, no config file needed
-- spec("tpope/vim-commentary")

-- EXAMPLE 2: nvim-tree (requires setup)
-- require("nvim-tree").setup({
--     view = {
--         width = 30,
--     },
--     filters = {
--         dotfiles = true,
--     },
-- })

-- EXAMPLE 3: telescope-ui-select (extends existing plugin)
-- require("telescope").load_extension("ui-select")

-- ============================================================================
-- ADDING TO PLUGINS/INIT.LUA
-- ============================================================================

-- Add this to your plugins/init.lua file:
--
-- spec({
--     "author/plugin-name",
--     config = function()
--         require("plugin-name").setup({
--             -- Your configuration here
--         })
--     end,
-- })

-- Or if you prefer separate config files:
--
-- spec("author/plugin-name")  -- Basic spec
--
-- And then load this config file in init.lua:
-- require("config.plugin-name")

-- ============================================================================
-- TESTING YOUR PLUGIN
-- ============================================================================

-- After adding the plugin:
-- 1. Run :Lazy sync to install
-- 2. Restart Neovim or run :ConfigReload
-- 3. Test the plugin functionality
-- 4. Use :ConfigHealth to check for issues
-- 5. Check :messages for any error messages
