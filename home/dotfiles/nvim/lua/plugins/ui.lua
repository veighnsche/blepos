return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      local P = require("core.colors").palette
      local theme = {
        normal   = { a = { fg = P.focused_fg, bg = P.focused_d }, b = { fg = P.fg, bg = P.unfocus_d }, c = { fg = P.fg, bg = P.unfocus_d } },
        insert   = { a = { fg = P.focused_fg, bg = P.focused_l } },
        visual   = { a = { fg = P.focused_fg, bg = P.focused_l } },
        replace  = { a = { fg = P.focused_fg, bg = P.urgent } },
        inactive = { a = { fg = P.unfocus_fg, bg = P.unfocus_d }, b = { fg = P.unfocus_fg, bg = P.unfocus_d }, c = { fg = P.unfocus_fg, bg = P.unfocus_d } },
      }
      require("lualine").setup({
        options = { theme = theme, component_separators = "", section_separators = "" },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff" },
          lualine_c = { { "filename", path = 1 } },
          lualine_x = { "diagnostics" },
          lualine_y = { "filetype" },
          lualine_z = { "location" },
        },
      })
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "VeryLazy",
    opts = {
      indent = { char = "│" },
      scope = { enabled = false },
    },
  },
  { "stevearc/dressing.nvim", event = "VeryLazy" },
}
