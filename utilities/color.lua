local awful = require("awful")

local utility = {}

local function hex_to_rgb(hex)
	local r, g, b = hex:match("#?(%x%x)(%x%x)(%x%x)")
	return tonumber(r, 16), tonumber(g, 16), tonumber(b, 16)
end

-- Determine if color is light (returns true/false)
utility.is_light_color = function(hex)
	local r, g, b = hex_to_rgb(hex)
	-- Standard luminance formula (ITU-R BT.709)
	local luminance = 0.2126 * r + 0.7152 * g + 0.0722 * b
	return luminance > 128
end

utility.get_dominant_color_from_image = function(image_path, callback)
	local cmd = string.format("convert '%s' -resize 1x1! -format '#%%[hex:p{0,0}]' info:-", image_path)

	awful.spawn.easy_async_with_shell(cmd, function(stdout)
		local color = stdout:match("#%x+")
		if color then
			callback(color)
		end
	end)
end

return utility
