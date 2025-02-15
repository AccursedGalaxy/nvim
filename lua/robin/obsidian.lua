require("obsidian").setup({
	workspaces = {
		{
			name = "new",
			path = "~/vaults/new",
		},
		-- Add more workspaces as needed
	},

	-- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp
	completion = {
		nvim_cmp = true,
		min_chars = 2,
	},

	-- Optional, configure key mappings
	mappings = {
		-- Toggle check-boxes
		["<leader>ch"] = {
			action = function()
				return require("obsidian").util.toggle_checkbox()
			end,
			opts = { buffer = true },
		},
	},

	-- Optional, customize how names/IDs for new notes are created
	note_id_func = function(title)
		-- Create note IDs in a Zettelkasten format with a timestamp and a suffix
		local suffix = ""
		if title ~= nil then
			-- If title is given, transform it into valid file name
			suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
		else
			-- If title is nil, just add 4 random uppercase letters
			for _ = 1, 4 do
				suffix = suffix .. string.char(math.random(65, 90))
			end
		end
		return tostring(os.time()) .. "-" .. suffix
	end,

	-- Optional, set to true if you use the Obsidian Advanced URI plugin
	use_advanced_uri = false,

	-- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground
	open_app_foreground = false,

	-- Optional, by default commands like `:ObsidianSearch` will attempt to use
	-- telescope.nvim, fzf-lua, or mini.pick (in that order), and use the
	-- first one they find. You can set this option to tell obsidian.nvim to
	-- always use this picker.
	picker = {
		name = "telescope.nvim",
		mappings = {
			-- Create a new note from your query with <C-x>
			new = "<C-x>",
			-- Insert a link to the selected note with <C-l>
			insert_link = "<C-l>",
		},
	},
})
