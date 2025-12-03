-- -- lua/plugins/colorscheme.lua
-- return {
-- 	"ellisonleao/gruvbox.nvim",
-- 	name = "gruvbox",
-- 	config = function()
--     require("gruvbox").setup({
--       terminal_colors = true, -- add neovim terminal colors
--       undercurl = true,
--       underline = true,
--       bold = false,
--       italic = {
--         strings = true,
--         emphasis = true,
--         comments = true,
--         operators = false,
--         folds = true,
--       },
--       strikethrough = true,
--       invert_selection = false,
--       invert_signs = false,
--       invert_tabline = false,
--       inverse = true, -- invert background for search, diffs, statuslines and errors
--       contrast = "soft", -- can be "hard", "soft" or empty string
--       palette_overrides = {},
--       overrides = {},
--       dim_inactive = false,
--       transparent_mode = true,
--     })
--     vim.o.background = "dark"
-- 		vim.cmd("colorscheme gruvbox")
-- 	end
-- }
return {
  "oonamo/ef-themes.nvim",
  name = "ef-theme",
  config = function()
    require("ef-themes").setup({
      light = "ef-spring", -- Ef-theme to select for light backgrounds
      dark = "ef-dream", -- Ef-theme to select for dark backgrounds
      transparent = true,
      styles = {
        -- Set specific styles for specific highlight groups
        -- Can be any valid attr-list value. See `:h nvim_set_hl`
        comments = { italic = true },
        keywords = { bold = true },
        functions = {},
        variables = {},
        classes = { bold = true },
        types = { bold = true },

        diagnostic = "default", -- Can be "full"
        pickers = "default", -- Can be "borderless"
      },

      modules = {
        -- Enable/Disable highlights for a module
        -- See `h: ef-themes-modules` for the list of available modules
        blink = true,
        fzf = false,
        mini = true,
        semantic_tokens = false,
        snacks = false,
        treesitter = true,
      },

      --- Override any color from the ef-theme
      ---@param colors Ef-Theme
      ---@param name string
      on_colors = function(colors, name) end,

      --- Override specific highlights
      ---@param highlights table
      ---@param colors Ef-Theme
      ---@param name string
      ---@return table
      on_highlights = function(highlights, colors, name)
        -- Returns a table of highlights
        -- return {
          --   Normal = { fg = colors.fg_alt, bg = colors.bg_inactive }
          --   ObscurePlugin = { fg = colors.yellow_faint }
          -- }
        end,

        options = {
          compile = true, -- Whether to compile a theme
          compile_path = vim.fn.stdpath("cache") .. "/ef-themes", -- Directory in which to place compiled themes
        },
      })

      vim.cmd.colorscheme("ef-theme") -- To use the default colorscheme defined above
      -- Or choose a specific theme
      -- vim.cmd.colorscheme("ef-dream")
  end
}
