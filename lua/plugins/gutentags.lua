return {
  "ludovicchabant/vim-gutentags",
  init = function()
    vim.g.gutentags_modules           = { "ctags" }  -- gtags_cscope removed: neovim ≥0.9 has no cscope
    vim.g.gutentags_cache_dir         = vim.fn.expand("~/.cache/gutentags")
    vim.g.gutentags_file_list_command = "fd --type f"
  end,
}
