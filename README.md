# Neovim config

Personal Neovim configuration. Uses [lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management.

---

## Required external tools

### Python (LSP + formatting)

| Tool | Purpose | Install |
|------|---------|---------|
| `ruff` | Linting, formatting, import sorting | `pip install ruff` or `pipx install ruff` |
| `pyright` *(optional)* | Type checking, hover, advanced go-to-def | `pip install pyright` or `npm i -g pyright` |

**Why two tools?** Ruff deliberately does not implement type checking — it focuses on fast linting and formatting. Pyright fills that gap. Together they cover what the old `flake8 + black + isort + pyright` stack did, but faster and with less config.

#### Ruff minimum version

Ruff's built-in LSP (`ruff server`) was stabilised in **v0.4.0**. Verify with:

```sh
ruff --version   # should be ≥ 0.4.0
```

#### Enabling pyright

1. Install: `pip install pyright` (or `npm i -g pyright`)
2. In `lua/plugins/lsp.lua`, uncomment the `lspconfig.pyright.setup({…})` block.
3. The `hoverProvider = false` line on the ruff client suppresses ruff's hover
   so pyright owns `K`. Keep it as-is.

---

## Key mappings (Python buffers)

LSP keymaps are set via `LspAttach` and apply to any buffer with an active server.

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Find references |
| `K` | Hover documentation |
| `[e` / `]e` | Previous / next diagnostic |
| `<leader>ca` | Code action (fix lint issue, organise imports, …) |
| `<F5>` / `<leader>p` | Run current file with `python3` |
| `<leader>l` | Location-list search for word under cursor in `*.py` |

**Format on save** is handled by [conform.nvim](https://github.com/stevearc/conform.nvim):
- `ruff_format` — equivalent to `black` (formatting)
- `ruff_fix` — equivalent to `isort` (import sorting via `ruff check --fix`)

---

## Ruff configuration

Ruff reads `pyproject.toml`, `ruff.toml`, or `.ruff.toml` in the project root.
Example `ruff.toml` that mirrors the old flake8 settings:

```toml
line-length = 120

[lint]
extend-ignore = ["E265", "E302", "E303", "I001"]
```

---

## Plugin list

| Plugin | Purpose |
|--------|---------|
| `neovim/nvim-lspconfig` | LSP client config (ruff, pyright) |
| `stevearc/conform.nvim` | Format on save |
| `nvim-neo-tree/neo-tree.nvim` | File explorer (`<leader>fe`) |
| `L3MON4D3/LuaSnip` | Snippet engine |
| `ludovicchabant/vim-gutentags` | Automatic ctags generation |
| `dhananjaylatkar/cscope_maps.nvim` | Cscope/gtags navigation |
| `flazz/vim-colorschemes` | Colour scheme pack |
| `gregsexton/MatchTag` | HTML tag matching |
| `hashivim/vim-terraform` | Terraform syntax |
