-- Set ALE settings
vim.g.ale_lsp=1
vim.g.ale_completion_enabled = 1           -- Enable ALE completion
vim.g.ale_lint_on_enter = 1               -- Lint on entering buffer
vim.g.ale_set_quickfix = 1                  -- put references into a quickfix instead of a preview window
vim.g.ale_open_list = 0
vim.g.ale_keep_list_window_open = 0
--vim.g.ale_sign_error = '✗'                -- Error symbol
--vim.g.ale_sign_warning = '⚠'              -- Warning symbol
--vim.g.ale_sign_column_always = 1          -- Always show the sign column
--vim.g.ale_linter = 'python'               -- Specify a linter (e.g., python)

-- Keybindings for ALE actions
vim.api.nvim_set_keymap('n', '<leader>gd', ':ALEGoToDefinition<CR>', { noremap = true, silent = true })  -- Go to definition
vim.api.nvim_set_keymap('n', '<leader>gr', ':ALEFindReferences -quickfix<CR>', {})   -- Go to reference
-- vim.api.nvim_set_keymap('n', '<leader>gr', ':ALEFindReferences -quickfix<CR><BAR>:copen<CR><BAR>:wincmd j<CR>', {})

vim.api.nvim_set_keymap('n', '<leader>gf', ':ALEFix<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gl', ':ALELint<CR>', { noremap = true, silent = true })

vim.opt.completeopt=menu,menuone,preview,noselect,noinsert
