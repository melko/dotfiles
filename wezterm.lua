local wezterm = require 'wezterm'

local cfg = wezterm.config_builder()

cfg.default_prog = {'/usr/bin/zsh', '-l'}
cfg.check_for_updates = false
cfg.unix_domains = {
	{
		name = 'unix',
	},
}

-- maximize window on opening
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

--cfg.default_gui_startup_args = { 'connect', 'unix' }
local term_font = "JetBrains Mono"
cfg.color_scheme = "Dark+"
cfg.font = wezterm.font(term_font)
cfg.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
cfg.font_size = 12

-- set bold font really bold
cfg.font_rules = {
	{
		intensity = "Bold",
		italic = false,
		font = wezterm.font(term_font, { weight = "ExtraBold", stretch = "Normal", style = "Normal" }),
	},
	{
		intensity = "Bold",
		italic = true,
		font = wezterm.font(term_font, { weight = "ExtraBold", stretch = "Normal", style = "Italic" }),
	},
}

cfg.enable_scroll_bar = true
cfg.scrollback_lines = 10000
cfg.audible_bell = 'Disabled'

-- make the scrollbar thumb more visible
local scheme = wezterm.get_builtin_color_schemes()[cfg.color_scheme]
scheme.scrollbar_thumb = '#ffffff'
cfg.color_schemes = {
	[cfg.color_scheme] = scheme
}

-- cfg.window_padding = {left=5, right=5, top=5, bottom=5}
cfg.inactive_pane_hsb = {saturation=0.9, brightness=0.6}

-- Tab Bar Options
cfg.use_fancy_tab_bar = true
cfg.enable_tab_bar = true
cfg.hide_tab_bar_if_only_one_tab = true

-- Keys
cfg.keys = {
	{key='v', mods='ALT', action=wezterm.action{SplitHorizontal={domain='CurrentPaneDomain'}}},
	{key='h', mods='ALT', action=wezterm.action{SplitVertical={domain='CurrentPaneDomain'}}},
	{key='l', mods='ALT', action=wezterm.action.ShowLauncher},
	{key='UpArrow', mods='SHIFT', action=wezterm.action.ScrollToPrompt(-1)},
	{key='DownArrow', mods='SHIFT', action=wezterm.action.ScrollToPrompt(1)},
	{key='t', mods='ALT', action=wezterm.action.ShowTabNavigator},
	{key='p', mods='CTRL|ALT', action=wezterm.action.ShowLauncherArgs {flags='FUZZY|LAUNCH_MENU_ITEMS|DOMAINS|KEY_ASSIGNMENTS|WORKSPACES|COMMANDS'}},
}

cfg.mouse_bindings = {
	{
		event = { Down = { streak = 4, button = 'Left' } },
		action = wezterm.action.SelectTextAtMouseCursor 'SemanticZone',
		mods = 'NONE',
	},
}

return cfg
