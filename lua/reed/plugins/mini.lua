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
            local colors = require 'mini.colors'
            colors.setup {}
            local trailspace = require 'mini.trailspace'
            trailspace.setup {}
            local icons = require 'mini.icons'
            icons.setup {}
            local splitjoin = require 'mini.splitjoin'
            splitjoin.setup {}
            local hipatterns = require('mini.hipatterns')
            hipatterns.setup({
              highlighters = {
                -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
                fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
                hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
                todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
                note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },

                -- Highlight hex color strings (`#rrggbb`) using that color
                hex_color = hipatterns.gen_highlighter.hex_color(),
              },
            })
          end
        },
}
