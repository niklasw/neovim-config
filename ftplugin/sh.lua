-- F5: save and run current file with bash
vim.keymap.set("n", "<F5>",
  ":w<CR>:exec '!clear; bash ' . shellescape(expand('%'), 1)<CR>",
  { buffer = true })
vim.keymap.set("i", "<F5>",
  "<Esc>:w<CR>:exec '!clear; bash ' . shellescape(expand('%'), 1)<CR>",
  { buffer = true })
