-- ─── Basic settings ───────────────────────────────────────────────────────────

-- Workaround to get rid of ALE/nvim diagnostic incompat. error
vim.g.ale_use_neovim_diagnostics_api = 0

vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")

vim.opt.numberwidth = 3
vim.opt.background  = "dark"
vim.opt.title       = true

-- Completion
vim.opt.completeopt = { "menuone", "longest", "preview" }
vim.opt.pumheight   = 6

-- Bells
vim.opt.errorbells = false
vim.opt.visualbell = true

-- Wildmenu
vim.opt.wildmenu = true
vim.opt.wildmode = "full"

-- ─── Movement & editing ───────────────────────────────────────────────────────

vim.opt.startofline  = false
vim.opt.virtualedit  = "block"
vim.opt.scrolloff    = 3
vim.opt.backspace    = "indent,eol,start"
vim.opt.showmatch    = true
vim.opt.wrap         = false
vim.opt.linebreak    = true
vim.opt.autoindent   = true
vim.opt.smartindent  = true
vim.opt.tabstop      = 4
vim.opt.shiftwidth   = 4
vim.opt.softtabstop  = 4
vim.opt.expandtab    = true
vim.opt.shiftround   = true
vim.opt.matchpairs:append("<:>")
vim.opt.foldmethod   = "indent"
vim.opt.foldlevel    = 99

-- ─── Reading / writing ────────────────────────────────────────────────────────

vim.opt.autowrite    = false
vim.opt.autowriteall = false
vim.opt.autoread     = false
vim.opt.modeline     = true
vim.opt.modelines    = 5
vim.opt.fileformats  = { "unix", "dos", "mac" }

-- ─── Messages / status ────────────────────────────────────────────────────────

vim.opt.confirm    = true
vim.opt.showcmd    = true
vim.opt.report     = 0
vim.opt.shortmess:append("a")
vim.opt.ruler      = true
vim.opt.laststatus = 2
vim.opt.statusline = "[%l,%v %P%M] %f %r%h%w (%{&ff})"

vim.opt.listchars  = { tab = ">-", trail = "-", precedes = "<", extends = ">" }
vim.opt.list       = false

-- ─── Search ───────────────────────────────────────────────────────────────────

vim.opt.ignorecase = true
vim.opt.smartcase  = true
vim.opt.smarttab   = true
vim.opt.hlsearch   = true
vim.opt.incsearch  = true

-- ─── Display / colour column ──────────────────────────────────────────────────

vim.opt.colorcolumn = { 81 }
vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg = 0, bg = "#111111" })

-- Colorscheme
if vim.fn.has("gui_running") == 1 then
  vim.cmd("colorscheme gruvbox")
  vim.opt.guifont = "Terminus Medium 16"
else
  vim.opt.termguicolors = false
  vim.cmd("colorscheme Atelier_EstuaryDark")
  vim.api.nvim_set_hl(0, "Search",    { bold = true, ctermfg = "black", ctermbg = "grey" })
  vim.api.nvim_set_hl(0, "SpellBad",  { underline = true })
  vim.api.nvim_set_hl(0, "VertSplit", { ctermfg = 33, ctermbg = "NONE", cterm = {} })
  vim.opt.fillchars = { stlnc = "=", vert = ".", fold = "-", diff = "-" }
end

vim.api.nvim_set_hl(0, "Normal",     { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "MatchParen", { ctermfg = "DarkGreen", ctermbg = "NONE", bg = "Grey" })

-- ─── Tabline ──────────────────────────────────────────────────────────────────

if vim.fn.exists("+showtabline") == 1 then
  function MyTabLine()
    local s = ""
    local t = vim.fn.tabpagenr()
    for i = 1, vim.fn.tabpagenr("$") do
      local buflist = vim.fn.tabpagebuflist(i)
      local winnr   = vim.fn.tabpagewinnr(i)
      s = s .. "%" .. i .. "T"
      s = s .. (i == t and "%1*" or "%2*")
      s = s .. " %#TabNum#" .. i
      s = s .. (i == t and "%#TabLineSel#" or "%#TabLine#")
      local bufnr   = buflist[winnr]
      local file    = vim.fn.bufname(bufnr)
      local buftype = vim.fn.getbufvar(bufnr, "buftype")
      if buftype == "nofile" then
        if file:match("/.") then
          file = file:gsub(".*/%ze.", "")
        end
      else
        file = vim.fn.fnamemodify(file, ":p:t")
      end
      if file == "" then file = "[No Name]" end
      s = s .. " " .. file .. " "
    end
    s = s .. "%T%#TabLineFill#%="
    s = s .. (vim.fn.tabpagenr("$") > 1 and "%999XX" or "X")
    return s
  end

  vim.opt.tabline     = "%!v:lua.MyTabLine()"
  vim.opt.showtabline = 1
  vim.api.nvim_set_hl(0, "TabNum", { link = "Special" })
end

-- ─── File explorer (netrw) ────────────────────────────────────────────────────

vim.g.netrw_banner       = 0
vim.g.netrw_liststyle    = 3
vim.g.netrw_browse_split = 4
vim.g.netrw_altv         = 1
vim.g.netrw_winsize      = 15

-- ─── Show errors from e.g. ruff (lua) ────────────────────────────────────────────────────

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
})
