local awful = require("awful")
local gears = require("gears")

local user_system_signal = require("enums/user_system_signal")
local utilities = require("utilities")
local notification = require("module/notification")
local icons = require("theme/icons")

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

function volume.up()
	local new_value = volume.get() + 5

	if new_value >= 100 then
		new_value = 100
	end

	volume.set(new_value)

	local icon = icons.volume_low

	if new_value >= 0 and new_value < 50 then
		icon = icons.volume_low
	elseif new_value >= 50 and new_value < 70 then
		icon = icons.volume_medium
	else
		icon = icons.volume_high
	end

	notification.notify("volume", {
		title = "Volume",
		message = tostring(new_value) .. "%",
		icon = icon,
	})
end

function volume.down()
	local new_value = volume.get() - 5

	if new_value <= 0 then
		new_value = 0
	end

	volume.set(new_value)

	local icon = icons.volume_low

	if new_value > 0 and new_value < 50 then
		icon = icons.volume_low
	elseif new_value >= 50 and new_value < 70 then
		icon = icons.volume_medium
	elseif new_value == 0 then
		icon = icons.volume_off
	else
		icon = icons.volume_high
	end

	notification.notify("volume", {
		title = "Volume",
		message = tostring(new_value) .. "%",
		icon = icon,
	})
end

-- 🔥 Init from system at startup
gears.timer({
	timeout = 1,
	autostart = true,
	single_shot = true,
	callback = volume.sync_from_system,
})

return volume
