-- ─── Keymaps ──────────────────────────────────────────────────────────────────

-- Don't outdent hashes (Python)
vim.keymap.set("i", "#", "#")

-- Tab navigation
for i = 1, 9 do
  vim.keymap.set("n", "<leader>" .. i, i .. "gt")
end
vim.keymap.set("n", "<leader>0", ":tablast<CR>")

-- Clipboard
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p')
vim.keymap.set("i", "<C-v>", '<ESC>"+pa')
vim.keymap.set("v", "<C-c>", '"+y')
vim.keymap.set("v", "<C-d>", '"+d')

-- Wayland clipboard (wl-copy/wl-paste)
vim.keymap.set({ "n", "v" }, "<leader>y", ":w !wl-copy<CR><CR>")
vim.keymap.set({ "n", "v" }, "<leader>Y", ":r !wl-paste<CR><CR>")

-- Buffer list
vim.keymap.set("n", "<C-l>", ":set nomore | ls | set more<CR>:b<Space>")

-- Clear search highlight
vim.keymap.set("n", "<leader><space>", ":nohlsearch<CR>")

-- Remove trailing whitespace
vim.keymap.set("n", "<leader>S", [[:%s/\s\+$//<CR>:let @/=''<CR>]])

-- Reformat paragraph
vim.keymap.set("n", "<leader>q", "gqip")

-- Set working directory to current file
vim.keymap.set("n", "<leader>.", ":lcd %:p:h<CR>")

-- Quickfix search
vim.keymap.set("n", "<leader>l", ":vimgrep /<C-R><C-W>/ ##<CR>:copen<CR>")

local function quickfix_search()
  local term = vim.fn.input("Enter search term: ")
  vim.cmd("vimgrep /" .. term .. "/ ##")
  vim.cmd("copen")
end
vim.keymap.set("n", "<leader><leader>", quickfix_search)

-- Select completion item with Enter
vim.keymap.set("i", "<CR>", function()
  return vim.fn.pumvisible() == 1 and "<C-y>" or "<C-g>u<CR>"
end, { expr = true })

-- ─── Terminal ─────────────────────────────────────────────────────────────────

-- Open terminal in a horizontal split, enter insert mode immediately
vim.keymap.set("n", "<leader>tt", function()
  vim.cmd("split | term")
  vim.cmd("startinsert")
end, { desc = "Terminal (hsplit)" })

-- Exit terminal mode with Esc (default <C-\><C-n> is awkward)
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- ─── Transparency toggle ──────────────────────────────────────────────────────

local is_transparent = false
local function toggle_transparent()
  if not is_transparent then
    vim.api.nvim_set_hl(0, "Normal", { bg = "#111111", ctermbg = "black" })
    is_transparent = true
  else
    vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
    is_transparent = false
  end
end
vim.keymap.set("n", "<C-x><C-t>", toggle_transparent)
