-- Python settings
vim.opt_local.expandtab   = true
vim.opt_local.shiftwidth  = 4
vim.opt_local.tabstop     = 8
vim.opt_local.softtabstop = 4
vim.opt_local.smartindent = true
vim.opt_local.cinwords    = "if,elif,else,for,while,try,except,finally,def,class,with"

-- Errorformat for Python tracebacks
vim.opt.errorformat = "%C%.%#,%A  File \"%f\"\\, line %l%.%#,%Z%[%^ ]%\\@=%m"

-- Location-list search for word under cursor
vim.keymap.set("n", "<leader>l",
  [[:lvim /<C-R><C-W>/ *.py<CR>:lw<CR>]],
  { buffer = true })

-- F5 / <leader>p: run file
vim.keymap.set("n", "<F5>",
  ":w<CR>:exec '!clear; python3 ' . shellescape(expand('%'), 1)<CR>",
  { buffer = true })
vim.keymap.set("i", "<F5>",
  "<Esc>:w<CR>:exec '!clear; python3 ' . shellescape(expand('%'), 1)<CR>",
  { buffer = true })
vim.keymap.set("n", "<leader>p",
  ":wa<CR>:!python3 -W ignore %<CR>",
  { buffer = true })

-- Add Python/VCS dirs to wildignore
for _, pat in ipairs({ "*/venv/*", "*/co_venv/*", "*/.venv/*", "*/env/*", "*/.git/*" }) do
  vim.opt.wildignore:append(pat)
end
