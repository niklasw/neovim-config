return {
  "L3MON4D3/LuaSnip",
  dependencies = { "honza/vim-snippets" },
  config = function()
    require("luasnip.loaders.from_snipmate").lazy_load()
    local ls = require("luasnip")
    vim.keymap.set({ "i", "s" }, "<Tab>", function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      else
        vim.api.nvim_feedkeys(
          vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false
        )
      end
    end)
    vim.keymap.set({ "i", "s" }, "<C-b>", function() ls.jump(1) end)
    vim.keymap.set({ "i", "s" }, "<C-z>", function() ls.jump(-1) end)
  end,
}
