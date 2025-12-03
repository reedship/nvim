require("reed.lazy")
require("reed")

vim.opt.clipboard = "unnamedplus"
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Helper: rename tmux window
local function rename_tmux_window(name)
  -- Only if inside tmux
  if os.getenv("TMUX") then
    vim.fn.system({"tmux", "rename-window", name})
  end
end

-- On entering nvim, set to cwd (basename of project root)
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    rename_tmux_window(cwd)
  end,
})

-- On leaving nvim, reset back to zsh
vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    rename_tmux_window("zsh")
  end,
})

-- On directory change inside nvim (:cd, :lcd, :tcd)
vim.api.nvim_create_autocmd("DirChanged", {
  callback = function(ev)
    local cwd = vim.fn.fnamemodify(ev.file, ":t")
    rename_tmux_window(cwd)
  end,
})

