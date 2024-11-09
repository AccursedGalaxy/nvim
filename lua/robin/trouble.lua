vim.keymap.set(
	"n",
	"<leader>qq",
	"<cmd>Trouble diagnostics toggle focus=false filter.buf=0<CR>",
	{ silent = true, noremap = true }
)
