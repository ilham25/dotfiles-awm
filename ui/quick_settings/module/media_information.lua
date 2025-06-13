local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")

local ui_common = require("ui/common")

return function()
	local album_art = wibox.widget({
		{
			widget = wibox.container.background,
			forced_height = beautiful.dpi(60),
			forced_width = beautiful.dpi(60),
			bg = beautiful.colors.base,
			shape = gears.shape.rounded_rect,
			border_width = beautiful.dpi(1),
			border_color = beautiful.colors.surface1,
		},
		widget = wibox.container.constraint,
		height = beautiful.dpi(60),
		width = beautiful.dpi(60),
	})

	local widget = ui_common.card.section_card({
		{
			album_art,
			widget = wibox.container.place,
			valign = "center",
			halign = "left",
		},
		widget = wibox.layout.fixed.horizontal,
	})

	return widget
end
