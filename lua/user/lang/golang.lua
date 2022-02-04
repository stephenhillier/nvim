local cfg = {
  hint_prefix = "[param] ",
}
require("go").setup(cfg)

vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)
