local wibox = require("wibox")
local beautiful = require("beautiful")

local ui_common = require("ui/common")
local utilities = require("utilities")

return function()
	local widget = ui_common.card.section_card({
		wibox.widget({
			{
				{
					{
						image = beautiful.icons.video_outline,
						widget = wibox.widget.imagebox,
						stylesheet = utilities.svg.set_color(beautiful.colors.text),
						forced_height = beautiful.dpi(28),
						forced_width = beautiful.dpi(28),
						valign = "center",
						halign = "center",
					},
					widget = wibox.container.constraint,
					height = beautiful.dpi(28),
					width = beautiful.dpi(28),
				},
				{
					text = "Record",
					font = beautiful.font_family .. "Medium 9",
					widget = wibox.widget.textbox,
					halign = "center",
					valign = "center",
				},
				spacing = beautiful.dpi(5),
				layout = wibox.layout.fixed.vertical,
			},
			widget = wibox.container.place,
			halign = "halign",
			valign = "valign",
		}),
	})

	return widget
end
