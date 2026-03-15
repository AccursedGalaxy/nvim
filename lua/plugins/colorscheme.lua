return {
  "sainnhe/everforest",
  priority = 1000, -- load first
  config = function()
    vim.g.everforest_background = "soft" -- hard, medium, soft
    vim.g.everforest_better_performance = 1
    vim.cmd.colorscheme("everforest")
    -- Make background transparent to match terminal opacity
    vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE", ctermbg = "NONE" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE", ctermbg = "NONE" })
  end,
}
