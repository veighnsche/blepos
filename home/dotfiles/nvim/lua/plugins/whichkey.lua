return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
      win = { border = "rounded" },
      -- Using defaults for triggers; removed deprecated triggers_blacklist
    },
  },
}
