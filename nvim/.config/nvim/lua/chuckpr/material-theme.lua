vim.g.material_style = "darker"
local colors = require('material.colors')

local function to_rgb(color)
    return tonumber(color:sub(2, 3), 16), tonumber(color:sub(4, 5), 16),
           tonumber(color:sub(6), 16)
end

-- SOURCE: https://stackoverflow.com/questions/5560248/programmatically-lighten-or-darken-a-hex-color-or-rgb-and-blend-colors
-- https://github.com/akinsho/toggleterm.nvim/blob/8cafb2c021175515d7b577c6236ac9428260222b/lua/toggleterm/colors.lua#L18-L33
local function shade_color(color, percent)
    local r, g, b = to_rgb(color)
    -- If any of the colors are missing return "NONE" i.e. no highlight
    if not r or not g or not b then return "NONE" end
    r = math.floor(tonumber(r * (100 + percent) / 100))
    g = math.floor(tonumber(g * (100 + percent) / 100))
    b = math.floor(tonumber(b * (100 + percent) / 100))
    r, g, b = r < 255 and r or 255, g < 255 and g or 255, b < 255 and b or 255

    -- see: https://stackoverflow.com/questions/37796287/convert-decimal-to-hex-in-lua-4
    r, g, b = string.format("%0x", r), string.format("%0x", g),
              string.format("%0x", b)
    return "#" .. r .. g .. b
end

require('material').setup({

    contrast = {
        sidebars = false, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
        floating_windows = false, -- Enable contrast for floating windows
        line_numbers = false, -- Enable contrast background for line numbers
        sign_column = false, -- Enable contrast background for the sign column
        cursor_line = false, -- Enable darker background for the cursor line
        non_current_windows = false, -- Enable darker background for non-current windows
        popup_menu = false -- Enable lighter background for the popup menu
    },

    italics = {
        comments = false, -- Enable italic comments
        keywords = false, -- Enable italic keywords
        functions = false, -- Enable italic functions
        strings = false, -- Enable italic strings
        variables = false -- Enable italic variables
    },

    contrast_filetypes = { -- Specify which filetypes get the contrasted (darker) background
        "terminal", -- Darker terminal background
        "packer", -- Darker packer background
        "qf" -- Darker qf list background
    },

    high_visibility = {
        lighter = true, -- Enable higher contrast text for lighter style
        darker = true -- Enable higher contrast text for darker style
    },

    disable = {
        borders = false, -- Disable borders between verticaly split windows
        background = false, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
        term_colors = false, -- Prevent the theme from setting terminal colors
        eob_lines = false -- Hide the end-of-buffer lines
    },

    custom_highlights = {
        TSStringEscape = {fg = colors.blue},
        LineNr = {fg = colors.fg},
        TelescopePromptBorder = {bg = colors.float, fg = colors.darkcyan},
        TelescopeResultsBorder = {bg = colors.float, fg = colors.darkpurple},
        TelescopePreviewBorder = {bg = colors.float, fg = colors.darkblue},
        NormalFloat = {bg = colors.bg_alt},
        FloatBorder = {bg = colors.bg_alt, fg = colors.red},
        Search = {bg = colors.pink, fg = colors.black},
        NvimTreeNormal = {bg = shade_color(colors.bg, -20), fg = colors.fg},
        NvimTreeNormalNC = {bg = shade_color(colors.bg, -20), fg = colors.fg},
        Normal = {bg = shade_color(colors.bg, -5), fg = colors.fg},
        SignColumn = {bg = shade_color(colors.bg_sign, -5), fg = colors.fg}
    } -- Overwrite highlights with your own
})
