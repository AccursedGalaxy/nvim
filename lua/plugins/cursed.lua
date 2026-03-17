-- Use local dev copy if present, otherwise pull from GitHub.
-- Others cloning this config will get the release automatically:
--   https://github.com/AccursedGalaxy/cursed.nvim
local dev_path = vim.fn.expand("~/Projects/cursed.nvim")
local use_dev = vim.fn.isdirectory(dev_path) == 1

local spec = {
	lazy = false,
	config = function()
		local cursed = require("cursed")

		cursed.setup({
			-- Transport
			backend = "tmux",
			tmux = {
				pane_target = "{left}", -- any tmux target-pane: "{left}", "{right}", "%3", "session:1.0"
				auto_submit = true, -- true  → paste + Enter (Claude starts immediately)
				-- false → paste only (go to pane, edit, press Enter yourself)
				paste_delay_ms = 300, -- ms between paste and Enter; increase on slow machines or large diagnostics
			},

			-- What to collect
			scope = "buffer", -- "buffer" | "all_buffers" | "workspace"
			min_severity = vim.diagnostic.severity.HINT, -- HINT=4 INFO=3 WARN=2 ERROR=1

			-- How to format
			format = "with_source_lines", -- "default" | "compact" | "with_source_lines"
			-- or function(diag, bufnr) -> string|nil

			-- Prompt templates
			-- Use {diagnostics} as the placeholder for the formatted block.
			-- Pass a template name as the arg to :CursedSendDiags, e.g. :CursedSendDiags explain
			-- Selection templates are used with :CursedSendSelection, e.g. :CursedSendSelection review
			templates = {
				fix = "Please fix these diagnostics:\n\n{diagnostics}",
				explain = "Explain these diagnostics:\n\n{diagnostics}",
				test = "Write tests that cover these diagnostics:\n\n{diagnostics}",
				fix_selection = "Please fix the following code:\n\n{diagnostics}",
				explain_selection = "Explain the following code:\n\n{diagnostics}",
				review = "Review the following code and suggest improvements:\n\n{diagnostics}",
			},
			default_template = "fix", -- applied automatically on every send; nil to disable

			-- Auto-send on DiagnosticChanged
			auto_send = {
				enabled = false, -- flip to true to enable
				event = "DiagnosticChanged",
				debounce_ms = 500, -- wait this long after the last event
				min_severity = vim.diagnostic.severity.ERROR, -- only trigger on errors
				scope = "buffer",
			},

			-- Keymaps
			-- Set any value to false to disable, or a string to remap.
			keymaps = {
				send = "<leader>cd", -- send diagnostics (global normal-mode)
				send_selection = "<leader>cs", -- send visual selection (visual mode)
				preview_send = "<CR>", -- inside :CursedPreview: confirm & send
				preview_close = "q", -- inside :CursedPreview: close without sending
				preview_close_esc = "<Esc>", -- inside :CursedPreview: close without sending
			},

			-- Pre-send command
			-- Sends a command to the pane *before* pasting diagnostics.
			-- Typical use: "/clear" resets Claude's context so history doesn't accumulate.
			-- command = nil disables the feature entirely.
			-- Per-feature keys: nil = follow global, false = suppress for that feature only.
			pre_send = {
				command = nil, -- sent to the pane before every send
				delay_ms = 300, -- ms to wait after the command before pasting
				-- send      = nil,     -- nil: follows global (sends /clear)
				-- auto_send = false,   -- false: suppress /clear on auto-send to reduce noise
				-- preview   = nil,     -- nil: follows global
				-- pick      = nil,     -- nil: follows global
				-- selection = nil,     -- nil: follows global
			},
		})

		-- send_command keymaps
		-- send_command(text, opts?) sends any raw string to the configured tmux pane.
		-- Useful for triggering Claude Code slash commands without leaving Neovim.
		-- opts: { pane_target = "...", auto_submit = true|false }

		-- Send /clear manually (separate from pre_send — useful on demand)
		vim.keymap.set("n", "<leader>cC", function()
			cursed.send_command("/clear")
		end, { desc = "Clear Claude Code context" })

		-- Prompt for any command interactively
		vim.keymap.set("n", "<leader>c:", function()
			vim.ui.input({ prompt = "Claude> " }, function(input)
				if input and input ~= "" then
					cursed.send_command(input)
				end
			end)
		end, { desc = "Send arbitrary command to Claude Code" })
	end,
}

if use_dev then
	spec.dir = dev_path
	spec.name = "cursed.nvim"
else
	spec[1] = "AccursedGalaxy/cursed.nvim"
end

return spec
