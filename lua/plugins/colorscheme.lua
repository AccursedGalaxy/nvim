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

-- ── Color manipulation ──────────────────────────────────────────────

--- Convert hex to RGB (0-1)
local function hex_to_rgb(hex)
	hex = hex:gsub("#", "")
	return tonumber(hex:sub(1, 2), 16) / 255, tonumber(hex:sub(3, 4), 16) / 255, tonumber(hex:sub(5, 6), 16) / 255
end

--- Convert RGB (0-1) to hex
local function rgb_to_hex(r, g, b)
	return string.format(
		"#%02x%02x%02x",
		math.floor(r * 255 + 0.5),
		math.floor(g * 255 + 0.5),
		math.floor(b * 255 + 0.5)
	)
end

--- RGB (0-1) → HSL (h: 0-360, s/l: 0-1)
local function rgb_to_hsl(r, g, b)
	local max, min = math.max(r, g, b), math.min(r, g, b)
	local l = (max + min) / 2
	if max == min then
		return 0, 0, l
	end
	local d = max - min
	local s = l > 0.5 and d / (2 - max - min) or d / (max + min)
	local h
	if max == r then
		h = (g - b) / d + (g < b and 6 or 0)
	elseif max == g then
		h = (b - r) / d + 2
	else
		h = (r - g) / d + 4
	end
	return h * 60, s, l
end

--- HSL → RGB (0-1)
local function hsl_to_rgb(h, s, l)
	if s == 0 then
		return l, l, l
	end
	local function hue2rgb(p, q, t)
		if t < 0 then
			t = t + 1
		end
		if t > 1 then
			t = t - 1
		end
		if t < 1 / 6 then
			return p + (q - p) * 6 * t
		end
		if t < 1 / 2 then
			return q
		end
		if t < 2 / 3 then
			return p + (q - p) * (2 / 3 - t) * 6
		end
		return p
	end
	local q = l < 0.5 and l * (1 + s) or l + s - l * s
	local p = 2 * l - q
	local hn = h / 360
	return hue2rgb(p, q, hn + 1 / 3), hue2rgb(p, q, hn), hue2rgb(p, q, hn - 1 / 3)
end

--- Gently boost saturation and lightness for syntax visibility on dark bg
--- while preserving the natural feel of the M3 palette.
---@param hex string input color
---@param sat_boost number how much to add to saturation (0-1), clamped at 1
---@param l_floor number minimum lightness to ensure readability
local function enliven(hex, sat_boost, l_floor)
	local r, g, b = hex_to_rgb(hex)
	local h, s, l = rgb_to_hsl(r, g, b)
	s = math.min(s + sat_boost, 1.0)
	l = math.max(l, l_floor)
	r, g, b = hsl_to_rgb(h, s, l)
	return rgb_to_hex(r, g, b)
end

--- Shift hue by degrees, keeping saturation and lightness
local function hue_shift(hex, degrees)
	local r, g, b = hex_to_rgb(hex)
	local h, s, l = rgb_to_hsl(r, g, b)
	h = (h + degrees) % 360
	r, g, b = hsl_to_rgb(h, s, l)
	return rgb_to_hex(r, g, b)
end

--- Shortest angular distance between two hues
local function hue_diff(a, b)
	local d = math.abs(a - b)
	return d > 180 and 360 - d or d
end

-- ── Syntax palette builder ──────────────────────────────────────────

