-- notification_manager.lua

local naughty = require("naughty")

local M = {}
local active_notifications = {}

--- Shows a notification that replaces any existing one in the same group
-- @param key string: group identifier (e.g. "volume", "brightness")
-- @param opts table: options passed to naughty.notify
function M.notify(key, opts)
	-- Destroy previous notification in this group
	if active_notifications[key] then
		active_notifications[key]:destroy()
	end

	-- Create and store the new notification
	active_notifications[key] = naughty.notify(opts)
end

--- Force clear a notification group
-- @param key string
function M.clear(key)
	if active_notifications[key] then
		active_notifications[key]:destroy()
		active_notifications[key] = nil
	end
end

return M
