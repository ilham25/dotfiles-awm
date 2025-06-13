local beautiful = require("beautiful")

local module = require("ui/quick_settings/module")
local volume = require("module/volume")
local utilities = require("utilities")
local user_system_signal = require("enums/user_system_signal")

return function()
	local widget = module.control_item({
		title = "Sound",
		icon = "󰝟",
		value = volume.get(),
		icon_active = "󰕾",
		active_bg = beautiful.colors.sapphire,
		icon_active_color = beautiful.colors.base,
	})

	widget:connect_signal("button::press", function()
		utilities.volume.toggle_mute()
		utilities.volume.get_mute_value(function(value)
			widget:set_active_value(value)
			widget.active = value
		end)
	end)

	utilities.volume.get_mute_value(function(value)
		widget:set_active_value(value)
		widget.active = value
	end)

	awesome.connect_signal(user_system_signal.volume.update, function(new_value)
		widget:update_value(new_value .. "%")
	end)

	return widget
end
