return {
  "julienvincent/nvim-paredit",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  ft = { "lisp", "clojure", "fennel", "scheme" },
  config = function()
    local paredit = require("nvim-paredit")
    paredit.setup({
        keys = {  
            ["<localleader>w"] = {
              function()
                -- place cursor and set mode to `insert`
                paredit.cursor.place_cursor(
                  -- wrap element under cursor with `( ` and `)`
                  paredit.wrap.wrap_element_under_cursor("( ", ")"),
                  -- cursor placement opts
                  { placement = "inner_start", mode = "insert" }
                )
              end,
              "Wrap element insert head",
            },
            
            ["<localleader>W"] = {
              function()
                paredit.cursor.place_cursor(
                  paredit.wrap.wrap_element_under_cursor("(", ")"),
                  { placement = "inner_end", mode = "insert" }
                )
              end,
              "Wrap element insert tail",
            },
        }
    })
  end,
}
