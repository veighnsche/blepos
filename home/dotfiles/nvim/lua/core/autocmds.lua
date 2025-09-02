local aug = vim.api.nvim_create_augroup
local au = vim.api.nvim_create_autocmd

local g = aug("core_autocmds", { clear = true })

-- Highlight on yank
au("TextYankPost", { group = g, callback = function() vim.highlight.on_yank({ higroup = "Visual", timeout = 150 }) end })

-- Better terminal
au("TermOpen", { group = g, callback = function()
  vim.opt_local.number = false
  vim.opt_local.relativenumber = false
  vim.opt_local.signcolumn = "no"
end })

-- Sway/foot: ensure dark background default (colors module will set highlights)
vim.cmd("set background=dark")

-- Filetype: PKGBUILD -> dedicated ft with bash syntax/TS mapping
vim.filetype.add({ filename = { PKGBUILD = "PKGBUILD" } })

-- Treesitter: use bash parser for PKGBUILD if TS is available
pcall(function()
  require("vim.treesitter.language").register("bash", "PKGBUILD")
end)
