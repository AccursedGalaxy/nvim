# Neovim Configuration Streamlining - Comprehensive Task Document

**Task Document**

**Feature/Task Name:** Neovim Configuration Streamlining and Optimization

**Description:** 
Transform an overly complex Neovim configuration (39 plugin files, 40+ plugins) into a minimal, fast, and well-organized setup focused on core navigation tools (Telescope + Harpoon + Yazi), efficient LSP setup, and clean UI. The streamlined configuration will maintain full functionality for Python, Go, and TypeScript development while eliminating redundancy and improving performance.

**Goals:**
- Reduce plugin count from 40+ to approximately 15 essential plugins
- Reorganize 39 configuration files into 5-7 feature-based modules
- Eliminate all redundant functionality and conflicting keybindings
- Maintain fast navigation workflow (Telescope for fuzzy find/grep, Harpoon for quick switching, Yazi for file management)
- Preserve modern development features (Copilot AI assistance, LSP intelligence)
- Optimize specifically for Python, Go, and TypeScript/Next.js development workflows
- Remove VSCode integration complexity entirely
- Achieve noticeable startup performance improvement
- Reduce visual clutter and cognitive load

**Requirements:**

*Core Navigation Stack:*
- Telescope: Fuzzy file finding (`find_files`) and project-wide search (`live_grep`)
- Harpoon: Quick file switching between key project files
- Yazi: File management and directory navigation

*Language Support:*
- Mason: Automatic LSP server management
- nvim-lspconfig: LSP configuration for Python (pyright), Go (gopls), TypeScript (ts_ls)
- nvim-cmp: Fast, intelligent code completion
- Copilot: AI-assisted coding features

*Git Integration:*
- Fugitive: Comprehensive Git operations (remove GitGutter and git-worktree)

*UI Components:*
- lualine: Clean status line
- fidget: LSP progress indicators
- wal: Colorscheme with transparent background support

*Essential Editing:*
- Comment plugin: Easy code commenting
- Auto-pairs: Bracket/quote completion
- todo-comments: TODO/FIXME highlighting
- Treesitter: Advanced syntax highlighting

*Configuration Structure:*
- Feature-based modules instead of plugin-based files
- Single plugin declaration file
- Clean, consistent keybinding scheme
- Optimized lazy-loading configuration

**Constraints:**
- Must preserve all current development workflow efficiency
- Cannot break existing language support (Python, Go, TypeScript)
- Must maintain transparent background and wal colorscheme integration
- Must keep Copilot functionality fully intact
- Must preserve essential LSP features (go-to-definition, formatting, diagnostics, code actions)
- No disruption to muscle memory for core navigation patterns
- Must maintain compatibility with existing project structures

**Dependencies:**
- Current lazy.nvim plugin manager (will be streamlined but preserved)
- Existing wal colorscheme configuration and terminal color integration
- System dependencies: ripgrep, Node.js, Git (already installed)
- Mason-managed LSP servers for Python, Go, and TypeScript
- Terminal transparency support
- Existing Neovim version (0.10.2+)

**Expected Outcome:**
- **Performance Improvements:**
  - Faster startup time (reduced plugin loading overhead)
  - Reduced memory footprint
  - Smoother navigation and editing experience

- **Configuration Quality:**
  - Clean, maintainable codebase (5-7 modules vs 39 files)
  - Consistent, non-conflicting keybindings
  - Easy to understand and modify configuration structure

- **Workflow Enhancements:**
  - Streamlined navigation (Telescope → Harpoon → Yazi flow)
  - Reduced cognitive load (less UI clutter, fewer options to remember)
  - Consistent development experience across Python, Go, and TypeScript projects

- **Maintainability:**
  - Easier future customization and updates
  - Clear separation of concerns in configuration modules
  - Simplified troubleshooting and debugging

**Implementation Plan:**

