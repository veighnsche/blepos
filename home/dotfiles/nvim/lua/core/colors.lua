-- Sway palette + apply basic highlights
local P = {
  focused_l = "#4c7899",
  focused_d = "#285577",
  focused_fg = "#ffffff",
  unfocus_l = "#333333",
  unfocus_d = "#222222",
  unfocus_fg = "#888888",
  urgent = "#900000",
  urgent_fg = "#ffffff",
  bg = "#222222",
  fg = "#ffffff",
}

vim.opt.termguicolors = true

local M = { palette = P }

local function hi(group, opts) vim.api.nvim_set_hl(0, group, opts) end

function M.apply()
  hi("Normal",       { fg = P.fg, bg = P.bg })
  hi("NormalNC",     { fg = P.unfocus_fg, bg = P.unfocus_d })
  hi("StatusLine",   { fg = P.focused_fg, bg = P.focused_d })
  hi("StatusLineNC", { fg = P.unfocus_fg, bg = P.unfocus_l })
  hi("TabLine",      { fg = P.unfocus_fg, bg = P.unfocus_d })
  hi("TabLineSel",   { fg = P.focused_fg, bg = P.focused_d })
  hi("VertSplit",    { fg = P.unfocus_l })
  hi("Visual",       { bg = P.focused_l })
  hi("WarningMsg",   { fg = P.urgent })
  hi("ErrorMsg",     { fg = P.urgent, bg = P.urgent_fg })
  hi("NormalFloat",  { fg = P.fg, bg = P.unfocus_d })
  hi("FloatBorder",  { fg = P.unfocus_l, bg = P.unfocus_d })
end

M.apply()
return M
