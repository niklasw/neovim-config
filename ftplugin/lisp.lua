-- Lisp settings
-- (Slimv config removed — was disabled via /usr/bin/true)

vim.opt_local.lisp        = true
vim.opt_local.autoindent  = true
vim.opt_local.showmatch   = true
vim.cmd("setlocal cpoptions-=mp")

vim.opt_local.expandtab   = true
vim.opt_local.shiftwidth  = 3
vim.opt_local.tabstop     = 4
vim.opt_local.softtabstop = 3
vim.opt_local.smartindent = true

vim.opt_local.foldmethod   = "marker"
vim.opt_local.foldmarker   = { "(", ")" }
vim.opt_local.foldminlines = 1

vim.opt_local.suffixesadd  = { ".lisp", ".cl" }
vim.opt_local.path:append("/usr/src/lisp/**")
vim.opt_local.include      = [=[(:file\]=]

-- Location-list search for word under cursor
vim.keymap.set("n", "<leader>l",
  [[:lvim /<C-R><C-W>/j *.lsp<CR>:lw<CR>]],
  { buffer = true })
