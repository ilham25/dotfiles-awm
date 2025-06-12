local awful = require("awful")
local gears = require("gears")

local user_system_signal = require("enums/user_system_signal")
local utilities = require("utilities")

local volume = {
	level = 0, -- temporary placeholder
}

function volume.set(val)
	volume.level = val
	utilities.volume.set_value(val)
	awesome.emit_signal(user_system_signal.volume.update, val)
end

function volume.get()
	return volume.level
end

function volume.sync_from_system()
	awful.spawn.easy_async_with_shell("pactl get-sink-volume @DEFAULT_SINK@", function(out)
		local vol = out:match("(%d+)%%")
		if vol then
			volume.set(tonumber(vol))
		end
	end)
end

-- 🔥 Init from system at startup
gears.timer({
	timeout = 1,
	autostart = true,
	single_shot = true,
	callback = volume.sync_from_system,
})

return volume
