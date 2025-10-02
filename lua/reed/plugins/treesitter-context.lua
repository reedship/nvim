return {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy", -- or "BufReadPost"
    config = function()
      require("treesitter-context").setup({
        enable = true,
        max_lines = 0,
        trim_scope = "outer",
        mode = "cursor",
        zindex = 20,
        line_numbers = true,
        multiline_threshold = 20,
        separator = nil,
        on_attach = nil,
      })
    end,
  }
