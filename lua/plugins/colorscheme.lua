local colors_path = vim.fn.expand("~/.local/state/quickshell/user/generated/neovim_colors.lua")
local colors_dir = vim.fn.expand("~/.local/state/quickshell/user/generated")

local M = {}

--- Load Material You colors from the generated file
---@return table|nil
local function load_colors()
	local ok, colors = pcall(dofile, colors_path)
	if ok and colors then
		return colors
	end
	return nil
end

--- Apply Material You highlight groups
---@param c table color tokens
local function apply_highlights(c)
	local hi = vim.api.nvim_set_hl

	-- Base UI
	hi(0, "Normal", { fg = c.on_background, bg = "NONE" })
	hi(0, "NormalNC", { fg = c.on_background, bg = "NONE" })
	hi(0, "NormalFloat", { fg = c.on_surface, bg = "NONE" })
	hi(0, "EndOfBuffer", { fg = c.surface_container, bg = "NONE" })
	hi(0, "SignColumn", { bg = "NONE" })
	hi(0, "StatusLine", { fg = c.on_surface, bg = "NONE" })
	hi(0, "StatusLineNC", { fg = c.outline, bg = "NONE" })

	-- Cursor & selection
	hi(0, "CursorLine", { bg = "NONE" })
	hi(0, "CursorLineNr", { fg = c.primary, bold = true, bg = "NONE" })
	hi(0, "LineNr", { fg = c.outline_variant })
	hi(0, "Visual", { bg = c.surface_container_high })

	-- Search
	hi(0, "Search", { fg = c.on_primary_container, bg = c.primary_container })
	hi(0, "IncSearch", { fg = c.on_primary, bg = c.primary })
	hi(0, "CurSearch", { fg = c.on_primary, bg = c.primary })

	-- Popup menu
	hi(0, "Pmenu", { fg = c.on_surface, bg = c.surface_container })
	hi(0, "PmenuSel", { fg = c.on_primary_container, bg = c.primary_container })
	hi(0, "PmenuSbar", { bg = c.surface_container_high })
	hi(0, "PmenuThumb", { bg = c.outline })

	-- Floats & borders
	hi(0, "FloatBorder", { fg = c.outline_variant })
	hi(0, "WinSeparator", { fg = c.outline_variant })

	-- Folding
	hi(0, "Folded", { fg = c.on_surface_variant, bg = c.surface_container })
	hi(0, "FoldColumn", { fg = c.outline_variant, bg = "NONE" })

	-- Diff
	hi(0, "DiffAdd", { bg = c.primary_container })
	hi(0, "DiffChange", { bg = c.secondary_container })
	hi(0, "DiffDelete", { fg = c.error, bg = c.error_container })
	hi(0, "DiffText", { bg = c.tertiary_container })

	-- Syntax
	hi(0, "Comment", { fg = c.outline, italic = true })
	hi(0, "Constant", { fg = c.tertiary_fixed_dim })
	hi(0, "String", { fg = c.tertiary })
	hi(0, "Character", { fg = c.tertiary })
	hi(0, "Number", { fg = c.tertiary_fixed_dim })
	hi(0, "Boolean", { fg = c.tertiary_fixed_dim })
	hi(0, "Float", { fg = c.tertiary_fixed_dim })
	hi(0, "Identifier", { fg = c.on_surface })
	hi(0, "Function", { fg = c.primary })
	hi(0, "Statement", { fg = c.secondary })
	hi(0, "Conditional", { fg = c.secondary })
	hi(0, "Repeat", { fg = c.secondary })
	hi(0, "Label", { fg = c.secondary })
	hi(0, "Operator", { fg = c.on_surface_variant })
	hi(0, "Keyword", { fg = c.secondary })
	hi(0, "Exception", { fg = c.error })
	hi(0, "PreProc", { fg = c.secondary_fixed_dim })
	hi(0, "Include", { fg = c.secondary_fixed_dim })
	hi(0, "Define", { fg = c.secondary_fixed_dim })
	hi(0, "Macro", { fg = c.secondary_fixed_dim })
	hi(0, "Type", { fg = c.primary_fixed_dim })
	hi(0, "StorageClass", { fg = c.secondary })
	hi(0, "Structure", { fg = c.primary_fixed_dim })
	hi(0, "Typedef", { fg = c.primary_fixed_dim })
	hi(0, "Special", { fg = c.primary })
	hi(0, "SpecialComment", { fg = c.outline, italic = true })
	hi(0, "Error", { fg = c.error })
	hi(0, "Todo", { fg = c.on_primary_container, bg = c.primary_container, bold = true })
	hi(0, "Underlined", { fg = c.primary, underline = true })
	hi(0, "Title", { fg = c.primary, bold = true })
	hi(0, "Directory", { fg = c.primary })
	hi(0, "NonText", { fg = c.outline_variant })
	hi(0, "SpecialKey", { fg = c.outline_variant })
	hi(0, "MatchParen", { fg = c.on_primary_container, bg = c.primary_container, bold = true })

	-- Diagnostics
	hi(0, "DiagnosticError", { fg = c.error })
	hi(0, "DiagnosticWarn", { fg = c.tertiary })
	hi(0, "DiagnosticInfo", { fg = c.primary })
	hi(0, "DiagnosticHint", { fg = c.outline })
	hi(0, "DiagnosticUnderlineError", { undercurl = true, sp = c.error })
	hi(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = c.tertiary })
	hi(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = c.primary })
	hi(0, "DiagnosticUnderlineHint", { undercurl = true, sp = c.outline })

	-- TreeSitter links
	hi(0, "@variable", { fg = c.on_surface })
	hi(0, "@variable.builtin", { fg = c.secondary })
	hi(0, "@variable.parameter", { fg = c.on_surface_variant })
	hi(0, "@constant", { link = "Constant" })
	hi(0, "@constant.builtin", { fg = c.tertiary_fixed_dim, bold = true })
	hi(0, "@function", { link = "Function" })
	hi(0, "@function.builtin", { fg = c.primary, italic = true })
	hi(0, "@function.call", { fg = c.primary })
	hi(0, "@function.method", { fg = c.primary })
	hi(0, "@function.method.call", { fg = c.primary })
	hi(0, "@keyword", { link = "Keyword" })
	hi(0, "@keyword.return", { fg = c.secondary, bold = true })
	hi(0, "@keyword.function", { fg = c.secondary })
	hi(0, "@keyword.operator", { fg = c.on_surface_variant })
	hi(0, "@string", { link = "String" })
	hi(0, "@string.escape", { fg = c.secondary })
	hi(0, "@type", { link = "Type" })
	hi(0, "@type.builtin", { fg = c.primary_fixed_dim, italic = true })
	hi(0, "@property", { fg = c.on_surface_variant })
	hi(0, "@constructor", { fg = c.primary_fixed_dim })
	hi(0, "@operator", { link = "Operator" })
	hi(0, "@punctuation", { fg = c.on_surface_variant })
	hi(0, "@punctuation.bracket", { fg = c.on_surface_variant })
	hi(0, "@punctuation.delimiter", { fg = c.on_surface_variant })
	hi(0, "@comment", { link = "Comment" })
	hi(0, "@tag", { fg = c.primary })
	hi(0, "@tag.attribute", { fg = c.tertiary })
	hi(0, "@tag.delimiter", { fg = c.on_surface_variant })
	hi(0, "@module", { fg = c.on_surface_variant })
	hi(0, "@number", { link = "Number" })
	hi(0, "@boolean", { link = "Boolean" })

	-- Git signs
	hi(0, "GitSignsAdd", { fg = c.primary })
	hi(0, "GitSignsChange", { fg = c.secondary })
	hi(0, "GitSignsDelete", { fg = c.error })

	-- Telescope
	hi(0, "TelescopeNormal", { fg = c.on_surface, bg = "NONE" })
	hi(0, "TelescopeBorder", { fg = c.outline_variant, bg = "NONE" })
	hi(0, "TelescopeSelection", { bg = c.surface_container_high })
	hi(0, "TelescopeMatching", { fg = c.primary, bold = true })

	-- Trouble
	hi(0, "TroubleNormal", { fg = c.on_surface, bg = "NONE" })
