-- Development Tools for Neovim Configuration
-- Provides commands and utilities for easier config development and testing

local M = {}

-- Reload configuration modules
function M.reload_config()
	local modules = {
		"core.options",
		"core.keymaps",
		"config.navigation",
		"config.lsp",
		"config.ui",
		"config.editing",
		"config.git"
	}

	for _, module in ipairs(modules) do
		package.loaded[module] = nil
		local ok, err = pcall(require, module)
		if not ok then
			vim.notify("Failed to reload " .. module .. ": " .. err, vim.log.levels.ERROR)
		else
			vim.notify("Reloaded " .. module, vim.log.levels.INFO)
		end
	end

	vim.notify("Configuration reload complete", vim.log.levels.INFO)
end

-- Comprehensive health check for configuration
function M.health_check()
	local results = {
		core = {},
		plugins = {},
		lsp = {},
		features = {},
		system = {}
	}

	-- Check core modules
	local core_modules = { "core.options", "core.keymaps", "core.devtools", "core.setup_guide", "plugins" }
	for _, module in ipairs(core_modules) do
		if pcall(require, module) then
			table.insert(results.core, "✅ " .. module)
		else
			table.insert(results.core, "❌ " .. module)
		end
	end

	-- Check feature modules
	local feature_modules = { "config.navigation", "config.lsp", "config.ui", "config.editing", "config.git" }
	for _, module in ipairs(feature_modules) do
		if pcall(require, module) then
			table.insert(results.features, "✅ " .. module)
		else
			table.insert(results.features, "❌ " .. module)
		end
	end

	-- Check plugin manager
	if pcall(require, "lazy") then
		table.insert(results.plugins, "✅ lazy.nvim available")
	else
		table.insert(results.plugins, "❌ lazy.nvim not found")
	end

	-- Check LSP status
	if vim.lsp.get_clients then
		local clients = vim.lsp.get_clients()
		if #clients > 0 then
			table.insert(results.lsp, "✅ LSP active (" .. #clients .. " clients)")
		else
			table.insert(results.lsp, "⚠️  No LSP clients active")
		end
	else
		table.insert(results.lsp, "❌ LSP API not available")
	end

	-- System info
	local version = vim.version()
	table.insert(results.system, "📋 Neovim " .. version.major .. "." .. version.minor .. "." .. version.patch)

	-- Display results in organized sections
	local sections = {
		{ name = "CORE MODULES", data = results.core },
		{ name = "FEATURE MODULES", data = results.features },
		{ name = "PLUGIN SYSTEM", data = results.plugins },
		{ name = "LANGUAGE SUPPORT", data = results.lsp },
		{ name = "SYSTEM INFO", data = results.system }
	}

	vim.notify("🔍 Neovim Configuration Health Check", vim.log.levels.INFO)
	vim.notify("", vim.log.levels.INFO) -- spacer

	for _, section in ipairs(sections) do
		if #section.data > 0 then
			vim.notify("═══ " .. section.name .. " ═══", vim.log.levels.INFO)
			for _, item in ipairs(section.data) do
				vim.notify("  " .. item, vim.log.levels.INFO)
			end
			vim.notify("", vim.log.levels.INFO) -- spacer
		end
	end

	-- Summary
	local errors = 0
	local warnings = 0

	for _, section in pairs(results) do
		for _, item in ipairs(section) do
			if item:match("❌") then errors = errors + 1 end
			if item:match("⚠️") then warnings = warnings + 1 end
		end
	end

	if errors == 0 and warnings == 0 then
		vim.notify("🎉 All systems operational! Your config is healthy.", vim.log.levels.INFO)
	elseif errors == 0 then
		vim.notify("⚠️  Configuration loaded with " .. warnings .. " warnings.", vim.log.levels.WARN)
	else
		vim.notify("❌ Configuration has " .. errors .. " errors and " .. warnings .. " warnings.", vim.log.levels.ERROR)
		vim.notify("💡 Try :ConfigReload or check CONFIG_ROADMAP.md for troubleshooting.", vim.log.levels.INFO)
	end
end

-- Backup current configuration
function M.backup_config()
	local config_dir = vim.fn.stdpath("config")
	local backup_dir = config_dir .. "_backup_" .. os.date("%Y%m%d_%H%M%S")

	local cmd = string.format("cp -r %s %s", config_dir, backup_dir)
	local result = vim.fn.system(cmd)

	if vim.v.shell_error == 0 then
		vim.notify("✅ Config backed up to: " .. backup_dir, vim.log.levels.INFO)
		return backup_dir
	else
		vim.notify("❌ Backup failed: " .. result, vim.log.levels.ERROR)
		return nil
	end
end

-- Show plugin loading performance
function M.plugin_profile()
	if pcall(require, "lazy") then
		vim.cmd("Lazy profile")
	else
		vim.notify("❌ lazy.nvim not available", vim.log.levels.ERROR)
	end
end

-- Open config file for editing
function M.edit_config(file)
	local config_files = {
		init = "init.lua",
		options = "lua/core/options.lua",
		keymaps = "lua/core/keymaps.lua",
		plugins = "lua/plugins/init.lua",
		navigation = "lua/config/navigation.lua",
		lsp = "lua/config/lsp.lua",
		ui = "lua/config/ui.lua",
		editing = "lua/config/editing.lua",
		git = "lua/config/git.lua",
		readme = "README.md",
		keybindings = "KEYBINDINGS.md",
		roadmap = "CONFIG_ROADMAP.md"
	}

	local target_file = config_files[file]
	if target_file then
		vim.cmd("edit " .. vim.fn.stdpath("config") .. "/" .. target_file)
	else
		vim.notify("❌ Unknown config file: " .. file, vim.log.levels.ERROR)
		vim.notify("Available options: " .. table.concat(vim.tbl_keys(config_files), ", "), vim.log.levels.INFO)
	end
end

-- Quick test commands
function M.test_completion()
	vim.cmd("Telescope find_files")
end

function M.test_lsp()
	if vim.lsp.get_clients then
		local clients = vim.lsp.get_clients()
		if #clients > 0 then
			vim.notify("✅ LSP clients active: " .. #clients, vim.log.levels.INFO)
			for _, client in ipairs(clients) do
				vim.notify("  - " .. client.name, vim.log.levels.INFO)
			end
		else
			vim.notify("❌ No LSP clients active", vim.log.levels.WARN)
		end
	else
		vim.notify("❌ LSP API not available", vim.log.levels.ERROR)
	end
end

-- Auto-run basic health check on startup (silent)
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		-- Run health check silently, only notify if there are issues
		local issues = {}

		-- Quick checks without notifications
		local core_modules = { "core.options", "core.keymaps", "plugins" }
		local has_issues = false

		for _, module in ipairs(core_modules) do
			if not pcall(require, module) then
				has_issues = true
				break
			end
		end

		-- Only notify if there are issues
		if has_issues then
			vim.notify("Config health check failed. Run :ConfigHealth for details.", vim.log.levels.WARN)
		end
	end,
	once = true
})

-- Create user commands
vim.api.nvim_create_user_command("ConfigReload", M.reload_config, { desc = "Reload Neovim configuration modules" })
vim.api.nvim_create_user_command("ConfigHealth", M.health_check, { desc = "Run configuration health check" })
vim.api.nvim_create_user_command("ConfigBackup", M.backup_config, { desc = "Create configuration backup" })
vim.api.nvim_create_user_command("ConfigProfile", M.plugin_profile, { desc = "Show plugin loading performance" })
vim.api.nvim_create_user_command("ConfigEdit", function(opts) M.edit_config(opts.args) end, {
	nargs = 1,
	desc = "Edit configuration file (init, options, keymaps, plugins, navigation, lsp, ui, editing, git, readme, keybindings, roadmap)",
	complete = function()
		return { "init", "options", "keymaps", "plugins", "navigation", "lsp", "ui", "editing", "git", "readme", "keybindings", "roadmap" }
	end
})
vim.api.nvim_create_user_command("ConfigTestLSP", M.test_lsp, { desc = "Test LSP functionality" })
vim.api.nvim_create_user_command("SetupGuide", function() require("core.setup_guide").start() end, { desc = "Start interactive setup guide" })

return M