**Phase 1: Preparation and Backup (Risk Mitigation)**
- Create complete backup of current configuration (`~/.config/nvim` → `~/.config/nvim-backup`)
- Document current essential keybindings and workflows in use
- Test current configuration to identify critical functionality
- Create list of exact plugins to remove vs keep

**Phase 2: Plugin Inventory and Removal (Decluttering)**
- Remove redundant colorschemes:
  - Keep: `dylanaraps/wal.vim`
  - Remove: gruvbox, tokyonight, everforest, gruvbox-material, sonokai, edge, solarized-osaka, nord-vim, rose-pine
- Remove note-taking plugins:
  - Remove: `vimwiki/vimwiki`, `epwalsh/obsidian.nvim`
- Remove redundant Git tools:
  - Keep: `tpope/vim-fugitive`
  - Remove: `airblade/vim-gitgutter`, `ThePrimeagen/git-worktree.nvim`
- Remove UI clutter:
  - Keep: `nvim-lualine/lualine.nvim`, `j-hui/fidget.nvim`
  - Remove: `folke/noice.nvim`, `rcarriga/nvim-notify`, `folke/trouble.nvim`
- Remove VSCode integration:
  - Remove: `lua/robin/vsremap.lua` and all VSCode-specific configurations
- Remove overlapping file management:
  - Keep: `mikavilpas/yazi.nvim`
  - Remove: netrw configurations, redundant file browser setups
- Remove unused utilities:
  - Remove: `bullets-vim/bullets.vim`, `akinsho/nvim-bufferline.lua`, `glepnir/galaxyline.nvim`, `folke/which-key.nvim`

**Phase 3: Configuration Architecture Redesign (Restructuring)**
- Create new modular directory structure:
  ```
  ~/.config/nvim/
  ├── init.lua (minimal entry point)
  ├── lua/
  │   ├── core/
  │   │   ├── options.lua (essential Neovim settings)
  │   │   └── keymaps.lua (organized keybindings)
  │   ├── plugins/
  │   │   └── init.lua (single plugin declaration file)
  │   └── config/
  │       ├── navigation.lua (Telescope + Harpoon + Yazi)
  │       ├── lsp.lua (Mason + lspconfig + completion + Copilot)
  │       ├── ui.lua (lualine + fidget + wal theme)
  │       └── editing.lua (comment, auto-pairs, todo-comments, treesitter)
  ```
- Consolidate all plugin specifications into single `plugins/init.lua`
- Merge related configurations into logical feature modules

**Phase 4: Core Plugin Configuration (Essential Systems)**
- **Navigation Module (`config/navigation.lua`):**
  - Configure Telescope with optimized settings for `find_files` and `live_grep`
  - Set up Harpoon with clear file marking and navigation keybindings
  - Configure Yazi integration for file management
  - Ensure smooth workflow between all three tools

- **LSP Module (`config/lsp.lua`):**
  - Configure Mason for automatic management of pyright, gopls, ts_ls
  - Set up nvim-lspconfig with optimized settings for target languages
  - Configure nvim-cmp for fast, intelligent completion
  - Integrate Copilot with completion system
  - Set up essential LSP keybindings (go-to-definition, formatting, etc.)

- **UI Module (`config/ui.lua`):**
  - Configure lualine with clean, informative status line
  - Set up fidget for LSP progress indication
  - Integrate wal colorscheme with transparent background
  - Remove any conflicting UI elements

- **Editing Module (`config/editing.lua`):**
  - Configure treesitter for syntax highlighting
  - Set up comment plugin for easy code commenting
  - Configure auto-pairs for bracket/quote completion
  - Set up todo-comments for highlighting

