local wezterm = require("wezterm")
local mux = wezterm.mux

function font_with_fallback(name, params)
  local names = { name, "FiraCode Nerd Font Mono", "JetBrainsMono Nerd Font Mono" }
  return wezterm.font_with_fallback(names, params)
end

wezterm.on('gui-startup', function(cmd)
    local tab, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
end)

return {
  animation_fps = 10,
  adjust_window_size_when_changing_font_size = false,
  cursor_blink_ease_in = 'Constant',
  cursor_blink_ease_out = 'Constant',
  default_cursor_style = 'BlinkingBlock',
  default_prog = { 'mytmux' },
  hide_tab_bar_if_only_one_tab = false,
  hide_mouse_cursor_when_typing = false,
  window_decorations = "INTEGRATED_BUTTONS|RESIZE",
  --integrated_title_buttons = {},
  selection_word_boundary = " \t\n{}[]()\"'`",
  scrollback_lines = 9999,
  warn_about_missing_glyphs = false,

  -- Font Stuff
  font = font_with_fallback("JetBrainsMonoMedium Nerd Font Mono"),
  font_rules = {
    {
      italic = true,
      font = font_with_fallback("JetBrainsMonoMedium Nerd Font Mono", { italic = true }),
    },
    {
      italic = true,
      intensity = "Bold",
      font = font_with_fallback("JetBrainsMonoMedium Nerd Font Mono", { bold = true, italic = true }),
    },
    {
      intensity = "Bold",
      font = font_with_fallback("JetBrainsMonoMedium Nerd Font Mono", { bold = true }),
    },
  },
  font_size = 11,
  font_shaper = "Harfbuzz",
  line_height = 1.0,

  colors = {
    foreground = "#c0caf5",
    background = "#1a1b26",
    cursor_bg = "#fe32e5",
    cursor_border = "#fe32e5",
    cursor_fg = "#1a1b26",
    selection_bg = "#33467C",
    selection_fg = "#c0caf5",

    -- The color of the split lines between panes
    split = "#444444",

    ansi = { "#15161E", "#f7768e", "#9ece6a", "#e0af68", "#7aa2f7", "#bb9af7", "#7dcfff", "#a9b1d6" },
    brights = { "#414868", "#f7768e", "#9ece6a", "#e0af68", "#7aa2f7", "#bb9af7", "#7dcfff", "#c0caf5" },
  },
  launch_menu = {
      {
          args = {'bash'},
      },
      {
          args = {'mc'},
      },
      {
          args = {'nvim'},
      },
      {
          args = {'vim'},
      },
      {
          args = {'htop'},
      },
  },
}

