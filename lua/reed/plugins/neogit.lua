return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required

    -- Only one of these is needed.
    "nvim-telescope/telescope.nvim", -- optional
  },
  config = function()
    require("neogit").setup({
      kind = 'floating',
      disable_line_numbers = false,
      integrations = {
        telescope = true,
      }
    })
  end
}
