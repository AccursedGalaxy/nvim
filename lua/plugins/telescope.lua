return {
	"nvim-telescope/telescope.nvim",
	version = "*",
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
		{
			"<leader>fg",
			function()
				require("telescope.builtin").live_grep({
					additional_args = {
						"--glob",
						"!**/*test*",
						"--glob",
						"!**/*spec*",
					},
				})
			end,
			desc = "Live grep (no tests)",
		},
		{ "<leader>fG", "<cmd>Telescope live_grep<cr>", desc = "Live grep (all files)" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- optional but recommended
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		local actions = require("telescope.actions")
		require("telescope").setup({
			defaults = {
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
					},
				},
			},
		})
		pcall(require("telescope").load_extension, "fzf")
	end,
}
