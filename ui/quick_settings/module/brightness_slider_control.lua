local wibox = require("wibox")
local beautiful = require("beautiful")

local utilities = require("utilities")
local ui_common = require("ui/common")

return function()
	local slider = ui_common.slider.slider()

	local widget = ui_common.card.section_card({
		{
			{
				text = "Brightness",
				widget = wibox.widget.textbox,
			},
			slider,
			spacing = beautiful.dpi(6),
			widget = wibox.layout.fixed.vertical,
		},
	})

	utilities.brightness.get_initial_value(function(value)
		slider.value = value
	end)

	slider:connect_signal("property::value", function(_, new_value)
		utilities.brightness.set_value(new_value)
	end)

	return widget
end
