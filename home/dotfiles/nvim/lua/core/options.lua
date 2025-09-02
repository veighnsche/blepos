-- Core options
local o = vim.opt

-- UI
o.number = true
o.relativenumber = true
o.cursorline = true
o.signcolumn = "yes"
o.termguicolors = true

-- Editing
o.wrap = false
o.ignorecase = true
o.smartcase = true
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.softtabstop = 2
o.splitbelow = true
o.splitright = true
o.scrolloff = 4

-- Performance
o.updatetime = 250
o.timeoutlen = 400

-- Folding via treesitter (when available)
o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
o.foldenable = false
