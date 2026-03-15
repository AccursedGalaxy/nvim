<div align="center">

```
███╗   ██╗██╗   ██╗██╗███╗   ███╗
████╗  ██║██║   ██║██║████╗ ████║
██╔██╗ ██║██║   ██║██║██╔████╔██║
██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
```

*a minimal, fast neovim configuration*

![Lua](https://img.shields.io/badge/Lua-2C2D72?style=flat-square&logo=lua&logoColor=white)
![Neovim](https://img.shields.io/badge/Neovim-0.10+-57A143?style=flat-square&logo=neovim&logoColor=white)
![License](https://img.shields.io/badge/license-MIT-green?style=flat-square)

</div>

---

## Philosophy

No bloat. No abstractions for their own sake. Every plugin earns its place.

---

## Structure

```
nvim/
├── init.lua              ← entry point
└── lua/
    ├── core/
    │   ├── options.lua   ← editor settings
    │   └── keymaps.lua   ← global bindings
    ├── config/
    │   └── lazy.lua      ← plugin manager bootstrap
    └── plugins/          ← one file per plugin
```

---

## Plugins

| Plugin | Purpose |
|--------|---------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager |
| [everforest](https://github.com/sainnhe/everforest) | Colorscheme (soft, transparent bg) |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP client configuration |
| [mason.nvim](https://github.com/mason-org/mason.nvim) | LSP/tool installer |
| [blink.nvim](https://github.com/saghen/blink.cmp) | Completion |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder |
| [harpoon](https://github.com/ThePrimeagen/harpoon) | Per-project file marks |
| [treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax & parsing |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Format on save |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git gutter + hunk ops |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | Diagnostics UI |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Statusline |
| [lazydev.nvim](https://github.com/folke/lazydev.nvim) | Neovim API completion for Lua |
| [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) | Seamless tmux/nvim splits |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Bracket pairing |

---

## Keybindings

**Leader:** `<Space>`

### Navigation
| Key | Action |
|-----|--------|
| `<S-h>` / `<S-l>` | Line start / end |
| `<S-j>` / `<S-k>` | File bottom / top |
| `<leader>pv` | File explorer (netrw) |

### Find
| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |

### Harpoon
| Key | Action |
|-----|--------|
| `<C-a>` | Mark file |
| `<leader>hh` | Toggle menu |
| `<leader>hf` | Telescope menu |
| `<C-s/t/n/p>` | Jump to slot 1–4 |

### LSP
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `<leader>lh` | Hover docs |

### Git
| Key | Action |
|-----|--------|
| `]g` / `[g` | Next / prev hunk |
| `<leader>gp` | Preview hunk |
| `<leader>gb` | Blame line |

### Diagnostics
| Key | Action |
|-----|--------|
| `<leader>xx` | Diagnostics (all) |
| `<leader>xX` | Diagnostics (buffer) |
| `<leader>cs` | Symbols |
| `<leader>cl` | LSP references panel |

---

## LSP Languages

```
lua · python · go · typescript · javascript
```

Installed and managed via Mason. Formatters configured in `conform.nvim`.

---

## Requirements

- Neovim **0.11+**
- `git`, `make`, `rg`, `fd` (for telescope-fzf-native)
- Language servers auto-installed via Mason on first launch

---

<div align="center">

*built for [Arch Linux](https://archlinux.org) + [Hyprland](https://hyprland.org) + [Kitty](https://sw.kovidgoyal.net/kitty/)*

</div>
