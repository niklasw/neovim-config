return {
  -- nvim-lspconfig: ships default server configs (cmd, filetypes, root_markers).
  -- With nvim 0.11+ we never call require('lspconfig').server.setup() — we use
  -- vim.lsp.config / vim.lsp.enable instead, and lspconfig just populates those
  -- defaults via its lsp/ runtime directory.
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Ruff: linting, code actions (fix, organise imports).
      -- Ruff does NOT do type checking or hover — pyright covers those if enabled.
      vim.lsp.config('ruff', {
        on_attach = function(client, _)
          -- Suppress ruff's hover so pyright (if active) owns K exclusively.
          -- Comment this out if you are NOT using pyright.
          client.server_capabilities.hoverProvider = false
        end,
      })
      vim.lsp.enable('ruff')

      -- Pyright: type checking, hover, go-to-definition for complex generics.
      -- Uncomment after: pip install pyright  (or: npm i -g pyright)
      --
      vim.lsp.config('pyright', {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",   -- "off" | "basic" | "strict"
            },
          },
        },
      })
      vim.lsp.enable('pyright')

      vim.lsp.config('clangd', {
      -- lspconfig defaults are fine; override only if needed, e.g.:
      -- cmd = { "clangd", "--background-index", "--clang-tidy" },
      })
      vim.lsp.enable('clangd')

      -- Buffer-local LSP keymaps, set once per buffer when any server attaches
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gd",         vim.lsp.buf.definition,   opts)
          vim.keymap.set("n", "gr",         vim.lsp.buf.references,   opts)
          vim.keymap.set("n", "K",          vim.lsp.buf.hover,        opts)
          vim.keymap.set("n", "[e",         vim.diagnostic.goto_prev, opts)
          vim.keymap.set("n", "]e",         vim.diagnostic.goto_next, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,  opts)
        end,
      })
    end,
  },

  -- Formatter: ruff format (replaces black) + ruff fix (replaces isort)
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          python = { "ruff_format", "ruff_fix" },
        },
        format_on_save = {
          timeout_ms = 500,
        },
      })
    end,
  },
}
