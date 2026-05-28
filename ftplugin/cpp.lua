-- Location-list search for word under cursor across C++ source files
vim.keymap.set("n", "<leader>l",
  [[:lvim /\<<C-R><C-W>\>/j ./**/*.C ./**/*.H<CR>:lw<CR>]],
  { buffer = true })
vim.keymap.set("n","<leader>w", ":wa<CR> :!wmake<CR>")
