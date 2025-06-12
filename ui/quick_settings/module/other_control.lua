local wibox = require("wibox")
local beautiful = require("beautiful")

local ui_common = require("ui/common")

return function()
	local focus_card = ui_common.card.section_card({
		{
			text = "",
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
			widget = focus_card,
		},
		{
			row_index = 2,
			col_index = 1,
			col_span = 1,
			widget = extra_card_1,
		},
		{
			row_index = 2,
			col_index = 2,
			col_span = 1,
			widget = extra_card_2,
		},
		homogeneous = true,
		expand = true,
		widget = wibox.layout.grid,
		spacing = beautiful.dpi(10),
	})

	return additional_grid
end
