local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")

local user_system_signal = require("enums/user_system_signal")

local battery = {
	level = 0,
	time_remaining = nil, -- string like "01:23:45", or nil
	status = nil, -- string like "Charging", "Discharging", etc.
}

function battery.get()
	return {
		level = battery.level,
		time_remaining = battery.time_remaining,
		status = battery.status,
	}
end

function battery.icon(args)
	local level = args.level
	local is_charging = args.status == "Charging"

	if level <= 10 then
		return beautiful.icons["battery" .. (is_charging and "_charging" or "") .. "_empty"]
	elseif level <= 30 then
		return beautiful.icons["battery" .. (is_charging and "_charging" or "") .. "_low"]
	elseif level <= 60 then
		return beautiful.icons["battery" .. (is_charging and "_charging" or "") .. "_medium"]
	elseif level <= 90 then
		return beautiful.icons["battery" .. (is_charging and "_charging" or "") .. "_high"]
	else
		return beautiful.icons["battery" .. (is_charging and "_charging" or "") .. "_empty"]
	end
end

function battery.sync_from_system()
	awful.spawn.easy_async_with_shell("acpi -b", function(out)
		local total = 0
		local count = 0
		local shortest_time = nil
		local status = nil

		for line in out:gmatch("[^\r\n]+") do
			local perc = line:match("(%d?%d?%d)%%")
			local time = line:match("(%d+:%d+:%d+)%s+remaining") or line:match("(%d+:%d+:%d+)%s+until charged")
			local st = line:match("Battery %d+: ([^,]+)")

			if perc then
				total = total + tonumber(perc)
				count = count + 1
			end

			if st and not status then
				status = st
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
		battery.status = status

		awesome.emit_signal(user_system_signal.battery.update, battery)
	end)
end

-- Run every 30 seconds
gears.timer({
	timeout = 5,
	autostart = true,
	call_now = true,
	callback = battery.sync_from_system,
})

return battery
