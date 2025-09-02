return {
  {
    "neovim/nvim-lspconfig",
    ft = { "sh", "bash", "zsh", "PKGBUILD" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      require("lspconfig").bashls.setup({
        capabilities = capabilities,
        filetypes = { "sh", "bash", "zsh", "PKGBUILD" },
      })
    end,
  },
}
