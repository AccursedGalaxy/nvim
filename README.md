# Streamlined Neovim Configuration

A **minimal, fast, and well-organized** Neovim setup focused on core productivity tools. This configuration has been streamlined from 40+ plugins down to **15 essential plugins** with a clean modular architecture.

## 🎯 Design Philosophy

- **Minimal but Complete**: Only essential plugins, no redundancy
- **Performance First**: Optimized lazy-loading for fast startup
- **Consistent Keybindings**: Organized namespaces for intuitive navigation
- **Modern Workflow**: Telescope → Harpoon → Yazi navigation flow
- **Developer Focused**: Full LSP support for Python, Go, and TypeScript

## 📁 Architecture

```
~/.config/nvim/
├── init.lua                 # Minimal entry point
├── lua/
│   ├── core/
│   │   ├── options.lua      # Essential Neovim settings
│   │   └── keymaps.lua      # Organized keybindings
│   ├── plugins/
│   │   └── init.lua         # Single plugin declaration file
│   └── config/
│       ├── navigation.lua   # Telescope + Harpoon + Yazi
│       ├── lsp.lua         # Mason + LSP + Completion + Copilot
│       ├── ui.lua          # Lualine + Fidget + Wal theme
│       ├── editing.lua     # Treesitter + Comment + Todo + Autopairs
│       └── git.lua         # Fugitive integration
└── KEYBINDINGS.md          # Complete keybinding reference
```

## 🚀 Core Features

### Navigation Stack
- **Telescope**: Fuzzy file finding and project-wide search
- **Harpoon**: Quick switching between key project files  
- **Yazi**: Advanced file management and directory navigation

### Language Support
- **Mason**: Automatic LSP server management
- **LSP**: Full language server support for Python (pyright), Go (gopls), TypeScript (ts_ls)
- **Completion**: Fast, intelligent autocompletion with nvim-cmp
- **Copilot**: AI-assisted coding features

### Development Tools
- **Git Integration**: Comprehensive Git operations via Fugitive
- **Syntax Highlighting**: Advanced syntax highlighting with Treesitter
- **Code Editing**: Smart commenting, auto-pairs, TODO highlighting

### UI & Theme
- **Lualine**: Clean, informative status line
- **Fidget**: LSP progress indicators
- **Wal Integration**: Transparent background with wal colorscheme support

## 📋 Essential Plugins (15 total)

| Plugin | Purpose |
|--------|---------|
| `telescope.nvim` | Fuzzy finder and search |
| `harpoon` | Quick file navigation |
| `yazi.nvim` | File manager integration |
| `mason.nvim` | LSP server management |
| `nvim-lspconfig` | LSP configuration |
| `nvim-cmp` + sources | Code completion |
| `copilot.lua` + `copilot-cmp` | AI assistance |
| `vim-fugitive` | Git integration |
| `lualine.nvim` | Status line |
| `fidget.nvim` | LSP progress |
| `nvim-treesitter` | Syntax highlighting |
| `nvim-comment` | Code commenting |
| `todo-comments.nvim` | TODO highlighting |
| `nvim-autopairs` | Auto-pairs |
| `wal.vim` | Colorscheme |

## ⌨️ Keybinding Namespaces

All keybindings use `<Space>` as the leader key with consistent namespaces:

- **`<leader>f*`**: Find/Search operations (Telescope)
- **`<leader>h*`**: Harpoon quick navigation  
- **`<leader>l*`**: LSP operations
- **`<leader>g*`**: Git operations
- **`<leader>y`**: Yazi file manager

> **📖 Complete Reference**: See [KEYBINDINGS.md](KEYBINDINGS.md) for all keybindings

## ⚡ Performance Optimizations

- **Lazy Loading**: All plugins load only when needed
- **Startup Time**: 50%+ improvement over previous configuration
- **Memory Usage**: Reduced footprint through strategic plugin loading
- **File Count**: Reduced from 39 configuration files to 8 organized modules

## 🛠️ Supported Languages

| Language | LSP Server | Features |
|----------|------------|----------|
| Python | pyright | Full IntelliSense, type checking |
| Go | gopls | Go-specific tooling, formatting |
| TypeScript/JavaScript | ts_ls | Modern JS/TS support |
| Lua | Built-in | Neovim configuration |

## 📦 Installation

1. **Backup existing configuration**:
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Clone this repository**:
   ```bash
   git clone https://github.com/AccursedGalaxy/nvim.git ~/.config/nvim
   ```

3. **Start Neovim**:
   ```bash
   nvim
   ```
   Plugins will install automatically on first launch.

## 🎨 Colorscheme

This configuration uses **wal.vim** for terminal color integration with transparent background support. Make sure you have `wal` (pywal) configured for optimal appearance.

## 🔧 Customization

The modular architecture makes customization straightforward:

- **Add plugins**: Modify `lua/plugins/init.lua`
- **Adjust settings**: Edit files in `lua/core/`
- **Configure features**: Modify files in `lua/config/`
- **Change keybindings**: Update `lua/core/keymaps.lua` or feature-specific configs

## 📝 Migration Notes

This is a **streamlined version** that removes:
- VSCode integration
- Multiple colorschemes
- Note-taking plugins (Obsidian, Vimwiki)
- UI clutter (Noice, Notify, Trouble)
- Redundant Git tools
- Unused utilities

All essential functionality is preserved while dramatically improving performance and maintainability.

---

**Version**: Streamlined 2024
**Compatibility**: Neovim 0.10.2+
**Plugin Manager**: lazy.nvim