--- Build vibrant, well-separated syntax colors from M3 tokens.
--- M3 dark-scheme colors are intentionally desaturated for UI surfaces,
--- but syntax highlighting needs vivid, distinct colors. This function:
---  1. Boosts saturation of primary/secondary/tertiary
---  2. Ensures ≥40° hue separation between the three roles
---  3. Derives dim variants for secondary roles (types, constants)
local function build_syntax_palette(c)
	local p = {}
	for k, v in pairs(c) do
		p[k] = v
	end

	local pr, pg, pb = hex_to_rgb(c.primary)
	local base_h, base_s = rgb_to_hsl(pr, pg, pb)

	local sr, sg, sb = hex_to_rgb(c.secondary)
	local sec_h = rgb_to_hsl(sr, sg, sb)

	local tr, tg, tb = hex_to_rgb(c.tertiary)
	local ter_h = rgb_to_hsl(tr, tg, tb)

	-- Primary — gentle saturation nudge, ensure readable lightness
	p.v_primary = enliven(c.primary, 0.15, 0.65)

	-- Secondary — rotate hue only if truly indistinguishable from primary
	if hue_diff(base_h, sec_h) < 30 and base_s < 0.12 then
		p.v_secondary = enliven(hue_shift(c.primary, 120), 0.15, 0.65)
	else
		p.v_secondary = enliven(c.secondary, 0.15, 0.65)
	end

	-- Tertiary — rotate only when palette is genuinely monochromatic
	local vsr, vsg, vsb = hex_to_rgb(p.v_secondary)
	local v_sec_h = rgb_to_hsl(vsr, vsg, vsb)
	if (hue_diff(base_h, ter_h) < 30 and base_s < 0.12) or hue_diff(v_sec_h, ter_h) < 25 then
		p.v_tertiary = enliven(hue_shift(c.primary, 240), 0.15, 0.65)
	else
		p.v_tertiary = enliven(c.tertiary, 0.15, 0.65)
	end

	-- Dim variants — slightly muted for subordinate roles (types, constants)
	p.v_primary_dim = enliven(c.primary_fixed_dim, 0.10, 0.55)
	p.v_secondary_dim = enliven(c.secondary_fixed_dim, 0.10, 0.55)
	p.v_tertiary_dim = enliven(c.tertiary_fixed_dim, 0.10, 0.55)

	return p
end

-- ── Highlights ──────────────────────────────────────────────────────

