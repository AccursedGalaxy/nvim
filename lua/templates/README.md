# Configuration Templates
## Ready-to-Use Examples for Common Customizations

This directory contains pre-built configuration templates that you can copy and modify to extend your Neovim setup. Each template includes:

- **Clear documentation** of what it does
- **Ready-to-use code** with sensible defaults
- **Integration instructions** for adding to your config
- **Customization examples** for common modifications

## How to Use Templates

1. **Copy** the template you want to use
2. **Rename** it to remove the `.template` extension
3. **Move** it to the appropriate location in your config
4. **Customize** the settings for your needs
5. **Load** it in your `init.lua` if it's a new module

### Example: Adding Language Support

```bash
# Copy the template
cp lua/templates/lsp-language.template.lua lua/config/lsp-python.lua

# Edit the file
:ConfigEdit lsp-python

# Add to init.lua
require("config.lsp-python")
```

## Available Templates

### Language Support
- `lsp-language.template.lua` - Add LSP support for a new programming language
- `treesitter-language.template.lua` - Add syntax highlighting for a language

### UI Customization
- `statusline.template.lua` - Create a custom status line
- `colorscheme.template.lua` - Define custom colors/highlights

### Plugin Integration
- `plugin-basic.template.lua` - Template for simple plugin setup
- `plugin-complex.template.lua` - Template for plugins with complex configuration

### Workflow Enhancement
- `keybindings.template.lua` - Add custom keybindings for a feature
- `autocmds.template.lua` - Create custom autocommands

## Template Structure

Each template follows this structure:
```lua
-- ============================================================================
-- FEATURE NAME
-- ============================================================================
-- Description: What this template does
-- Dependencies: What plugins/other configs are required
-- Usage: How to integrate this into your config

-- Configuration goes here
-- ...

return M  -- or setup function
```

## Contributing Templates

To add a new template:
1. Create your template file with `.template.lua` extension
2. Add clear documentation at the top
3. Include usage examples
4. Update this README
5. Test the template works

## Tips

- **Start simple**: Begin with basic templates and add complexity as needed
- **Test incrementally**: Use `:ConfigReload` to test changes
- **Backup first**: Use `:ConfigBackup` before major changes
- **Check health**: Use `:ConfigHealth` to verify everything loads correctly
