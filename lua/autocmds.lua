-- ─── Filetype detection ───────────────────────────────────────────────────────

-- Treat Mako and Jinja2 templates as HTML
vim.filetype.add({
  extension = {
    mako   = "html",
    mak    = "html",
    jinja2 = "html",
  },
})

-- ─── Autocmds ─────────────────────────────────────────────────────────────────

-- Jump to last cursor position when reopening a file
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, mark)
      vim.cmd("normal! zv")
    end
  end,
})

-- Close preview window when leaving insert / moving in insert
vim.api.nvim_create_autocmd({ "CursorMovedI", "InsertLeave" }, {
  callback = function()
    if vim.fn.pumvisible() == 0 then
      vim.cmd("pclose")
    end
  end,
})

-- Wipe netrw buffers on leave (prevents buffer list pollution)
vim.api.nvim_create_autocmd("FileType", {
  pattern  = "netrw",
  callback = function() vim.bo.bufhidden = "wipe" end,
})

-- Start treesitter (new nvim-treesitter no longer auto-attaches a highlighter)
-- Disabling legacy :syntax avoids the two-highlighter colour conflict.
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "lisp", "scheme", "clojure", "fennel",
    "python", "c", "cpp", "sh", "bash",
    "lua", "vim",
    "html", "css", "json", "yaml", "toml", "markdown",
    "terraform", "hcl",
  },
  callback = function(ev)
    if vim.bo[ev.buf].filetype == "lisp" then
      vim.treesitter.language.register("commonlisp", "lisp")
    end
    local ok = pcall(vim.treesitter.start, ev.buf)
    if ok then
      vim.bo[ev.buf].syntax = ""
    end
  end,
})
