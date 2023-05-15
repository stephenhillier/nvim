local status_ok, lsp = pcall(require, "lsp-zero")
if not status_ok then
  return
end

local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

lsp.preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr, preserve_mappings = false})
end)

-- Null LS setup

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics


local null_opts = lsp.build_options('null-ls', {
  on_attach = function(client)
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        desc = "Auto format before save",
        pattern = "<buffer>",
        callback = vim.lsp.buf.format,
      })
    end
  end
})

null_ls.setup({
  on_attach = null_opts.on_attach,
  debug = false,
  sources = {
    formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
    formatting.black.with({ extra_args = { "--fast" } }),
    --[[ formatting.stylua, ]]
    --[[ formatting.gofmt, ]]
    diagnostics.golangci_lint,
    diagnostics.flake8
  },
})

-- LSP setup

lsp.setup()

-- allows displaying function signatures while typing out the arguments
require("lsp_signature").setup()
