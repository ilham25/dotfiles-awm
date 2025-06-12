local wibox = require("wibox")
local beautiful = require("beautiful")

local ui_common = require("ui/common")
local volume = require("module/volume")
local user_system_signal = require("enums/user_system_signal")

return function()
	local slider = ui_common.slider.slider()
	local widget = ui_common.card.section_card({
		{
			{
				text = "Sound",
				widget = wibox.widget.textbox,
			},
			slider,
			spacing = beautiful.dpi(6),
			widget = wibox.layout.fixed.vertical,
		},
	})

	slider:connect_signal("property::value", function(_, new_value)
		volume.set(new_value)
	end)

	awesome.connect_signal(user_system_signal.volume.update, function(new_value)
		-- sound_item:update_value(new_value .. "%")
		slider.value = new_value
	end)

	return widget
end
