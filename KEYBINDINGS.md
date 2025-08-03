# Neovim Keybindings Reference

## Leader Key
- **Leader**: `<Space>`

## Navigation (`<leader>f*` - Find/Search)
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>ff` | Find Files | Fuzzy find files in project |
| `<leader>fg` | Live Grep | Search text across all files (literal search) |
| `<leader>fr` | Regex Grep | Search with regex patterns |
| `<leader>fb` | Find Buffers | Search through open buffers |
| `<leader>fh` | Find Help | Search help documentation |
| `<C-p>` | Git Files | Find files tracked by Git |
| `<leader>pf` | Project Files | Find files in current directory |

## Harpoon (`<leader>h*` - Quick Navigation)
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>ha` | Add File | Add current file to Harpoon |
| `<leader>hh` | Toggle Menu | Show/hide Harpoon quick menu |
| `<leader>h1` | File 1 | Navigate to Harpoon file 1 |
| `<leader>h2` | File 2 | Navigate to Harpoon file 2 |
| `<leader>h3` | File 3 | Navigate to Harpoon file 3 |
| `<leader>h4` | File 4 | Navigate to Harpoon file 4 |
| `<C-S-P>` | Previous | Navigate to previous Harpoon file |
| `<C-S-N>` | Next | Navigate to next Harpoon file |

## LSP (`<leader>l*` - Language Server)
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>ld` | Go to Definition | Jump to symbol definition |
| `<leader>lr` | References | Find all references |
| `<leader>lh` | Hover | Show hover information |
| `<leader>li` | Implementation | Go to implementation |
| `<leader>ls` | Signature Help | Show function signature |
| `<leader>lt` | Type Definition | Go to type definition |
| `<leader>la` | Code Actions | Show available code actions |
| `<leader>lf` | Format | Format current buffer |
| `<leader>lR` | Rename | Rename symbol |
| `<leader>le` | Diagnostics | Show line diagnostics |
| `<leader>lq` | Quickfix | Load diagnostics to quickfix |
| `[d` | Previous Diagnostic | Go to previous diagnostic |
| `]d` | Next Diagnostic | Go to next diagnostic |

## Git (`<leader>g*` - Git Operations)
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>gs` | Git Status | Open Git status |
| `<leader>gc` | Git Commit | Open commit interface |
| `<leader>gp` | Git Push | Push changes |
| `<leader>gl` | Git Pull | Pull changes |
| `<leader>ga` | Git Add All | Stage all changes |
| `<leader>gb` | Git Blame | Show git blame |
| `<leader>gd` | Git Diff | Show diff in split |
| `<leader>gh` | Git History | Show git log |

## File Management
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>y` | Yazi | Open Yazi file manager |

## General Editing
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>q` | Quit | Quit current buffer |
| `<leader>w` | Select Word | Select current word |
| `<leader><leader>` | Clear Search | Clear search highlighting |
| `<leader>sv` | Split Vertical | Create vertical split |
| `<leader>sh` | Split Horizontal | Create horizontal split |
| `<leader>rr` | Find & Replace | Find and replace in buffer |

## Text Manipulation
| Key | Action | Description |
|-----|--------|-------------|
| `H` | Line Start | Move to beginning of line |
| `L` | Line End | Move to end of line |
| `K` | File Start | Move to beginning of file |
| `J` | File End | Move to end of file |
| `gcc` | Comment Line | Toggle line comment |
| `gc` (visual) | Comment Selection | Toggle comment on selection |

## Visual Mode
| Key | Action | Description |
|-----|--------|-------------|
| `<` | Outdent | Decrease indentation (stay in visual) |
| `>` | Indent | Increase indentation (stay in visual) |
| `<C-j>` | Move Down | Move selection down |
| `<C-k>` | Move Up | Move selection up |

## Completion (Insert Mode)
| Key | Action | Description |
|-----|--------|-------------|
| `<Tab>` | Next Item | Select next completion item |
| `<S-Tab>` | Previous Item | Select previous completion item |
| `<CR>` | Confirm | Accept selected completion |
| `<C-Space>` | Trigger | Manually trigger completion |
| `<C-e>` | Abort | Close completion menu |
| `<C-b>` | Scroll Up | Scroll docs up |
| `<C-f>` | Scroll Down | Scroll docs down |
