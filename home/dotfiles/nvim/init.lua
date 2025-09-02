-- Leader keys must be set before plugins
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Core config (options, keymaps, autocmds, colors, plugin manager)
require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.colors")
require("core.lazy")

-- Modes (web | arch). Default to web; switch with :NvimMode web|arch
require("modes").set(vim.g.nv_mode or "web")
