local beautiful = require("beautiful")

local module = require("ui/quick_settings/module")

return function()
	local widget = module.control_item({
		title = "Wi-Fi",
		icon = "󰤨",
		value = "Iruha",
		active_bg = beautiful.colors.mauve,
		icon_active_color = beautiful.colors.base,
	})

	widget:connect_signal("button::press", function()
		widget:set_active_value(not widget.active)
		widget.active = not widget.active
	end)

	return widget
end
