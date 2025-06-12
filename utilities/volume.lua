local awful = require("awful")

local utility = {}

utility.set_value = function(value)
	awful.spawn("pamixer --set-volume " .. math.floor(value), false)
end

utility.get_initial_value = function(callback)
	awful.spawn.easy_async_with_shell("pamixer --get-volume", function(out)
		local vol = tonumber(out)
		if vol then
			if callback ~= nil then
				callback(vol)
			end
		end
	end)
end

utility.get_mute_value = function(callback)
	awful.spawn.easy_async_with_shell("pamixer --get-mute", function(out)
		if callback ~= nil then
			callback(not out:match("true"))
		end
	end)
end

utility.toggle_mute = function()
	awful.spawn("pamixer -t", false)
end

return utility
