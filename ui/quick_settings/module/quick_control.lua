local wibox = require("wibox")
local beautiful = require("beautiful")

local ui_common = require("ui/common")
local module = require("ui/quick_settings/module")

return function()
	local connectivity_card = ui_common.card.section_card({
		wibox.widget({
			module.wifi_control_item(),
			module.bluetooth_control_item(),
			module.sound_control_item(),
			spacing = beautiful.dpi(10),
			layout = wibox.layout.fixed.vertical,
		}),
	})

	return connectivity_card
end
