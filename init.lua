-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Leader must be set before lazy
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

require("lazy").setup({
  { import = "plugins" },  -- imports all files under lua/plugins/
}, {
  ui = { border = "rounded" },
})

require("options")
require("keymaps")
require("autocmds")

-- To always warn if buffer changed in background --

vim.opt.autoread = false  -- don't silently reload

vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold' }, {
  pattern = '*',
  callback = function()
    if vim.fn.mode() ~= 'c' then
      vim.cmd('checktime')
    end
  end,
})

vim.api.nvim_create_autocmd('FileChangedShell', {
  pattern = '*',
  callback = function(args)
    local name = vim.fn.fnamemodify(args.file, ':t')
    local choice = vim.fn.confirm(
      ('"' .. name .. '" changed on disk — reload?'),
      '&Yes\n&No', 1, 'Warning'
    )
    vim.v.fcs_choice = choice == 1 and 'reload' or ''
  end,
})
