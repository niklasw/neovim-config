return {
  "dhananjaylatkar/cscope_maps.nvim",
  event = "BufReadPost",
  opts = {
    cscope = {
      exec             = "gtags-cscope",  -- use GNU Global instead of cscope
      db_file          = "GTAGS",
      db_build_cmd     = { args = {} },   -- passed to `gtags` when building
    },
    disable_maps = false,
    prefix       = "<leader>c",          -- <leader>cs find symbol, cc callers, cd callees, …
    project_rooter = {
      enable     = true,   -- walk up dirs to find GTAGS
      change_cwd = false,
    },
  },
  config = function(_, opts)
    require("cscope_maps").setup(opts)
    -- Keep GTAGS fresh: run `global --update` on every save when a db exists above
    vim.api.nvim_create_autocmd("BufWritePost", {
      desc = "Update gtags db on save",
      callback = function()
        local gtags = vim.fn.findfile("GTAGS", vim.fn.expand("%:p:h") .. ";")
        if gtags ~= "" then
          vim.fn.jobstart({ "global", "--update" }, {
            cwd = vim.fn.fnamemodify(gtags, ":h"),
          })
        end
      end,
    })
  end,
}
