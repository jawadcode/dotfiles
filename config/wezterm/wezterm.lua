local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.front_end = "WebGpu"
config.adjust_window_size_when_changing_font_size = false

config.font = wezterm.font_with_fallback { "Iosevka Term SS07", "Noto Color Emoji" }
config.font_size = 13.5

config.color_scheme = 'Apple System Colors'
config.hide_tab_bar_if_only_one_tab = true

return config
