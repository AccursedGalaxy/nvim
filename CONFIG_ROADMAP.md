# Neovim Configuration Roadmap
## Your Guide to Understanding & Modifying This Setup

This document serves as your map for navigating, understanding, and customizing this Neovim configuration. Think of it as the "source code" documentation for your editor setup.

---

## 🗺️ Configuration Architecture Overview

```
~/.config/nvim/
├── 📄 init.lua                    # 🚀 Launch sequence & module loading
├── 📁 lua/
│   ├── 📁 core/                   # ⚙️  Foundation settings
│   │   ├── 📄 options.lua         # Editor behavior & appearance
│   │   └── 📄 keymaps.lua         # Keyboard shortcuts & bindings
│   ├── 📁 plugins/                # 📦 Plugin ecosystem
│   │   └── 📄 init.lua           # Plugin declarations & lazy loading
│   └── 📁 config/                 # 🎛️  Feature configurations
│       ├── 📄 navigation.lua      # File finding & movement
│       ├── 📄 lsp.lua            # Language server & completion
│       ├── 📄 ui.lua             # Interface & appearance
│       ├── 📄 editing.lua        # Code editing enhancements
│       └── 📄 git.lua            # Version control integration
├── 📄 README.md                   # 📖 User documentation
├── 📄 KEYBINDINGS.md             # ⌨️  Complete keybinding reference
└── 📄 CONFIG_ROADMAP.md          # 🧭 This development guide
```

---

## 🎯 Quick Start: Making Your First Change

### Adding a New Plugin
1. **Edit** `lua/plugins/init.lua`
2. **Add** your plugin using the `spec()` function:
   ```lua
   -- Add at the end of the file, before require("lazy").setup()
   spec({
       "author/plugin-name",
       config = function()
           require("plugin-name").setup({
               -- Your settings here
           })
       end,
   })
   ```
3. **Restart** Neovim or run `:Lazy sync`

### Changing a Keybinding
1. **Edit** `lua/core/keymaps.lua` or the relevant config file
2. **Find** the keybinding section you want to modify
3. **Update** the mapping:
   ```lua
   -- Change from:
   keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
   -- To:
   keymap("n", "<leader>pf", ":Telescope find_files<CR>", opts)
   ```

### Modifying LSP Settings
1. **Edit** `lua/config/lsp.lua`
2. **Find** the language server configuration
3. **Update** settings in the `vim.lsp.config.server_name` block

---

## 📁 Module Responsibilities

### `init.lua` - The Conductor
- **Purpose**: Orchestrates the loading sequence
- **When to modify**: Rarely - only for major architectural changes
- **Key sections**:
  ```lua
  -- Essential setup before plugins
  -- Load plugin manager and plugins
  -- Load core configuration
  -- Configure colorscheme
  -- Load feature configurations
  ```

### `core/options.lua` - Editor DNA
- **Purpose**: Fundamental Neovim behavior
- **Common modifications**:
  - Tab size: `opt.tabstop`, `opt.shiftwidth`
  - Search behavior: `opt.ignorecase`, `opt.smartcase`
  - UI preferences: `opt.number`, `opt.relativenumber`
  - Performance: `opt.updatetime`, `opt.timeoutlen`

### `core/keymaps.lua` - Your Control Center
- **Purpose**: Keyboard shortcuts and commands
- **Organization**:
  - `<leader>*` namespace for global commands
  - `<leader>f*` for finding/searching
  - `<leader>h*` for Harpoon navigation
  - `<leader>l*` for LSP operations
  - `<leader>g*` for Git operations

### `plugins/init.lua` - Plugin Registry
- **Purpose**: Single source of truth for all plugins
- **Structure**:
  ```lua
  -- Essential Colorscheme
  spec("dylanaraps/wal.vim")

  -- Core Navigation Stack
  spec({ "nvim-telescope/telescope.nvim", ... })

  -- Language Support
  spec({ "williamboman/mason.nvim", ... })
  ```
- **Lazy loading patterns**:
  - `event = "VeryLazy"` - Load after UI is ready
  - `event = "BufReadPre"` - Load before opening files
  - `cmd = "CommandName"` - Load when command is used

### Feature Configuration Modules

#### `config/navigation.lua` - Movement & Discovery
- **Plugins**: Telescope, Harpoon, Yazi
- **Customizations**:
  - Search patterns and file exclusions
  - UI themes for different pickers
  - Keybinding preferences

#### `config/lsp.lua` - Language Intelligence
- **Plugins**: Mason, LSP servers, nvim-cmp, Copilot
- **Customizations**:
  - LSP server settings per language
  - Completion behavior
  - Diagnostic display preferences

