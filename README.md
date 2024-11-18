# NeoVim Configuration by AccursedGalaxy


A modern, feature-rich Neovim configuration focused on productivity, with intelligent LSP integration, extensive plugin support, and carefully crafted keymaps.
This setup supports both regular Neovim and VSCode Neovim integration.
It is a work in progress and continuously evolving as I refine and optimize it.

⚠️ **Note:** This setup is currently not fully tested or documented. If you choose to use or adapt it, I recommend forking the repository and customizing it to your own needs.

> **Planned Improvement:** I will add an installation script to automate the setup and simplify future updates.

## Features

### Core Functionality
- **Dual Mode Support**: Separate configurations for standalone Neovim and VSCode-Neovim integration
- **Lazy Loading**: Powered by lazy.nvim for optimal startup performance
- **Intelligent LSP Integration**: Comprehensive language server support with automatic setup
- **Advanced Search Capabilities**: Integrated Ripgrep and Telescope for powerful search functionality

### Language Support
- Built-in support for multiple languages including:
  - Python (pyright)
  - C/C++ (clangd)
  - Go (gopls)
  - Rust
  - Lua
  - HTML/CSS
  - JSON/YAML
  - Bash
  - And more...

### Key Features

#### LSP and Code Intelligence
- Full LSP integration with automatic server configuration
- Intelligent code completion via nvim-cmp
- GitHub Copilot integration for AI-assisted coding
- Advanced diagnostics and error handling
- Code actions and quick fixes

#### Navigation and Search
- Telescope integration for fuzzy finding
- Harpoon for quick file navigation
- Advanced ripgrep integration for project-wide search
- Custom file navigation commands

#### Git Integration
- Fugitive for Git operations
- GitGutter for inline git diff information
- Git worktree support

#### UI Enhancements
- Multiple theme support including:
  - Gruvbox
  - Tokyo Night
  - Solarized Osaka
  - Nord
  - Rose Pine
  - And more...
- Transparent background support
- Custom status line with lualine
- Todo comments highlighting
- Noice for enhanced UI
- Fidget for LSP progress display

#### Productivity Tools
- Terminal integration with toggleterm
- Zen mode for focused coding
- Advanced undo tree visualization
- Custom commenting system
- Markdown preview with Glow
- VimWiki integration for note-taking

## Installation

### Prerequisites
- Neovim >= 0.10.2
- Git
- Node.js (for Copilot and certain LSP features)
- Ripgrep (for search functionality)

### Basic Setup
```bash
git clone https://github.com/AccursedGalaxy/nvim-config ~/.config/nvim
```

### Post-Installation
1. Open Neovim to trigger automatic plugin installation
2. Run `:Mason` to install language servers
3. Run `:Copilot setup` to configure GitHub Copilot

## Key Mappings

### General
- Space as leader key
- Quick file navigation with Telescope
- Advanced split management
- Custom motion commands for efficient navigation

### Notable Mappings
```lua
-- Example keymaps from remap.lua
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
-- ... more keymaps
```

### VSCode Integration
Separate keymaps for VSCode-Neovim integration:
```lua
-- Example VSCode keymaps from vsremap.lua
vim.keymap.set('n', '<Space>', '<Nop>')
vim.g.mapleader = " "
-- ... more VSCode specific keymaps
```

## Plugin Configuration

### LSP Setup
- Automatic language server configuration
- Intelligent completion
- Diagnostic integration
- Code actions and quick fixes

### Search and Navigation
- Telescope integration with custom commands
- Ripgrep integration for advanced search
- Harpoon for quick file switching

## Customization

The configuration is modular and easy to customize:
- Individual plugin configurations in `lua/robin/`
- Separate VSCode and regular Neovim configurations
- Lazy-loaded plugins for optimal performance

## Contributing

Contributions are welcome! Please feel free to submit pull requests or create issues for bugs and feature requests.

## License

MIT License - See [LICENSE](LICENSE.md) for details.

---

For detailed configuration options and more information, please check the individual configuration files in the repository.
