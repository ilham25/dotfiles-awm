local wibox = require("wibox")
local beautiful = require("beautiful")

local battery = require("module/battery")
local utilities = require("utilities")
local user_system_signal = require("enums/user_system_signal")

return function()
	local icon = wibox.widget({
		image = beautiful.icons.battery_empty,
		widget = wibox.widget.imagebox,
		stylesheet = utilities.svg.set_color(beautiful.colors.text),
	})
	local widget = wibox.widget({
		icon,
		widget = wibox.container.constraint,
		height = beautiful.dpi(30),
		width = beautiful.dpi(30),
	})

	awesome.connect_signal(user_system_signal.battery.update, function(args)
		icon.image = battery.icon(args)
	end)

	return widget
end
