local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

return function(def)
	local children = {}
	local props = {}

	if def ~= nil then
		for k, v in pairs(def) do
			if type(k) == "number" and type(v) == "table" then
				table.insert(children, v)
			else
				props[k] = v
			end
		end
	end

	local container = wibox.widget({
		{
			table.unpack(children),
			margins = def.margins or beautiful.dpi(10),
			widget = wibox.container.margin,
		},
		bg = props.bg or beautiful.colors.surface0,
		border_width = props.border_width or beautiful.dpi(1),
		border_color = props.border_color or beautiful.colors.surface1,
		shape = props.shape or gears.shape.rounded_rect,
		widget = wibox.container.background,
		forced_height = props.forced_height,
		forced_width = props.forced_width,
	})

	return container
end
