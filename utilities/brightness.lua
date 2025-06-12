local awful = require("awful")

local utility = {}

utility.set_value = function(value)
	awful.spawn("brightnessctl set " .. value .. "%", false)
end

utility.get_initial_value = function(callback)
	awful.spawn.easy_async_with_shell("brightnessctl get && brightnessctl max", function(out)
		local cur, max = out:match("(%d+).-\n(%d+)")
		if cur and max then
			local percent = math.floor((tonumber(cur) / tonumber(max)) * 100)
			if callback ~= nil then
				callback(percent)
			end
		end
	end)
end

return utility
