-- VSCode Neovim Extension Configuration
if vim.g.vscode then
	local vscode = require("vscode")

	-- Leader key
	vim.g.mapleader = " "
	vim.g.maplocalleader = " "
	local keymap = vim.keymap.set
	local opts = { noremap = true, silent = true }

	-- Function to call vscode commands
	local function vscode_command(command)
		return function()
			vscode.call(command)
			-- vim.fn.VSCodeNotify(command)
		end
	end

	-- fzf and rg commands
	keymap("n", "<leader>ss", vscode_command("fzf: Search in Project Root (.git) using rg and fzf"))

	-- Highlighting Management
	keymap("n", "<leader><leader>", "<Cmd>nohlsearch<CR>", opts)

	-- Leader-based shortcuts
	keymap("n", "<leader>q", function()
		vscode.call("workbench.action.closeActiveEditor")
	end, opts)
	-- Focus on the sidebar and switch to file explorer
	keymap("n", "<leader>pv", function()
		vscode.call("workbench.view.explorer")
	end, opts)

	-- Moving lines up and down
	keymap("n", "<C-j>", ":m .+1<CR>==", opts)
	keymap("n", "<C-k>", ":m .-2<CR>==", opts)

	keymap("n", "<leader>gd", function()
		vscode.action("editor.action.goToDeclaration")
	end, opts)
	keymap("n", "<leader>gr", function()
		vscode.action("editor.action.referenceSearch.trigger")
	end, opts)

	-- Split commands
	keymap("n", "<leader>sv", function()
		vscode.action("workbench.action.splitEditorRight")
	end, opts)
	keymap("n", "<leader>sh", function()
		vscode.action("workbench.action.splitEditorDown")
	end, opts)

	-- naviate between splits with arrow keys
	keymap("n", "<Left>", function()
		vscode.action("workbench.action.focusLeftGroup")
	end, opts)
	keymap("n", "<Up>", function()
		vscode.action("workbench.action.focusDownGroup")
	end, opts)
	keymap("n", "<Down>", function()
		vscode.action("workbench.action.focusUpGroup")
	end, opts)
	keymap("n", "<Right>", function()
		vscode.action("workbench.action.focusRightGroup")
	end, opts)

	-- Focus Terminal/Open New Terminal
	keymap("n", "<leader>t", function()
		vscode.action("workbench.action.terminal.focus")
	end, opts)

	-- Find and replace vim style
	keymap("n", "<leader>rr", ":%s//g<Left><Left>", opts)

	-- Find and replace VS Code style
	keymap("n", "<leader>fr", function()
		vscode.action("editor.action.startFindReplaceAction")
	end, opts)

	-- Select Word
	keymap("n", "<leader>w", "viw", opts)

	-- Move lines up and down
	keymap("n", "<C-j>", ":m .+1<CR>==", opts)
	keymap("n", "<C-k>", ":m .-2<CR>==", opts)

	-- Move lines up and down in visual mode
	keymap("v", "<C-j>", ":m '>+1<CR>gv=gv", opts)
	keymap("v", "<C-k>", ":m '<-2<CR>gv=gv", opts)

	-- Move to beginning and end of line
	keymap("n", "H", "^", opts)
	keymap("n", "L", "$", opts)
	keymap("v", "H", "^", opts)
	keymap("v", "L", "$", opts)

	-- Move to beginning and end of File
	keymap("n", "J", "G", opts)
	keymap("n", "K", "gg", opts)
	keymap("v", "J", "G", opts)
	keymap("v", "K", "gg", opts)
else
	return
end
