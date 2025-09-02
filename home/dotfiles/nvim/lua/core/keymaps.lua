local map = vim.keymap.set
local silent = { silent = true, noremap = true }

-- Basic quality of life
map({"n","v"}, "<Space>", "<Nop>", { silent = true })
map("n", "<leader>w", ":w<cr>", silent)
map("n", "<leader>q", ":q<cr>", silent)
map("n", "<leader>h", ":nohlsearch<cr>", silent)

-- Window nav
map("n", "<C-h>", "<C-w>h", silent)
map("n", "<C-j>", "<C-w>j", silent)
map("n", "<C-k>", "<C-w>k", silent)
map("n", "<C-l>", "<C-w>l", silent)

-- Diagnostics
map("n", "[d", vim.diagnostic.goto_prev, silent)
map("n", "]d", vim.diagnostic.goto_next, silent)
map("n", "<leader>ld", vim.diagnostic.open_float, silent)

-- Telescope (lazy-loaded; mappings are safe)
map("n", "<leader>ff", function() require('telescope.builtin').find_files() end, silent)
map("n", "<leader>fg", function() require('telescope.builtin').live_grep() end, silent)
map("n", "<leader>fb", function() require('telescope.builtin').buffers() end, silent)
map("n", "<leader>fh", function() require('telescope.builtin').help_tags() end, silent)

-- Gitsigns (if loaded)
map("n", "]h", function()
  if package.loaded["gitsigns"] then require('gitsigns').next_hunk() end
end, silent)
map("n", "[h", function()
  if package.loaded["gitsigns"] then require('gitsigns').prev_hunk() end
end, silent)