#### `config/ui.lua` - Visual Experience
- **Plugins**: lualine, fidget, wal colorscheme
- **Customizations**:
  - Status line components
  - Color scheme tweaks
  - UI element positioning

#### `config/editing.lua` - Code Manipulation
- **Plugins**: Treesitter, comment, auto-pairs, todo-comments
- **Customizations**:
  - Syntax highlighting preferences
  - Comment styles
  - Auto-completion behavior

#### `config/git.lua` - Version Control
- **Plugins**: Fugitive, gitsigns
- **Customizations**:
  - Git workflow preferences
  - Diff display options
  - Blame line settings

---

## 🔧 Common Customization Patterns

### Adding Language Support
1. **Add LSP server** in `plugins/init.lua`:
   ```lua
   spec({
       "williamboman/mason-lspconfig.nvim",
       config = function()
           require("mason-lspconfig").setup({
               ensure_installed = {
                   -- Add your language server
                   "rust_analyzer",  -- Example: Rust
               },
           })
       end,
   })
   ```
2. **Configure LSP** in `config/lsp.lua`:
   ```lua
   vim.lsp.config.rust_analyzer = {
       cmd = { "rust-analyzer" },
       filetypes = { "rust" },
       capabilities = capabilities,
       on_attach = on_attach,
   }
   vim.lsp.enable("rust_analyzer")
   ```

### Creating Custom Commands
Add to `core/keymaps.lua`:
```lua
-- Custom command example
keymap("n", "<leader>ct", ":!cargo test<CR>", opts)  -- Run Rust tests
```

### Modifying Colors
The config uses wal colorscheme. For custom colors:
1. Create `lua/config/colors.lua`
2. Add to `init.lua`: `require("config.colors")`
3. Define highlight groups:
   ```lua
   vim.api.nvim_set_hl(0, "CustomHighlight", { fg = "#ff0000", bg = "#000000" })
   ```

---

## 🧪 Testing Your Changes

### Quick Test Commands
- `:checkhealth` - Verify Neovim health
- `:Lazy check` - Check for plugin updates
- `:LspInfo` - Check LSP server status
- `:Mason` - Manage LSP servers

### Safe Testing Workflow
1. **Backup** current config: `cp -r ~/.config/nvim ~/.config/nvim.backup`
2. **Make changes** to test files
3. **Restart** Neovim: `:qa` then `nvim`
4. **Test functionality** thoroughly
5. **Rollback** if needed: `rm -rf ~/.config/nvim && mv ~/.config/nvim.backup ~/.config/nvim`

---

## 🚨 Troubleshooting Guide

### Plugin Not Loading
- Check `plugins/init.lua` for correct spec syntax
- Verify plugin name is correct
- Run `:Lazy sync` to install/update

### Keybinding Not Working
- Check for conflicts in `keymaps.lua`
- Verify the key is not mapped elsewhere
- Use `:verbose map <key>` to see current mapping

### LSP Server Issues
- Run `:Mason` to check server installation
- Verify server configuration in `config/lsp.lua`
- Check `:LspInfo` for server status

### Performance Issues
- Check lazy loading is configured correctly
- Run `:Lazy profile` to identify slow plugins
- Review `core/options.lua` for performance settings

---

## 📈 Advanced Customizations

### Creating New Feature Modules
1. Create `lua/config/your_feature.lua`
2. Add to `init.lua`: `require("config.your_feature")`
3. Follow existing module patterns

### Conditional Loading
```lua
-- Only load on certain conditions
if vim.fn.has("mac") == 1 then
    require("config.macos_specific")
end
```

### Environment-Specific Settings
```lua
-- Different settings for different environments
local hostname = vim.fn.hostname()
if hostname == "work-laptop" then
    -- Work-specific settings
end
```

---

## 🎨 Philosophy & Best Practices

### Keep It Modular
- One feature per module
- Clear separation of concerns
- Consistent naming conventions

### Prioritize Performance
- Use lazy loading whenever possible
- Minimize startup computations
- Profile and optimize regularly

### Document Your Changes
- Comment complex configurations
- Update KEYBINDINGS.md for new shortcuts
- Keep README.md current

### Test Incrementally
- Small changes are easier to debug
- Test after each modification
- Have rollback plans ready

---

## 🔄 Maintenance Workflow

### Regular Updates
1. Check for plugin updates: `:Lazy check`
2. Update plugins: `:Lazy update`
3. Review breaking changes in changelogs

### Configuration Reviews
1. Audit unused plugins every 6 months
2. Review and optimize keybindings
3. Update documentation for changes

### Backup Strategy
- Weekly automated backups
- Version control your configuration
- Document major changes

---

Remember: This configuration is your tool. Customize it to fit your workflow, but maintain the organization that makes it manageable. Start small, test often, and enjoy your personalized Neovim experience! 🚀
