local wibox = require("wibox")
local beautiful = require("beautiful")

local ui_common = require("ui/common")
local module = require("ui/quick_settings/module")

return function()
	local media_card = ui_common.card.section_card({
		{
			text = "awoekoewa",
			widget = wibox.widget.textbox,
		},
		widget = wibox.layout.fixed.horizontal,
	})

	local extra_card_1 = ui_common.card.section_card({
		{
			text = "",
			widget = wibox.widget.textbox,
		},
		widget = wibox.layout.fixed.horizontal,
	})

	local extra_card_2 = ui_common.card.section_card({
		{
			text = "",
			widget = wibox.widget.textbox,
		},
		widget = wibox.layout.fixed.horizontal,
	})

	local additional_grid = wibox.widget({
		{
			row_index = 1,
			col_index = 1,
			col_span = 2,
			widget = module.battery_information(),
		},
		{
			row_index = 2,
			col_index = 1,
			col_span = 1,
			widget = module.screenshot_control(),
		},
		{
			row_index = 2,
			col_index = 2,
			col_span = 1,
			widget = module.record_control(),
		},
		homogeneous = true,
		expand = true,
		widget = wibox.layout.grid,
		spacing = beautiful.dpi(10),
		forced_width = beautiful.dpi(160),
		forced_height = beautiful.dpi(160),
	})

	return additional_grid
end
