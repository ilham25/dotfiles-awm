local wibox = require("wibox")
local gears = require("gears")

local textbox = wibox.widget({
	text = "",
	widget = wibox.widget.textbox,
	align = "left",
	valign = "center",
})

local function scroll_text()
	local text = textbox.text
	text = text:sub(2) .. text:sub(1, 1) -- move first char to the end
	textbox.text = text
end

gears.timer({
	timeout = 0.15, -- speed of scroll (lower is faster)
	call_now = true,
	autostart = true,
	callback = scroll_text,
})

return textbox
