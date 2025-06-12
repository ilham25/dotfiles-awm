local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local quick_settings = require("ui.quick_settings")

return function()
	-- Button in the wibar
	local brightness_button = wibox.widget({
		{
			text = "󰜘",
			font = "FiraCode Nerd Font Mono 12",
			widget = wibox.widget.textbox,
		},
		margins = beautiful.dpi(6),
		widget = wibox.container.margin,
	})

	local popup = quick_settings({ parent = brightness_button })

	brightness_button:connect_signal("button::press", function()
		awful.placement.next_to(popup, {
			preferred_positions = { "bottom" },
			preferred_anchors = { "middle" },
			offset = { y = beautiful.dpi(6) },
		})

		popup.visible = not popup.visible
	end)

	return brightness_button
end
