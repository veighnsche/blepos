return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    opts = {
      format_on_save = function(bufnr)
        local disable = { "lua_ls" }
        if vim.tbl_contains(disable, vim.bo[bufnr].filetype) then return end
        return { lsp_fallback = true, timeout_ms = 1000 }
      end,
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        json = { "prettier" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        zsh = { "shfmt" },
        PKGBUILD = { "shfmt" },
        make = { },
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.diagnostics.eslint_d,
          null_ls.builtins.code_actions.eslint_d,
          null_ls.builtins.code_actions.gitsigns,
          null_ls.builtins.diagnostics.shellcheck,
        },
      })
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
  },
}
