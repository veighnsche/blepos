return {
  { import = "plugins.ui" },
  { import = "plugins.editing" },
  { import = "plugins.telescope" },
  { import = "plugins.whichkey" },
  { import = "plugins.treesitter" },
  { import = "plugins.lsp" },
  { import = "plugins.format" },
  { import = "plugins.git" },
  { import = "plugins.web",  cond = function() return require("modes").is("web") end },
  { import = "plugins.arch", cond = function() return require("modes").is("arch") end },
}
