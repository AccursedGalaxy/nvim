return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",  -- Use the latest version (harpoon2)
    dependencies = {
      "nvim-lua/plenary.nvim",  -- Required dependency
      "nvim-telescope/telescope.nvim",  -- Optional: For Telescope integration
    },
    config = function()
      local harpoon = require("harpoon")

      harpoon:setup({
        settings = {
          save_on_toggle = true,
          sync_on_ui_close = true,
          -- Use the current working directory as the key for project-specific lists
          key = function()
            return vim.loop.cwd()
          end,
        },
        -- Default list configuration (can be customized further)
        default = {
        },
      })

      -- Keybindings for core functionality
      vim.keymap.set("n", "<C-a>", function() harpoon:list():add() end, { desc = "Harpoon: Add file" })
      vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: Toggle menu" })

      -- Quick select keymaps for first 4 slots (customize as needed)
      vim.keymap.set("n", "<C-s>", function() harpoon:list():select(1) end, { desc = "Harpoon: Go to 1" })
      vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end, { desc = "Harpoon: Go to 2" })
      vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end, { desc = "Harpoon: Go to 3" })
      vim.keymap.set("n", "<C-p>", function() harpoon:list():select(4) end, { desc = "Harpoon: Go to 4" })

      -- Telescope integration for a fuzzy finder menu
      if package.loaded["telescope"] then
        local conf = require("telescope.config").values
        local function toggle_telescope(harpoon_files)
          local file_paths = {}
          for _, item in ipairs(harpoon_files.items) do
            table.insert(file_paths, item.value)
          end

          require("telescope.pickers").new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table({
              results = file_paths,
            }),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
          }):find()
        end

        vim.keymap.set("n", "<leader>hf", function() toggle_telescope(harpoon:list()) end, { desc = "Harpoon: Toggle menu (Telescope)" })
      end
    end,
  },
}
