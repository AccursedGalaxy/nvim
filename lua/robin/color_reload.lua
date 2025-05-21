-- Functions to reload colors from wal

local M = {}

-- Reload function that refreshes colorscheme and lualine
function M.reload_colors()
  -- Clear highlight cache
  vim.cmd("highlight clear")
  
  -- Force reload of the colors module if it exists
  if package.loaded["robin.lualine_wal_theme"] then
    package.loaded["robin.lualine_wal_theme"] = nil
  end
  
  -- Reload lualine with fresh colors
  require("robin.lualine_wal_theme").setup()
  
  -- Reload colorscheme
  vim.cmd("colorscheme wal")
  
  -- Force UI redraw
  vim.cmd("redraw!")
  
  print("Reloaded wal colors!")
end

-- Initial setup - create user command
function M.setup()
  -- Create a user command :WalReload to refresh colors
  vim.api.nvim_create_user_command("WalReload", function()
    M.reload_colors()
  end, {
    desc = "Reload wal colorscheme and update lualine"
  })
  
  -- Create a shorter alias :WR
  vim.api.nvim_create_user_command("WR", function()
    M.reload_colors()
  end, {
    desc = "Reload wal colorscheme (alias)"
  })
end

return M 