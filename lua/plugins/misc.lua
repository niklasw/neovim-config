return {
  { "flazz/vim-colorschemes" },
  { "gregsexton/MatchTag" },
  { "hashivim/vim-terraform" },
  {
    "vhyrro/luarocks.nvim",
    priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
    config = true,}
}
