local signal_prefix = "user_system::"

local signal = {}

local volume = {
	toggle_mute = signal_prefix .. "volume::toggle_mute",
	up = signal_prefix .. "volume::up",
	down = signal_prefix .. "volume::down",
	update = signal_prefix .. "volume::update",
}

local brightness = {
	up = signal_prefix .. "brightness_up",
	down = signal_prefix .. "brightness_down",
}

signal.volume = volume
signal.brightness = brightness

return signal
