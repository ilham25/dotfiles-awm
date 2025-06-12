local awful = require("awful")
local gears = require("gears")

local battery = {
	level = 0,
	time_remaining = nil, -- string like "01:23:45", or nil
}

function battery.get()
	return {
		level = battery.level,
		time_remaining = battery.time_remaining,
	}
end

function battery.sync_from_system()
	awful.spawn.easy_async_with_shell("acpi -b", function(out)
		local total = 0
		local count = 0
		local shortest_time = nil

		for line in out:gmatch("[^\r\n]+") do
			local perc = line:match("(%d?%d?%d)%%")
			local time = line:match("(%d+:%d+:%d+)%s+remaining")

			if perc then
				total = total + tonumber(perc)
				count = count + 1
			end

			if time then
				if not shortest_time or time < shortest_time then
					shortest_time = time
				end
			end
		end

		if count > 0 then
			battery.level = math.floor(total / count)
		end

		battery.time_remaining = shortest_time
		awesome.emit_signal("signal::battery", battery.level, battery.time_remaining)
	end)
end

-- Run every 30 seconds
gears.timer({
	timeout = 30,
	autostart = true,
	call_now = true,
	callback = battery.sync_from_system,
})

return battery
