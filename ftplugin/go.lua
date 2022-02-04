local options = {
  expandtab = false,                        -- convert tabs to spaces
  shiftwidth = 4,                          -- the number of spaces inserted for each indentation
  tabstop = 4,                             -- insert 2 spaces for a tab
  softtabstop = 4,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end
