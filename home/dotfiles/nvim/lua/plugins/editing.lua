return {
  { "numToStr/Comment.nvim", event = "VeryLazy", opts = {} },
  { "echasnovski/mini.surround", version = false, event = "VeryLazy", opts = {} },
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
  { "ggandor/leap.nvim", event = "VeryLazy", config = function() require('leap').add_default_mappings() end },
  { "max397574/better-escape.nvim", event = "InsertEnter", opts = { mapping = {"jk", "jj"} } },
}
