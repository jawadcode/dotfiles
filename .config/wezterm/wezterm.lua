local wezterm = require'wezterm'

return {
    colors = {
        foreground = '#FFFFFF',
        background = 'rgba(18, 18, 18, 0.6)',
    },
--  font = wezterm.font_with_fallback({ "FiraCode Nerd Font", "Noto Color Emoji" }),
    font = wezterm.font_with_fallback({ "JetBrainsMono Nerd Font", "Noto Color Emoji" }),
    line_height = 0.9,
    font_size = 11.5,
}
