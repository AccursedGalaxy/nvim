# NeoVim Configuration by AccursedGalaxy

This is my customized NeoVim setup designed to boost productivity and streamline development workflows.
With an emphasis on lazy loading, efficient key mappings, and UI enhancements, this configuration is a versatile toolset for any developer.
It is a work in progress and continuously evolving as I refine and optimize it.

## Overview

My NeoVim configuration incorporates a robust plugin ecosystem managed via `lazy.nvim`, making it performant and modular. The setup includes essential language server support, advanced code completion, intuitive UI components, and productivity-enhancing tools.

⚠️ **Note:** This setup is currently not fully tested or documented. If you choose to use or adapt it, I recommend forking the repository and customizing it to your own needs.

## Installation

> **Planned Improvement:** I will add an installation script to automate the setup and simplify future updates.

### Prerequisites

- **NeoVim v0.10.2+**: Ensure you are using the latest version.
- **Git**: Required for cloning plugins.
- **Package Manager**: Uses [lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management.

### Quick Setup

1. **Clone the Repository**:
   ```sh
   git clone https://github.com/AccursedGalaxy/nvim-config ~/.config/nvim
   ```

2. **Install Plugins**:
   Open NeoVim and install all specified plugins:
   ```vim
   :Lazy
   ```

3. **Set the Colorscheme**:
   ```vim
   :colorscheme solarized-osaka
   ```

4. **Restart NeoVim**: Your configuration is now loaded and ready to use.

## Plugin Configuration

The setup uses `lazy.nvim` for plugin management with the following core plugins and features:

### Core Features

- **Lazy Loading**: Plugins are loaded only when needed, reducing startup time.
- **LSP and Syntax Highlighting**:
  - Configured with `nvim-lspconfig` and `mason.nvim` for language server management.
  - Advanced syntax highlighting using `nvim-treesitter`.
- **Auto-completion**: `nvim-cmp` for intelligent code suggestions and `copilot.vim` for AI-assisted coding.
- **Git Integration**: Tools like `vim-fugitive` and `vim-gitgutter` for seamless version control.
- **File Navigation**: `telescope.nvim` for fuzzy finding and `harpoon` for efficient file switching.
- **UI Enhancements**:
  - `lualine.nvim` for a modern status line.
  - `nvim-bufferline.lua` for enhanced tab management.
  - `noice.nvim` and `nvim-notify` for better command line and notification UI.

### Key Mappings

Custom key mappings are defined in `robin.remap` to streamline navigation and editing. Check the `remap` file for a complete overview.

## Usage and Customization

- **Fork and Customize**: Feel free to fork the repository and tailor the configuration to your workflow.
- **Lazy Plugin Setup**: The configuration is modular, making it easy to add or remove plugins.

## Notable Plugins

- **Themes**: Multiple colorschemes, including `gruvbox`, `tokyonight.nvim`, `solarized-osaka.nvim`, and more.
- **Smooth Scrolling**: `neoscroll.nvim` for better scrolling experience.
- **Terminal Integration**: `toggleterm.nvim` for an embedded terminal.
- **Distraction-Free Writing**: `zen-mode.nvim` for a focused writing environment.
- **Undo Management**: `undotree` for visualizing undo history.
- **Refactoring**: Tools by `ThePrimeagen` for easy code refactoring.

## Future Plans

- **Documentation**: Comprehensive documentation to aid setup and customization.
- **Installation Script**: Automate the installation and updates.
- **Advanced Configurations**: Incorporate more efficient workflows and tools.

## Contribution

Contributions are welcome! Feel free to open issues or submit pull requests to suggest enhancements or report bugs.

## License

This configuration is licensed under the [MIT License](https://opensource.org/licenses/MIT). Check the [LICENSE](LICENSE.md) file for more details.

---

Thank you for exploring my NeoVim setup. I hope you find it useful and adaptable for your own development needs. Happy coding!
