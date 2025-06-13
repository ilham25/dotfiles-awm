local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")

local utilities = require("utilities")
local ui_common = require("ui/common")

return function()
	-- Create the progress bar
	local progressbar = wibox.widget({
		max_value = 1,
		value = 0.5, -- 50% progress
		forced_height = beautiful.dpi(14),
		-- forced_width = 140,
		shape = gears.shape.rounded_bar,
		bar_shape = gears.shape.rounded_bar,
		color = beautiful.colors.teal, -- progress color
		background_color = beautiful.colors.surface0, -- background of progressbar
		widget = wibox.widget.progressbar,
		border_width = beautiful.dpi(1),
		border_color = beautiful.colors.surface1,
		margins = {
			top = beautiful.dpi(4),
		},
	})

	local icon = wibox.widget({
		image = beautiful.icons.battery_charging_medium,
		widget = wibox.widget.imagebox,
		forced_height = beautiful.dpi(24),
		forced_width = beautiful.dpi(24),
		stylesheet = "svg { color:" .. beautiful.colors.text .. ";}",
	})

	local value_textbox = wibox.widget({
		markup = utilities.text.colored_text("50%", beautiful.colors.subtext1),
		widget = wibox.widget.textbox,
		font = beautiful.font_family .. " 9",
		align = "left",
	})

	local indicator = wibox.widget({
		{
			widget = wibox.container.place,
			valign = "center",
			halign = "center",
			icon,
		},
		bg = beautiful.colors.base,
		shape = gears.shape.circle,
		border_width = beautiful.dpi(1),
		border_color = beautiful.colors.surface1,
		widget = wibox.container.background,
		forced_height = beautiful.dpi(40),
		forced_width = beautiful.dpi(40),
	})

	-- Create the overlay widget (like text or icon)
	local overlay = wibox.widget({
		indicator,
		{
			widget = wibox.container.place,
			valign = "center",
			halign = "left",
			{
				layout = wibox.layout.fixed.vertical,
				{
					text = "Battery",
					widget = wibox.widget.textbox,
					font = beautiful.font_family .. "Medium 11",
					align = "left",
				},
				value_textbox,
				progressbar,
			},
		},
		spacing = beautiful.dpi(8),
		layout = wibox.layout.fixed.horizontal,
	})

	-- Stack the widgets
	local widget = ui_common.card.section_card({
		overlay,
	})

	return widget
end