end

--- Apply the Material You colorscheme, or fall back to Everforest
function M.apply()
	local colors = load_colors()
	if colors then
		vim.cmd("hi clear")
		vim.o.termguicolors = true
		apply_highlights(colors)
	else
		-- Fallback: load Everforest
		pcall(function()
			vim.g.everforest_background = "soft"
			vim.g.everforest_better_performance = 1
			vim.cmd.colorscheme("everforest")
			-- Make backgrounds transparent
			for _, group in ipairs({
				"Normal",
				"NormalNC",
				"NormalFloat",
				"CursorLine",
				"CursorLineNr",
				"SignColumn",
				"EndOfBuffer",
				"StatusLine",
				"StatusLineNC",
			}) do
				local hl = vim.api.nvim_get_hl(0, { name = group })
				hl.bg = nil
				hl.ctermbg = nil
				vim.api.nvim_set_hl(0, group, hl)
			end
		end)
	end
end

--- Start watching the generated directory for color changes
local function start_watcher()
	local handle = vim.uv.new_fs_event()
	if not handle then
		return
	end

	handle:start(colors_dir, {}, function(err, filename)
		if err then
			return
		end
		if filename and filename:match("neovim_colors%.lua$") then
			vim.schedule(function()
				-- Clear dofile cache
				package.loaded[colors_path] = nil
				M.apply()
			end)
		end
	end)
end

return {
	"sainnhe/everforest",
	priority = 1000,
	config = function()
		M.apply()
		start_watcher()
	end,
}
