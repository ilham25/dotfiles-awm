local awful = require("awful")

local user_system_signal = require("enums/user_system_signal")

local media = {
	title = nil,
	artist = nil,
	album_art = nil,
	length = nil, -- in seconds
	position = nil, -- in seconds
	status = nil, -- "Playing", "Paused", or "Stopped"
	is_active = false,
}

function media.sync_from_system()
	-- Check if any player is available
	awful.spawn.easy_async_with_shell(
		"playerctl metadata --format '{{artist}}|{{title}}|{{mpris:artUrl}}|{{mpris:length}}'",
		function(out)
			local artist, title, art_url, length_us = out:match("^(.-)|(.+)|(.+)|(%d+)$")

			-- if metadata is missing, then no media is playing
			if not (artist and title and length_us) then
				media.is_active = false
				media.title = nil
				media.artist = nil
				media.album_art = nil
				media.length = nil
				media.position = nil
				media.status = nil

				awesome.emit_signal(user_system_signal.media.update, media)
				return
			end

			-- Metadata is available
			media.is_active = true
			media.artist = artist
			media.title = title
			media.album_art = art_url:match("^file://") and art_url:gsub("^file://", "") or nil
			media.length = math.floor(tonumber(length_us) / 1000000)

			-- Get playback status (Playing / Paused)
			awful.spawn.easy_async_with_shell("playerctl status", function(status_out)
				local status = status_out:match("[^\n]+")
				if status == "Playing" or status == "Paused" then
					media.status = status
				else
					media.status = "Stopped"
				end

				-- Get current position
				awful.spawn.easy_async_with_shell("playerctl position", function(pos_out)
					local pos = tonumber(pos_out)
					media.position = pos and math.floor(pos) or nil

					-- Emit final signal
					awesome.emit_signal("user::media::update", media)
				end)
			end)
		end
	)
end

return media
