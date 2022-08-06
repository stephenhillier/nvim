local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup()
mason_lspconfig.setup_handlers({
  function (server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {}
  end,
})

-- require "user.lsp.lsp-installer"
require("user.lsp.handlers").setup()
-- require "user.lsp.null-ls"

require("lsp_signature").setup()
