-- lua/custom/plugins/mini.lua
return {
    {
        'echasnovski/mini.nvim',
        config = function()
            local statusline = require 'mini.statusline'
            statusline.setup { use_icons = true }
        end
    },
    {
      { 'echasnovski/mini.pairs', 
      config = function()
        local pairs = require 'mini.pairs'
        pairs.setup {}
      end
    }
    }
}
