-- lua/custom/plugins/mini.lua
return {
    {
        'echasnovski/mini.nvim',
        config = function()
            local statusline = require 'mini.statusline'
            statusline.setup { use_icons = true }
            local surround = require 'mini.surround'
            surround.setup {}
            local pairs = require 'mini.pairs'
            pairs.setup {}
        end
    },
    {
      { 'echasnovski/mini.surround',
      config = function()
        local surround = require 'mini.surround'
        surround.setup {}
      end
    }
    },
    {
      { 'echasnovski/mini.pairs',
      config = function()
        local pairs = require 'mini.pairs'
        pairs.setup {}
      end
    }
    },
    {
      { 'echasnovski/mini.icons',
      config = function()
        local icons = require 'mini.icons'
        icons.setup {}
      end
    }
    },
}
