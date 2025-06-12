local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

local function make_popup(content, parent)
	local popup_widget = awful.popup({
		widget = {
			{
				content,
				layout = wibox.layout.fixed.vertical,
			},
			margins = beautiful.dpi(10),
			widget = wibox.container.margin,
		},
		placement = {},
		ontop = true,
		visible = false,
		parent = parent,
		bg = beautiful.colors.base,
		border_width = beautiful.dpi(1),
		border_color = beautiful.colors.crust,
		shape = function(cr, width, height)
			gears.shape.rounded_rect(cr, width, height, beautiful.border_radius)
		end,
	})

	return popup_widget
end

return make_popup
