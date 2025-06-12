local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")

return function(def)
	def = def or {}
	local widget = wibox.widget({
		bar_shape = function(cr, width, height)
			gears.shape.rounded_rect(cr, width, height, beautiful.dpi(32))
		end,
		bar_height = beautiful.dpi(24),
		bar_color = beautiful.colors.surface1,
		handle_color = beautiful.colors.text,
		handle_shape = gears.shape.circle,
		handle_border_color = beautiful.colors.subtext0,
		handle_width = beautiful.dpi(24),
		bar_active_color = beautiful.colors.text,
		handle_border_width = beautiful.dpi(1),
		value = 0,
		widget = wibox.widget.slider,
		forced_height = def.forced_height or beautiful.dpi(24),
		forced_width = def.forced_width or beautiful.dpi(250),
	})

	return widget
end