**Phase 5: Keybinding System Overhaul (UX Improvement)**
- Design consistent keybinding patterns:
  - `<leader>f*` namespace for find/search operations (Telescope):
    - `<leader>ff` - Find files
    - `<leader>fg` - Live grep (find in files)
    - `<leader>fb` - Find buffers
    - `<leader>fh` - Find help tags
  - `<leader>h*` namespace for Harpoon operations:
    - `<leader>ha` - Add file to Harpoon
    - `<leader>hh` - Toggle Harpoon menu
    - `<leader>h1-4` - Navigate to Harpoon files 1-4
  - `<leader>y` for Yazi file manager
  - `<leader>g*` namespace for Git operations (Fugitive):
    - `<leader>gs` - Git status
    - `<leader>gc` - Git commit
    - `<leader>gp` - Git push
  - `<leader>l*` namespace for LSP operations:
    - `<leader>ld` - Go to definition
    - `<leader>lr` - References
    - `<leader>lf` - Format code
    - `<leader>la` - Code actions
- Remove all conflicting and duplicate keybindings
- Ensure muscle memory preservation for essential operations

**Phase 6: Performance Optimization (Speed Improvements)**
- Configure lazy-loading for all non-essential plugins
- Optimize Telescope configuration for faster file searching
- Set up efficient LSP server startup and management
- Configure minimal startup sequence in `init.lua`
- Remove any performance-impacting configurations

**Phase 7: Testing and Validation (Quality Assurance)**
- Test core workflows:
  - File navigation (Telescope → Harpoon → Yazi)
  - Code editing in Python, Go, and TypeScript projects
  - Git operations with Fugitive
  - LSP functionality (completion, go-to-definition, formatting)
  - Copilot integration
- Verify startup performance improvement
- Test all new keybindings and ensure no conflicts
- Validate transparent background and wal colorscheme integration

**Phase 8: Documentation and Cleanup (Finalization)**
- Update README.md with new streamlined configuration description
- Document new keybinding scheme and workflow patterns
- Create quick reference guide for essential operations
- Remove all unused configuration files
- Clean up any remaining plugin or configuration remnants
- Verify lazy-loading optimization is working correctly

**Additional Notes:**

*Critical Plugins to Preserve (Final List):*
- `nvim-telescope/telescope.nvim` + dependencies
- `ThePrimeagen/harpoon`
- `mikavilpas/yazi.nvim`
- `williamboman/mason.nvim`
- `neovim/nvim-lspconfig`
- `hrsh7th/nvim-cmp` + completion sources
- `zbirenbaum/copilot.lua` + `zbirenbaum/copilot-cmp`
- `tpope/vim-fugitive`
- `nvim-lualine/lualine.nvim`
- `j-hui/fidget.nvim`
- `nvim-treesitter/nvim-treesitter`
- `terrortylor/nvim-comment`
- `folke/todo-comments.nvim`
- `dylanaraps/wal.vim`
- Auto-pairs plugin (to be selected)

*Performance Targets:*
- Startup time reduction: Target 50%+ improvement
- Plugin count reduction: From 40+ to ~15 plugins
- File count reduction: From 39 to ~7 configuration files
- Memory usage optimization through proper lazy-loading

*Workflow Preservation Priorities:*
1. Fast file navigation and search (Telescope)
2. Quick file switching (Harpoon)
3. Efficient file management (Yazi)
4. Seamless LSP integration for development
5. Git workflow continuity
6. AI assistance availability (Copilot)

*Risk Mitigation:*
- Complete backup before any changes
- Incremental implementation with testing at each phase
- Ability to rollback to previous configuration
- Documentation of any breaking changes or workflow adjustments

*Future Extensibility:*
- Modular structure allows easy addition of new features
- Clear separation of concerns enables targeted modifications
- Consistent patterns support easy customization
- Documented keybinding namespaces prevent conflicts

---

**Confirmation Request:**
This comprehensive task document captures the complete vision for streamlining the Neovim configuration. The implementation plan provides a systematic approach to achieve all goals while minimizing risk and preserving essential functionality. 

The task document is now ready for the implementation phase. Please confirm if this accurately reflects your requirements and if any adjustments are needed before proceeding with the actual configuration changes.