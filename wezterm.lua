local wezterm = require 'wezterm'

local cfg = {}

cfg.default_prog = {'/usr/bin/zsh'}
cfg.check_for_updates = false
cfg.unix_domains = {
	{
		name = 'unix',
	},
}
--cfg.default_gui_startup_args = { 'connect', 'unix' }
cfg.color_scheme = "Dark+"
--cfg.color_scheme = 'Molokai'
--cfg.color_scheme = 'Google Dark (base16)'
--cfg.color_scheme = 'UltraViolent'
--cfg.color_scheme = 'Aura (Gogh)'
--cfg.font = wezterm.font('Last Resort High-Efficiency')
cfg.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
cfg.font_size = 11
--cfg.font = wezterm.font "Noto Sans Mono"

cfg.enable_scroll_bar = true
cfg.scrollback_lines = 10000
cfg.audible_bell = 'Disabled'

cfg.window_padding = {left=5, right=5, top=5, bottom=5}
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
