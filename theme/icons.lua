local gfs = require("gears.filesystem")
local icons_path = gfs.get_configuration_dir() .. "theme/default/icons/"

local icons = {}

icons.wifi = icons_path .. "wifi.svg"
icons.volume_high = icons_path .. "volume_high.svg"
icons.volume_low = icons_path .. "volume_low.svg"
icons.volume_medium = icons_path .. "volume_medium.svg"
icons.volume_mute = icons_path .. "volume_mute.svg"
icons.volume_off = icons_path .. "volume_off.svg"

return icons
