local wezterm = require("wezterm")
return {
  adjust_window_size_when_changing_font_size = false,
  -- color_scheme = 'termnial.sexy',
  color_scheme = "tokyonight",
  enable_tab_bar = false,
  font_size = 13.7,
  font = wezterm.font("JetBrains Mono"),
  macos_window_background_blur = 30,
  native_macos_fullscreen_mode = true,
  window_background_opacity = 0.92, -- window_background_opacity = 1.0, -- window_background_opacity = 0.78, -- window_background_opacity = 0.20,
  window_decorations = "RESIZE",
  -- window_background_image = '/Users/shahid/Downloads/1.jpg',
  -- window_background_image_hsb = {
  --   brightness = 0.01,
  --   hue = 1.0,
  --   -- saturation = 0.9,
  -- },
  exit_behavior = "CloseOnCleanExit",
  window_close_confirmation = "NeverPrompt",
  default_prog = { "/run/current-system/sw/bin/zsh", "-l", "-c", "tmux" },
  window_padding = {
    left = 24,
    right = 24,
    top = 28,
    bottom = 24,
  },
  keys = {
    {
      key = "q",
      mods = "CTRL",
      action = wezterm.action.ToggleFullScreen,
    },
    {
      key = "'",
      mods = "CTRL",
      action = wezterm.action.ClearScrollback("ScrollbackAndViewport"),
    },
  },
  mouse_bindings = {
    -- Ctrl-click will open the link under the mouse cursor
    {
      event = { Up = { streak = 1, button = "Left" } },
      mods = "CTRL",
      action = wezterm.action.OpenLinkAtMouseCursor,
    },
  },
}
