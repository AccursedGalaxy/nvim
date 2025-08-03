-- Editing module: comment, auto-pairs, todo-comments, treesitter

-- Treesitter Configuration
require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"lua",
		"python",
		"go",
		"typescript",
		"javascript",
		"tsx",
		"json",
		"yaml",
		"toml",
		"markdown",
		"bash",
		"vim",
		"regex",
		"markdown_inline",
	},
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		disable = function(lang, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
	},
})

-- Comment Configuration
require("nvim_comment").setup({
	marker_padding = true,
	comment_empty = true,
	comment_empty_trim_whitespace = true,
	create_mappings = true,
	line_mapping = "gcc",
	operator_mapping = "gc",
	comment_chunk_text_object = "ic",
})

-- Todo Comments Configuration
require("todo-comments").setup({
	signs = true,
	sign_priority = 8,
	keywords = {
		FIX = {
			icon = " ",
			color = "error",
			alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
		},
		TODO = { icon = " ", color = "info" },
		HACK = { icon = " ", color = "warning" },
		WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
		PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
		NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
		TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
	},
	gui_style = {
		fg = "NONE",
		bg = "BOLD",
	},
	merge_keywords = true,
	highlight = {
		multiline = true,
		multiline_pattern = "^.",
		multiline_context = 10,
		before = "",
		keyword = "wide",
		after = "fg",
		pattern = [[.*<(KEYWORDS)\s*:]],
		comments_only = true,
		max_line_len = 400,
		exclude = {},
	},
	colors = {
		error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
		warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
		info = { "DiagnosticInfo", "#2563EB" },
		hint = { "DiagnosticHint", "#10B981" },
		default = { "Identifier", "#7C3AED" },
		test = { "Identifier", "#FF006E" }
	},
	search = {
		command = "rg",
		args = {
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
		},
		pattern = [[\b(KEYWORDS):]], -- ripgrep regex
	},
})

-- Auto-pairs configuration is handled by the plugin setup in plugins/init.lua