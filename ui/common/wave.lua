-- ~/.config/awesome/widgets/wave.lua
local wibox = require("wibox")
local gears = require("gears")
local math = math

local amplitude = 10
local frequency = 0.2
local speed = 0.1
local phase = 0

local wave_widget = wibox.widget({
	fit = function(_, width, height)
		return width, height
	end,

	draw = function(_, _, cr, width, height)
		cr:set_source_rgba(0.2, 0.6, 1.0, 1.0)
		cr:set_line_width(2)
		cr:move_to(0, height / 2)

		for x = 0, width, 1 do
			local y = height / 2 + amplitude * math.sin((x * frequency) + phase)
			cr:line_to(x, y)
		end

		cr:stroke()
	end,

	layout = wibox.widget.base.make_widget,
})

gears.timer({
	timeout = 1 / 60,
	autostart = true,
	callback = function()
		phase = phase + speed
		wave_widget:emit_signal("widget::redraw_needed")
	end,
})

return wave_widget
