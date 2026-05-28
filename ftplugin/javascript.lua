
-- Add node/js dirs to wildignore
for _, pat in ipairs({ "*/node_modules/*", "*/dist/*"}) do
  vim.opt.wildignore:append(pat)
end
