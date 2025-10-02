local vim_term = vim.api.nvim_create_augroup('vim_term', { clear = true })

-- Disable line numbers in terminals
vim.api.nvim_create_autocmd('TermOpen', {
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
    vim.cmd('startinsert') -- enter insert mode immediately
  end,
  group = vim_term,
})

-- Leave insert mode when terminal closes
vim.api.nvim_create_autocmd('TermClose', {
  callback = function()
    vim.cmd('stopinsert')
  end,
  group = vim_term,
})
