return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>fe", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
  },
  opts = {
    filesystem = {
      filtered_items = {
        visible = true,       -- show hidden/filtered items (greyed out, not invisible)
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_by_name = { ".DS_Store", "thumbs.db" },
      },
      window = {
        mappings = {
          ["<bs>"] = "navigate_up",
          ["."] = "set_root",
        },
      },
    },
  },
}