local function apply_highlights(c)
	local hi = vim.api.nvim_set_hl

	-- Base UI — keep transparent backgrounds
	hi(0, "Normal", { fg = c.on_background, bg = "NONE" })
	hi(0, "NormalNC", { fg = c.on_background, bg = "NONE" })
	hi(0, "NormalFloat", { fg = c.on_surface, bg = c.surface_container })
	hi(0, "EndOfBuffer", { fg = c.surface_container, bg = "NONE" })
	hi(0, "SignColumn", { bg = "NONE" })
	hi(0, "StatusLine", { fg = c.on_surface, bg = "NONE" })
	hi(0, "StatusLineNC", { fg = c.outline, bg = "NONE" })

	-- Cursor & selection
	hi(0, "CursorLine", { bg = "NONE" })
	hi(0, "CursorLineNr", { fg = c.v_primary, bold = true, bg = "NONE" })
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

	-- ── Syntax (using vibrant palette) ──────────────────────────────
	-- v_primary   → functions, tags, specials
	-- v_secondary → keywords, statements, control flow
	-- v_tertiary  → strings, literals, constants
	hi(0, "Comment", { fg = c.outline, italic = true })
	hi(0, "Constant", { fg = c.v_tertiary_dim })
	hi(0, "String", { fg = c.v_tertiary })
	hi(0, "Character", { fg = c.v_tertiary })
	hi(0, "Number", { fg = c.v_tertiary_dim })
	hi(0, "Boolean", { fg = c.v_tertiary_dim, bold = true })
	hi(0, "Float", { fg = c.v_tertiary_dim })
	hi(0, "Identifier", { fg = c.on_surface })
	hi(0, "Function", { fg = c.v_primary, bold = true })
	hi(0, "Statement", { fg = c.v_secondary })
	hi(0, "Conditional", { fg = c.v_secondary })
	hi(0, "Repeat", { fg = c.v_secondary })
	hi(0, "Label", { fg = c.v_secondary })
	hi(0, "Operator", { fg = c.on_surface_variant })
	hi(0, "Keyword", { fg = c.v_secondary })
	hi(0, "Exception", { fg = c.error })
	hi(0, "PreProc", { fg = c.v_secondary_dim })
	hi(0, "Include", { fg = c.v_secondary_dim })
	hi(0, "Define", { fg = c.v_secondary_dim })
	hi(0, "Macro", { fg = c.v_secondary_dim, bold = true })
	hi(0, "Type", { fg = c.v_primary_dim })
	hi(0, "StorageClass", { fg = c.v_secondary })
	hi(0, "Structure", { fg = c.v_primary_dim, bold = true })
	hi(0, "Typedef", { fg = c.v_primary_dim })
	hi(0, "Special", { fg = c.v_primary })
	hi(0, "SpecialComment", { fg = c.outline, italic = true })
	hi(0, "Error", { fg = c.error })
	hi(0, "Todo", { fg = c.on_primary_container, bg = c.primary_container, bold = true })
	hi(0, "Underlined", { fg = c.v_primary, underline = true })
	hi(0, "Title", { fg = c.v_primary, bold = true })
	hi(0, "Directory", { fg = c.v_primary })
	hi(0, "NonText", { fg = c.outline_variant })
	hi(0, "SpecialKey", { fg = c.outline_variant })
	hi(0, "MatchParen", { fg = c.on_primary_container, bg = c.primary_container, bold = true })

	-- Diagnostics
	hi(0, "DiagnosticError", { fg = c.error })
	hi(0, "DiagnosticWarn", { fg = c.v_tertiary })
	hi(0, "DiagnosticInfo", { fg = c.v_primary })
	hi(0, "DiagnosticHint", { fg = c.outline })
	hi(0, "DiagnosticUnderlineError", { undercurl = true, sp = c.error })
	hi(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = c.v_tertiary })
	hi(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = c.v_primary })
	hi(0, "DiagnosticUnderlineHint", { undercurl = true, sp = c.outline })

	-- ── TreeSitter ──────────────────────────────────────────────────
	hi(0, "@variable", { fg = c.on_surface })
	hi(0, "@variable.builtin", { fg = c.v_secondary })
	hi(0, "@variable.parameter", { fg = c.on_surface_variant })
	hi(0, "@constant", { link = "Constant" })
	hi(0, "@constant.builtin", { fg = c.v_tertiary_dim, bold = true })
	hi(0, "@function", { link = "Function" })
	hi(0, "@function.builtin", { fg = c.v_primary, bold = true })
	hi(0, "@function.call", { fg = c.v_primary })
	hi(0, "@function.method", { fg = c.v_primary })
	hi(0, "@function.method.call", { fg = c.v_primary })
	hi(0, "@keyword", { link = "Keyword" })
	hi(0, "@keyword.return", { fg = c.v_secondary, bold = true })
	hi(0, "@keyword.function", { fg = c.v_secondary })
	hi(0, "@keyword.operator", { fg = c.on_surface_variant })
	hi(0, "@string", { link = "String" })
	hi(0, "@string.escape", { fg = c.v_secondary, bold = true })
	hi(0, "@type", { link = "Type" })
	hi(0, "@type.builtin", { fg = c.v_primary_dim })
	hi(0, "@property", { fg = c.on_surface_variant })
	hi(0, "@constructor", { fg = c.v_primary_dim })
	hi(0, "@operator", { link = "Operator" })
	hi(0, "@punctuation", { fg = c.on_surface_variant })
	hi(0, "@punctuation.bracket", { fg = c.on_surface_variant })
	hi(0, "@punctuation.delimiter", { fg = c.on_surface_variant })
	hi(0, "@comment", { link = "Comment" })
	hi(0, "@tag", { fg = c.v_primary })
	hi(0, "@tag.attribute", { fg = c.v_tertiary })
	hi(0, "@tag.delimiter", { fg = c.on_surface_variant })
	hi(0, "@module", { fg = c.on_surface_variant })
	hi(0, "@number", { link = "Number" })
	hi(0, "@boolean", { link = "Boolean" })

	-- Git signs
	hi(0, "GitSignsAdd", { fg = c.v_primary })
	hi(0, "GitSignsChange", { fg = c.v_secondary })
	hi(0, "GitSignsDelete", { fg = c.error })

	-- Telescope
	hi(0, "TelescopeNormal", { fg = c.on_surface, bg = "NONE" })
	hi(0, "TelescopeBorder", { fg = c.outline_variant, bg = "NONE" })
	hi(0, "TelescopeSelection", { bg = c.surface_container_high })
	hi(0, "TelescopeMatching", { fg = c.v_primary, bold = true })

	-- Trouble
	hi(0, "TroubleNormal", { fg = c.on_surface, bg = "NONE" })

	-- Alpha (dashboard)
	hi(0, "AlphaHeader", { fg = c.v_primary })
	hi(0, "AlphaButtons", { fg = c.on_surface })
	hi(0, "AlphaShortcut", { fg = c.v_secondary })
	hi(0, "AlphaFooter", { fg = c.outline, italic = true })

	-- Blink.cmp (completion)
	hi(0, "BlinkCmpMenu", { fg = c.on_surface, bg = c.surface_container })
	hi(0, "BlinkCmpMenuBorder", { fg = c.outline_variant, bg = c.surface_container })
	hi(0, "BlinkCmpMenuSelection", { bg = c.primary_container, fg = c.on_primary_container })
	hi(0, "BlinkCmpLabel", { fg = c.on_surface })
	hi(0, "BlinkCmpLabelMatch", { fg = c.v_primary, bold = true })
	hi(0, "BlinkCmpLabelDescription", { fg = c.outline })
	hi(0, "BlinkCmpKind", { fg = c.v_secondary })
	hi(0, "BlinkCmpDoc", { fg = c.on_surface, bg = c.surface_container })
	hi(0, "BlinkCmpDocBorder", { fg = c.outline_variant, bg = c.surface_container })
	hi(0, "BlinkCmpSignatureHelp", { fg = c.on_surface, bg = c.surface_container })
	hi(0, "BlinkCmpSignatureHelpBorder", { fg = c.outline_variant, bg = c.surface_container })

	-- Mason
	hi(0, "MasonNormal", { fg = c.on_surface, bg = c.surface_container })
	hi(0, "MasonHeader", { fg = c.on_primary, bg = c.primary, bold = true })
	hi(0, "MasonHeaderSecondary", { fg = c.on_secondary, bg = c.secondary, bold = true })
	hi(0, "MasonHighlight", { fg = c.v_primary })
	hi(0, "MasonHighlightBlock", { fg = c.on_primary, bg = c.primary })
	hi(0, "MasonHighlightBlockBold", { fg = c.on_primary, bg = c.primary, bold = true })
	hi(0, "MasonMuted", { fg = c.outline })
	hi(0, "MasonMutedBlock", { fg = c.on_surface_variant, bg = c.surface_container_high })

	-- Render-markdown
	hi(0, "RenderMarkdownH1Bg", { bg = c.primary_container, fg = c.on_primary_container, bold = true })
	hi(0, "RenderMarkdownH2Bg", { bg = c.secondary_container, fg = c.on_secondary_container, bold = true })
	hi(0, "RenderMarkdownH3Bg", { bg = c.tertiary_container, fg = c.on_tertiary_container, bold = true })
	hi(0, "RenderMarkdownH4Bg", { bg = c.surface_container_high, fg = c.on_surface, bold = true })
	hi(0, "RenderMarkdownH5Bg", { bg = c.surface_container_high, fg = c.on_surface })
	hi(0, "RenderMarkdownH6Bg", { bg = c.surface_container, fg = c.on_surface_variant })
	hi(0, "RenderMarkdownCode", { bg = c.surface_container })
	hi(0, "RenderMarkdownCodeInline", { bg = c.surface_container_high })

	-- Harpoon
	hi(0, "HarpoonWindow", { fg = c.on_surface, bg = "NONE" })
	hi(0, "HarpoonBorder", { fg = c.outline_variant, bg = "NONE" })

	-- LSP floating windows
	hi(0, "LspInfoBorder", { fg = c.outline_variant })
end

--- Apply the Material You colorscheme, or fall back to Everforest
function M.apply()
	local colors = load_colors()
	if colors then
		vim.cmd("hi clear")
		vim.o.termguicolors = true
		local palette = build_syntax_palette(colors)
		apply_highlights(palette)
		vim.o.pumblend = 20
		-- Make floating windows semi-transparent to match the transparent look
		vim.api.nvim_create_autocmd("WinNew", {
			group = vim.api.nvim_create_augroup("FloatBlend", { clear = true }),
			callback = function()
				local win = vim.api.nvim_get_current_win()
				local cfg = vim.api.nvim_win_get_config(win)
				if cfg.relative ~= "" then
					vim.wo[win].winblend = 20
				end
			end,
		})
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
				package.loaded[colors_path] = nil
				M.apply()
				vim.api.nvim_exec_autocmds("User", { pattern = "MaterialYouReload" })
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
