local naughty = require("naughty")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

return function(n)
	return naughty.layout.box({
		notification = n,
		type = "notification",
		shape = gears.shape.rounded_rect,
		maximum_width = beautiful.dpi(300),
		maximum_height = beautiful.dpi(100),
		widget_template = {
			{
				{
					{
						{
							{
								{
									{
										image = n.icon,
										resize = true,
										forced_height = 24,
										forced_width = 24,
										widget = wibox.widget.imagebox,
										stylesheet = "svg { fill: " .. beautiful.colors.text .. "; }",
									},
									widget = wibox.container.place,
									valign = "center",
									halign = "center",
								},
								widget = wibox.container.background,
								forced_height = 40,
								forced_width = 40,
								bg = beautiful.colors.surface0,
								border_width = beautiful.dpi(1),
								border_color = beautiful.colors.surface1,
								shape = gears.shape.rounded_rect,
							},
							widget = wibox.container.constraint,
							width = 40,
							height = 40,
							strategy = "exact",
						},
						widget = wibox.container.place,
						valign = "top",
						halign = "left",
					},
					{
						{
							markup = "<b>" .. (n.title or "") .. "</b>",
							font = beautiful.font_family .. " 11",
							widget = wibox.widget.textbox,
						},
						{
							text = n.message,
							font = beautiful.font_family .. " 10",
							widget = wibox.widget.textbox,
						},
						spacing = 4,
						layout = wibox.layout.fixed.vertical,
					},
					spacing = 10,
					layout = wibox.layout.fixed.horizontal,
				},
				margins = 12,
				widget = wibox.container.margin,
			},
			bg = n.bg or beautiful.colors.box,
			fg = n.fg or beautiful.colors.text,
			shape = gears.shape.rounded_rect,
			widget = wibox.container.background,
			border_width = beautiful.dpi(1),
			border_color = beautiful.colors.surface1,
		},
	})
end
