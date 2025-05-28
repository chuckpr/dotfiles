local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font_size = 16
config.font = wezterm.font("CaskaydiaCove Nerd Font", { weight = 700, italic = false })
config.line_height = 1.25
-- config.color_scheme = 'Gogh (Gogh)'
config.color_scheme = "Gruvbox Dark (Gogh)"
-- config.color_scheme = "Kanagawa Dragon (Gogh)"
config.window_background_opacity = 0.95
config.window_padding = { left = 0, right = 0, top = 0, bottom = 2 }
config.initial_rows = 400
config.initial_cols = 200
config.hide_tab_bar_if_only_one_tab = true
config.automatically_reload_config = true
config.default_cursor_style = "BlinkingBlock"
config.enable_scroll_bar = true
config.scrollback_lines = 5000
config.window_decorations = "RESIZE"

return config
