return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {
		ensure_installed = {
			"lua",
			"python",
			"go",
			"typescript",
			"javascript",
			"tsx",
			"bash",
			"json",
			"yaml",
			"toml",
			"markdown",
			"markdown_inline",
			"html",
			"css",
			"vim",
			"vimdoc",
			"query",
		},
		sync_install = false,
		auto_install = true,
		highlight = {
			enable = true,
			disable = function(_, buf)
				local max_filesize = 500 * 1024 -- 500 KB
				local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then
					return true
				end
			end,
		},
		indent = { enable = true },
	},
}
