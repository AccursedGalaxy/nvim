-- Interactive Setup Guide for Neovim Configuration
-- Run with :SetupGuide to get an interactive tour of your config

local M = {}

-- Guide sections
local sections = {
	{
		title = "🎯 Welcome to Your Neovim Config!",
		content = [[
Your Neovim configuration is now super easy to understand and modify!

This streamlined setup includes:
• 15 essential plugins (down from 40+)
• Feature-based organization
• Development tools for easy customization
• Comprehensive documentation

Let's take a quick tour of what's available.
		]],
		action = "next"
	},
	{
		title = "📁 Configuration Structure",
		content = [[
Your config is organized into logical modules:

CORE (foundation):
  • options.lua    - Editor behavior & appearance
  • keymaps.lua    - Keyboard shortcuts
  • devtools.lua   - Tools for config development

FEATURES (capabilities):
  • navigation.lua - Telescope + Harpoon + Yazi
  • lsp.lua       - Language servers & completion
  • ui.lua        - Status line & visual elements
  • editing.lua   - Code editing enhancements
  • git.lua       - Version control integration

PLUGINS (ecosystem):
  • init.lua      - All plugin declarations

Ready to explore?
		]],
		action = "next"
	},
	{
		title = "🛠️ Development Tools",
		content = [[
You now have powerful tools for config development:

RELOAD & TEST:
  :ConfigReload    - Reload all config modules
  :ConfigHealth    - Check if everything loads correctly
  :ConfigTestLSP   - Test LSP functionality

EDIT QUICKLY:
  :ConfigEdit options     - Edit options.lua
  :ConfigEdit keymaps     - Edit keymaps.lua
  :ConfigEdit plugins     - Edit plugins/init.lua
  (Tab completion available!)

MAINTAIN:
  :ConfigBackup    - Create timestamped backup
  :ConfigProfile   - Check plugin loading performance

Try :ConfigHealth right now!
		]],
		action = "next"
	},
	{
		title = "🎨 Keybinding Namespaces",
		content = [[
Your keybindings use consistent namespaces:

FIND & SEARCH (<leader>f*):
  <leader>ff    Find files (Telescope)
  <leader>fg    Live grep (search in files)
  <leader>fb    Find buffers

NAVIGATION (<leader>h*):
  <leader>ha    Add file to Harpoon
  <leader>hh    Toggle Harpoon menu
  <leader>h1-4  Quick navigation to files

LSP (<leader>l*):
  <leader>ld    Go to definition
  <leader>lr    Find references
  <leader>lf    Format code

CONFIG DEV (<leader>c*):
  <leader>cr    Config reload
  <leader>ch    Config health check

Full reference: :ConfigEdit keybindings
		]],
		action = "next"
	},
	{
		title = "📦 Adding New Features",
		content = [[
Want to add a plugin or language support?

QUICK ADD PLUGIN:
  1. Edit plugins/init.lua: :ConfigEdit plugins
  2. Add spec() call in appropriate section
  3. Run :Lazy sync

ADD LANGUAGE SUPPORT:
  1. Copy template: cp lua/templates/lsp-language.template.lua lua/config/lsp-newlang.lua
  2. Customize the template
  3. Add LSP server to mason config
  4. :ConfigReload to test

TEMPLATES AVAILABLE:
  • Language support templates
  • Plugin configuration templates
  • Keybinding templates

Check lua/templates/ for examples!
		]],
		action = "next"
	},
	{
		title = "📖 Documentation",
		content = [[
Your config is fully documented:

QUICK REFERENCE:
  CONFIG_ROADMAP.md    - Complete development guide
  KEYBINDINGS.md       - All keybindings
  README.md           - User documentation

DEVELOPMENT:
  :help config-roadmap    - Interactive guide
  :ConfigEdit roadmap     - Edit the roadmap

TEMPLATES:
  lua/templates/         - Ready-to-use examples
  lua/templates/README.md - Template documentation

START CUSTOMIZING:
  1. Read CONFIG_ROADMAP.md
  2. Use :ConfigEdit to modify files
  3. Test with :ConfigReload
  4. Backup with :ConfigBackup
		]],
		action = "finish"
	}
}

-- Current section index
local current_section = 1

-- Display current section
function M.show_section()
	local section = sections[current_section]
	if not section then return end

	-- Create floating window
	local buf = vim.api.nvim_create_buf(false, true)
	local width = 80
	local height = 20

	local ui = vim.api.nvim_list_uis()[1]
	local opts = {
		relative = 'editor',
		width = width,
		height = height,
		col = (ui.width - width) / 2,
		row = (ui.height - height) / 2,
		style = 'minimal',
		border = 'rounded'
	}

	local win = vim.api.nvim_open_win(buf, true, opts)

	-- Set content
	local lines = {}
	table.insert(lines, "")
	table.insert(lines, "  " .. section.title)
	table.insert(lines, "  " .. string.rep("=", #section.title + 2))
	table.insert(lines, "")

	for line in section.content:gmatch("[^\r\n]+") do
		table.insert(lines, "  " .. line)
	end

	table.insert(lines, "")
	table.insert(lines, "  Press <Enter> to continue, <q> to quit")

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

	-- Set buffer options
	vim.api.nvim_buf_set_option(buf, 'modifiable', false)
	vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
	vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')

	-- Key mappings
	vim.api.nvim_buf_set_keymap(buf, 'n', '<CR>', ':lua require("core.setup_guide").next_section()<CR>', { noremap = true, silent = true })
	vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':lua require("core.setup_guide").quit_guide()<CR>', { noremap = true, silent = true })
	vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', ':lua require("core.setup_guide").quit_guide()<CR>', { noremap = true, silent = true })
end

-- Go to next section
function M.next_section()
	vim.api.nvim_win_close(0, true)
	current_section = current_section + 1

	if current_section > #sections then
		M.finish_guide()
	else
		M.show_section()
	end
end

-- Quit guide
function M.quit_guide()
	vim.api.nvim_win_close(0, true)
	current_section = 1
	vim.notify("Setup guide closed. Use :SetupGuide to restart.", vim.log.levels.INFO)
end

-- Finish guide
function M.finish_guide()
	current_section = 1
	vim.notify("🎉 Setup guide complete! Your config is ready to customize.", vim.log.levels.INFO)
	vim.notify("Try :ConfigHealth to check everything is working.", vim.log.levels.INFO)
end

-- Start guide
function M.start()
	current_section = 1
	M.show_section()
end

return M
