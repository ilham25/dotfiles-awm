local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

local module = require(... .. ".module")

return function(args)
	args = args or {}

	local quick_control = module.quick_control()
	local other_control = module.other_control()
	local brightness_slider_control = module.brightness_slider_control()
	local sound_slider_control = module.sound_slider_control()

	local content = wibox.widget({
		-- {
		-- 	row_index = 1,
		-- 	col_index = 1,
		-- 	col_span = 2,
		-- 	widget = quick_control,
		-- },
		-- {
		-- 	row_index = 1,
		-- 	col_index = 3,
		-- 	col_span = 2,
		-- 	widget = other_control,
		-- },
		{
			row_index = 1,
			col_index = 1,
			col_span = 4,
			widget = brightness_slider_control,
		},
		{
			row_index = 2,
			col_index = 1,
			col_span = 4,
			widget = sound_slider_control,
		},
		homogeneous = false,
		expand = true,
		spacing = beautiful.dpi(10),
		column_count = 4,
		layout = wibox.layout.grid,
	})

	local popup_widget = awful.popup({
		widget = {
			{
				{
					quick_control,
					other_control,
					layout = wibox.layout.fixed.horizontal,
					spacing = beautiful.dpi(10),
				},
				content,
				spacing = beautiful.dpi(10),
				layout = wibox.layout.fixed.vertical,
			},
			margins = beautiful.dpi(10),
			widget = wibox.container.margin,
		},
		placement = {},
		ontop = true,
		visible = false,
		parent = args.parent,
		bg = beautiful.colors.base,
		border_width = beautiful.dpi(1),
		border_color = beautiful.colors.crust,
		shape = function(cr, width, height)
			gears.shape.rounded_rect(cr, width, height, beautiful.border_radius)
		end,
	})

	return popup_widget
end
