local M = { current = "web" }

function M.set(mode)
  if mode ~= "web" and mode ~= "arch" then
    vim.notify("Invalid mode: " .. tostring(mode), vim.log.levels.ERROR)
    return
  end
  M.current = mode
  vim.g.nv_mode = mode
  vim.cmd("doautocmd User ModeChanged")
  vim.notify("Mode: " .. mode)
end

function M.is(mode) return M.current == mode end

vim.api.nvim_create_user_command("NvimMode", function(opts) M.set(opts.args) end, {
  nargs = 1,
  complete = function() return { "web", "arch" } end,
})

return M
