local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local function marquee(args)
	local text = args.text or ""
	local speed = args.speed or 50 -- lower = faster
	local font = args.font or beautiful.font
	local width = args.width or 200
	local height = args.height or beautiful.dpi(16)

	local widget = wibox.widget({
		markup = text,
		font = font,
		align = "left",
		valign = "center",
		widget = wibox.widget.textbox,
	})

	local container = wibox.container.constraint(widget, "exact", width, height)

	local index = 1
	local timer = gears.timer({
		timeout = speed / 1000,
		autostart = true,
		call_now = true,
		callback = function()
			local t = text
			if utf8.len(t) > 1 then
				local head = t:sub(index)
				local tail = t:sub(1, index - 1)
				widget.markup = head .. tail
				index = (index % utf8.len(t)) + 1
			end
		end,
	})

	container.dispose = function()
		timer:stop()
	end

	container.textbox = widget
	container.text = text

	return container
end

return marquee
