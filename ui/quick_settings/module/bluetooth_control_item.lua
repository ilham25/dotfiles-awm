local beautiful = require("beautiful")

local module = require("ui/quick_settings/module")

return function()
	local widget = module.control_item({
		title = "Bluetooth",
		icon = "󰂯",
		value = "On",
		icon_size = 16,
		active_bg = beautiful.colors.teal,
		icon_active_color = beautiful.colors.base,
	})

	widget:connect_signal("button::press", function()
		widget:set_active_value(not widget.active)
		widget.active = not widget.active
	end)

	return widget
end
