vim.g.material_style = "darker"
local colors = require('material.colors').editor

-- local function to_rgb(color)
--     return tonumber(color:sub(2, 3), 16), tonumber(color:sub(4, 5), 16),
--            tonumber(color:sub(6), 16)
-- end

-- -- SOURCE: https://stackoverflow.com/questions/5560248/programmatically-lighten-or-darken-a-hex-color-or-rgb-and-blend-colors
-- -- https://github.com/akinsho/toggleterm.nvim/blob/8cafb2c021175515d7b577c6236ac9428260222b/lua/toggleterm/colors.lua#L18-L33
-- local function shade_color(color, percent)
--     local r, g, b = to_rgb(color)
--     -- If any of the colors are missing return "NONE" i.e. no highlight
--     if not r or not g or not b then return "NONE" end
--     r = math.floor(tonumber(r * (100 + percent) / 100))
--     g = math.floor(tonumber(g * (100 + percent) / 100))
--     b = math.floor(tonumber(b * (100 + percent) / 100))
--     r, g, b = r < 255 and r or 255, g < 255 and g or 255, b < 255 and b or 255

--     -- see: https://stackoverflow.com/questions/37796287/convert-decimal-to-hex-in-lua-4
--     r, g, b = string.format("%0x", r), string.format("%0x", g),
--               string.format("%0x", b)
--     return "#" .. r .. g .. b
-- end

require('material').setup({

    contrast = {
        terminal = true, -- Enable contrast for the built-in terminal
        sidebars = true, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
        floating_windows = true, -- Enable contrast for floating windows
        cursor_line = true, -- Enable darker background for the cursor line
        non_current_windows = true, -- Enable darker background for non-current windows
        filetypes = {"terminal"} -- Specify which filetypes get the contrasted (darker) background
    },

    plugins = { -- Uncomment the plugins that you use to highlight them
        "gitsigns", "indent-blankline", "nvim-cmp", "nvim-web-devicons",
        "telescope", "trouble", "which-key"
    },

    high_visibility = {
        lighter = true, -- Enable higher contrast text for lighter style
        darker = true -- Enable higher contrast text for darker style
    },

    disable = {
        colored_cursor = false, -- Disable the colored cursor
        borders = false, -- Disable borders between verticaly split windows
        background = false, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
        term_colors = false, -- Prevent the theme from setting terminal colors
        eob_lines = false -- Hide the end-of-buffer lines
    },

    custom_highlights = {
        --     TSStringEscape = {fg = colors.blue},
        --     LineNr = {fg = colors.fg},
        TelescopePromptBorder = {bg = colors.float, fg = colors.darkcyan},
        TelescopeResultsBorder = {bg = colors.float, fg = colors.darkpurple},
        TelescopePreviewBorder = {bg = colors.float, fg = colors.darkblue}
        --     NormalFloat = {bg = colors.bg_alt},
        --     FloatBorder = {bg = colors.bg_alt, fg = colors.red},
        --     Search = {bg = colors.pink, fg = colors.black},
        --     NvimTreeNormal = {bg = shade_color(colors.bg, -20), fg = colors.fg},
        --     NvimTreeNormalNC = {bg = shade_color(colors.bg, -20), fg = colors.fg},
        --     Normal = {bg = shade_color(colors.bg, -5), fg = colors.fg},
        --     SignColumn = {bg = shade_color(colors.bg_sign, -5), fg = colors.fg}
    } -- Overwrite highlights with your own
})
