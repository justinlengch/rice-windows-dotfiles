local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.default_prog = { 'pwsh.exe', '-NoLogo' }
config.color_scheme = 'Catppuccin Frappe'
config.font = wezterm.font 'JetBrainsMonoNL Nerd Font Propo'
config.font_size = 12
config.window_background_opacity = 0.70
config.window_decorations = 'RESIZE'
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = { left = 16, right = 16, top = 12, bottom = 12 }
config.default_cursor_style = 'BlinkingBar'
config.cursor_blink_rate = 600
config.enable_scroll_bar = false
config.scrollback_lines = 10000
config.audible_bell = 'Disabled'
config.use_resize_increments = false
config.colors = {
  tab_bar = {
    background = '#232634',
    active_tab = { bg_color = '#414B63', fg_color = '#c6d0f5' },
    inactive_tab = { bg_color = '#292c3c', fg_color = '#a5adce' },
    inactive_tab_hover = { bg_color = '#414559', fg_color = '#c6d0f5' },
    new_tab = { bg_color = '#232634', fg_color = '#a5adce' },
  },
}
return config
