return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required

    -- Only one of these is needed.
    "nvim-telescope/telescope.nvim", -- optional
  },
  config = function()
    require("neogit").setup({
      kind = 'vsplit',
      disable_line_numbers = false,
      integrations = {
        telescope = true,
      },
      highlight = {
        italic     = true,
        bold       = true,
        underline  = true,

        bg0        = "#070019",
        bg1        = "#2a2739",
        bg2        = "#4a4759",
        bg3        = "#13101f",

        grey       = "#857f8f",
        white      = "#d0d0d0",

        red        = "#f47360",
        bg_red     = "#cd2f30",
        line_red   = "#5b0f26",

        orange     = "#d0730f",

        yellow     = "#d0730f",
        bg_yellow  = "#8f5040",

        green      = "#50a22f",
        bg_green   = "#407720",
        line_green = "#003b2f",

        cyan       = "#7fafff",
        bg_cyan    = "#2270be",

        blue       = "#6f80ff",
        bg_blue    = "#4648d0",

        purple     = "#e580ea",
        bg_purple  = "#b04fcf",
        md_purple  = "#501f72",
      }
    })
  end
}
