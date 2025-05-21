-- Custom lualine theme that reads pywal colors from cache
local M = {}

function M.get_wal_colors()
  local colors_path = vim.fn.expand('~/.cache/wal/colors.lua')
  local ok, wal_colors = pcall(dofile, colors_path)
  
  if not ok then
    -- Fallback to basic colors if wal colors aren't available
    return {
      color0 = "#000000",
      color1 = "#800000",
      color2 = "#008000",
      color3 = "#808000",
      color4 = "#000080",
      color5 = "#800080",
      color6 = "#008080",
      color7 = "#c0c0c0",
      color8 = "#808080",
      color9 = "#ff0000",
      color10 = "#00ff00",
      color11 = "#ffff00",
      color12 = "#0000ff",
      color13 = "#ff00ff",
      color14 = "#00ffff",
      color15 = "#ffffff",
      background = "#000000",
      foreground = "#ffffff",
    }
  end
  
  return wal_colors
end

function M.generate_theme()
  local colors = M.get_wal_colors()
  
  return {
    normal = {
      a = { bg = colors.color4, fg = colors.color0, gui = 'bold' },
      b = { bg = colors.color8, fg = colors.color7 },
      c = { bg = colors.color0, fg = colors.color7 }
    },
    insert = {
      a = { bg = colors.color2, fg = colors.color0, gui = 'bold' },
      b = { bg = colors.color8, fg = colors.color7 },
      c = { bg = colors.color0, fg = colors.color7 }
    },
    visual = {
      a = { bg = colors.color3, fg = colors.color0, gui = 'bold' },
      b = { bg = colors.color8, fg = colors.color7 },
      c = { bg = colors.color0, fg = colors.color7 }
    },
    replace = {
      a = { bg = colors.color1, fg = colors.color0, gui = 'bold' },
      b = { bg = colors.color8, fg = colors.color7 },
      c = { bg = colors.color0, fg = colors.color7 }
    },
    command = {
      a = { bg = colors.color5, fg = colors.color0, gui = 'bold' },
      b = { bg = colors.color8, fg = colors.color7 },
      c = { bg = colors.color0, fg = colors.color7 }
    },
    inactive = {
      a = { bg = colors.color8, fg = colors.color7, gui = 'bold' },
      b = { bg = colors.color8, fg = colors.color7 },
      c = { bg = colors.color0, fg = colors.color8 }
    }
  }
end

-- Setup or reload function to be called when wal colors change
function M.setup()
  local lualine_ok, lualine = pcall(require, 'lualine')
  if lualine_ok then
    lualine.setup({
      options = {
        theme = M.generate_theme(),
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {},
        always_divide_middle = true,
      },
      -- Rest of your lualine config...
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", { "diagnostics", sources = { "nvim_diagnostic" } } },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = {},
    })
  end
end

return M 