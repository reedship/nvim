-- plugins/telescope.lua:
return {
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    -- or                              , branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim', {'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }},
    config = function()
      require('telescope').setup {
        pickers = {
          find_files = {
            theme = "ivy"
          },
          git_files = {
            theme = "ivy"
          },
          buffers = {
            theme = "ivy"
          },
          grep_string = {
            theme = "ivy"
          }
        },
        extensions = {
          fzf = {}
        }
      }
      require('telescope').load_extension('fzf')
      local ivy = require('telescope.themes').get_ivy()
      vim.keymap.set("n", "<leader>fd", function() require('telescope.builtin').git_files(ivy) end)
      vim.keymap.set("n", "<leader>fh", function() require('telescope.builtin').help_tags(ivy) end)
      vim.keymap.set("n", "<leader>fD", function() require('telescope.builtin').find_files(ivy) end)
      vim.keymap.set("n", "<leader>en", function()
        require('telescope.builtin').find_files {
          cwd = vim.fn.stdpath("config")
        }
      end)
      vim.keymap.set("n", "<leader>ep", function()
        require('telescope.builtin').find_files {
          cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
        }
      end)
      require "reed.plugins.telescope.multigrep".setup()
      vim.keymap.set('n', '<leader>b', function() require('telescope.builtin').buffers(ivy) end)
      vim.keymap.set('n', '<leader>o', function() require('telescope.builtin').oldfiles(ivy) end)
      local action_state = require('telescope.actions.state')

      vim.keymap.set('n', '<leader>b', function()
        require('telescope.builtin').buffers({
          initial_mode = "normal",
          theme = ivy,
          attach_mappings = function(prompt_bufnr, map)
            local delete_buf = function()
              local current_picker = action_state.get_current_picker(prompt_bufnr)
              current_picker:delete_selection(function(selection)
                vim.api.nvim_buf_delete(selection.bufnr, { force = true })
              end)
            end

            map('n', '<c-d>', delete_buf)

            return true
          end
        })
      end)
    end
  }
}
