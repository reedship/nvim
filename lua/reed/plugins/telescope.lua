-- plugins/telescope.lua:
return {
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    -- or                              , branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim', {'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }},
    config = function()
      vim.keymap.set("n", "<leader>fd", require('telescope.builtin').git_files)
      vim.keymap.set("n", "<leader>fD", require('telescope.builtin').find_files)
      vim.keymap.set("n", "<leader>en", function()
        require('telescope.builtin').find_files {
          cwd = vim.fn.stdpath("config")
        }
      end)
      vim.keymap.set('n', '<leader>fs', require('telescope.builtin').live_grep)
      vim.keymap.set('n', '<leader>b', function() require('telescope.builtin').buffers({ sort_mru=true, ignore_current_buffer=true })end ,{})
      vim.keymap.set('n', '<leader>o', require('telescope.builtin').oldfiles, {})
    end
  }
}
