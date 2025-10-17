-- ============================================================================
-- LSP LANGUAGE SUPPORT TEMPLATE
-- ============================================================================
-- Description: Add LSP support for a new programming language
-- Dependencies: Mason, nvim-lspconfig, nvim-cmp (already configured)
-- Usage: Copy to lua/config/ and require in init.lua
--
-- STEPS TO ADD A NEW LANGUAGE:
-- 1. Copy this file: cp lsp-language.template.lua lsp-[language].lua
-- 2. Replace [LANGUAGE] placeholders with actual language details
-- 3. Add LSP server to plugins/init.lua mason-lspconfig.ensure_installed
-- 4. Add to init.lua: require("config.lsp-[language]")
-- 5. Test with :ConfigReload

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ============================================================================
-- [LANGUAGE] LSP CONFIGURATION
-- ============================================================================

-- LSP keybindings specific to [LANGUAGE] files
local on_attach_language = function(client, bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }

	-- Language-specific keybindings (examples)
	-- keymap("n", "<leader>lR", ":![LANGUAGE] run %<CR>", bufopts)  -- Run file
	-- keymap("n", "<leader>lt", ":![LANGUAGE] test<CR>", bufopts)   -- Run tests

	-- You can add language-specific LSP settings here
	-- if client.name == "[lsp-server-name]" then
	--     -- Custom client settings
	-- end
end

-- Configure LSP server for [LANGUAGE]
vim.lsp.config.[lsp_server_name] = {
	cmd = { "[lsp-server-command]", "--stdio" },
	filetypes = { "[file-extension-1]", "[file-extension-2]" },
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	on_attach = on_attach_language,
	settings = {
		[language_name] = {
			-- Language-specific settings
			-- Example for Python:
			-- analysis = {
			--     typeCheckingMode = "basic",
			--     autoImportCompletions = true,
			-- }

			-- Add your language-specific settings here
		}
	}
}

-- Enable the LSP server
vim.lsp.enable("[lsp_server_name]")

-- ============================================================================
-- ADDITIONAL LANGUAGE FEATURES (Optional)
-- ============================================================================

-- Treesitter parser for [LANGUAGE] (if not already included)
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = { "[file-extension-1]", "[file-extension-2]" },
--     callback = function()
--         -- Any filetype-specific setup
--     end,
-- })

-- ============================================================================
-- EXAMPLE CONFIGURATIONS FOR COMMON LANGUAGES
-- ============================================================================

-- PYTHON EXAMPLE (uncomment and modify):
-- vim.lsp.config.pyright = {
--     cmd = { "pyright-langserver", "--stdio" },
--     filetypes = { "python" },
--     capabilities = require("cmp_nvim_lsp").default_capabilities(),
--     on_attach = on_attach_language,
--     settings = {
--         python = {
--             analysis = {
--                 typeCheckingMode = "basic",
--                 autoImportCompletions = true,
--             }
--         }
--     }
-- }
-- vim.lsp.enable("pyright")

-- RUST EXAMPLE (uncomment and modify):
-- vim.lsp.config.rust_analyzer = {
--     cmd = { "rust-analyzer" },
--     filetypes = { "rust" },
--     capabilities = require("cmp_nvim_lsp").default_capabilities(),
--     on_attach = on_attach_language,
--     settings = {
--         ["rust-analyzer"] = {
--             checkOnSave = {
--                 command = "clippy",
--             },
--         }
--     }
-- }
-- vim.lsp.enable("rust_analyzer")

-- TYPESCRIPT EXAMPLE (uncomment and modify):
-- vim.lsp.config.ts_ls = {
--     cmd = { "typescript-language-server", "--stdio" },
--     filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
--     capabilities = require("cmp_nvim_lsp").default_capabilities(),
--     on_attach = on_attach_language,
--     settings = {
--         typescript = {
--             inlayHints = {
--                 includeInlayParameterNameHints = "all",
--             },
--         },
--     }
-- }
-- vim.lsp.enable("ts_ls")

-- ============================================================================
-- TESTING YOUR CONFIGURATION
-- ============================================================================

-- To test your new language support:
-- 1. Open a file of the language type
-- 2. Run :LspInfo to check if the server is attached
-- 3. Try LSP features like <leader>ld (go to definition)
-- 4. Use :ConfigHealth to verify everything loads

-- If you encounter issues:
-- 1. Check :Mason to ensure the LSP server is installed
-- 2. Look at :LspInfo for error messages
-- 3. Check the LSP server logs with :LspLog
