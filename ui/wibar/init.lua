local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gears = require("gears")

local module = require(... .. ".module")

local variables = require("config/variables")

return function(s)
	s.mypromptbox = awful.widget.prompt() -- Create a promptbox.

	praisewidget = wibox.widget.textbox()
	praisewidget.text = gears.filesystem.get_awesome_icon_dir()

	-- Create the wibox
	s.mywibox = awful.wibar({
		position = "top",
		screen = s,
		height = beautiful.wibar_size,
		widget = {
			{
				layout = wibox.layout.align.horizontal,
				-- Left widgets.
				{
					layout = wibox.layout.fixed.horizontal,
					module.launcher(),
					praisewidget,
					module.taglist(s),
					s.mypromptbox,
				},
				-- Middle widgets.
				module.tasklist(s),
				-- Right widgets.
				{
					layout = wibox.layout.fixed.horizontal,
					module.quick_settings_button(),
					-- slider,
					awful.widget.keyboardlayout(), -- Keyboard map indicator and switcher.
					wibox.widget.systray(),
					wibox.widget.textclock(), -- Create a textclock widget.
					module.layoutbox(s),
				},
			},
			left = dpi(6),
			right = dpi(6),
			top = dpi(8),
			bottom = dpi(8),
			widget = wibox.container.margin,
		},
	})
end
