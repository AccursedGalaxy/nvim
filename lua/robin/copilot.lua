-- I did this shit to make sure <Tab> autocompletion is working in .md and .vimwiki files
-- was annoying to find out... but hey... now it works... yayayayayay!
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"vimwiki", "markdown"},
  command = "silent! iunmap <buffer> <Tab>"
 })
vim.api.nvim_set_keymap('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true, noremap = true})
