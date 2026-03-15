return {
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VimEnter",
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			dashboard.section.header.val = {
				"    ██████╗██╗   ██╗██████╗ ███████╗███████╗██████╗ ",
				"   ██╔════╝██║   ██║██╔══██╗██╔════╝██╔════╝██╔══██╗",
				"   ██║     ██║   ██║██████╔╝███████╗█████╗  ██║  ██║",
				"   ██║     ██║   ██║██╔══██╗╚════██║██╔══╝  ██║  ██║",
				"   ╚██████╗╚██████╔╝██║  ██║███████║███████╗██████╔╝",
				"    ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚═════╝ ",
				"                Personal Neovim Setup 2026            ",
			}

			dashboard.section.header.opts = { hl = "AlphaHeader", position = "center" }

			dashboard.section.buttons.val = {
				dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("f", "  Find file", "<cmd>Telescope find_files<CR>"),
				dashboard.button("r", "  Recent files", "<cmd>Telescope oldfiles<CR>"),
				dashboard.button("p", "  Find project", "<cmd>Telescope projects<CR>"),
				dashboard.button("c", "  Config", ":e $MYVIMRC <CR>"),
				dashboard.button("l", "󰒲  Lazy", "<cmd>Lazy<CR>"),
				dashboard.button("q", "  Quit", ":qa<CR>"),
			}

			for _, button in ipairs(dashboard.section.buttons.val) do
				button.opts = button.opts or {}
				button.opts.width = 50
				button.opts.position = "center"
			end

			-- Dynamic top padding to vertically center the content
			-- Content: 7 header + 2 pad + 7 buttons + 1 pad + 1 footer = 18 lines
			local content_height = 18
			local top_pad = math.max(math.floor((vim.o.lines - content_height) / 2) - 2, 0)

			dashboard.opts.layout = {
				{ type = "padding", val = top_pad },
				dashboard.section.header,
				{ type = "padding", val = 2 },
				dashboard.section.buttons,
				{ type = "padding", val = 1 },
				dashboard.section.footer,
			}

			alpha.setup(dashboard.opts)

			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					pattern = "AlphaReady",
					callback = function()
						require("lazy").show()
					end,
				})
			end
		end,
	},
}
