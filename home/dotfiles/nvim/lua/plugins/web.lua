return {
  {
    "pmizio/typescript-tools.nvim",
    ft = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    ft = { "typescript", "javascript", "html", "css", "json" },
    config = function()
      local lsp = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      lsp.tsserver.setup({ capabilities = capabilities })
      lsp.eslint.setup({ capabilities = capabilities })
      lsp.html.setup({ capabilities = capabilities })
      lsp.cssls.setup({ capabilities = capabilities })
      lsp.jsonls.setup({ capabilities = capabilities })
      lsp.tailwindcss.setup({ capabilities = capabilities })
      lsp.emmet_ls.setup({ capabilities = capabilities })
    end,
  },
}
