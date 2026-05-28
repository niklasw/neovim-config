-- lua/plugins/treesitter.lua
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    require("nvim-treesitter.config").setup({
      ensure_installed = {
        -- Lisps (nvim-paredit)
        "commonlisp", "scheme", "clojure", "fennel",
        -- ftplugin languages
        "python", "c", "cpp", "bash", "html", "css",
        -- Lua (config itself)
        "lua", "vim",
        -- Config / markup
        "json", "yaml", "toml", "markdown",
        -- Infra (vim-terraform plugin)
        "terraform", "hcl",
      },
    })
  end,
}
