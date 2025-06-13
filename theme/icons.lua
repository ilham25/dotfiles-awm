local gfs = require("gears.filesystem")
local icons_path = gfs.get_configuration_dir() .. "theme/default/icons/"

local icons = {}

icons.wifi = icons_path .. "wifi.svg"
icons.volume_high = icons_path .. "volume_high.svg"
icons.volume_low = icons_path .. "volume_low.svg"
icons.volume_medium = icons_path .. "volume_medium.svg"
icons.volume_mute = icons_path .. "volume_mute.svg"
icons.volume_off = icons_path .. "volume_off.svg"

icons.battery_charging_empty = icons_path .. "battery_charging_empty.svg"
icons.battery_charging_low = icons_path .. "battery_charging_low.svg"
icons.battery_charging_medium = icons_path .. "battery_charging_medium.svg"
icons.battery_charging_high = icons_path .. "battery_charging_high.svg"
icons.battery_charging_full = icons_path .. "battery_charging_full.svg"

icons.battery_empty = icons_path .. "battery_empty.svg"
icons.battery_low = icons_path .. "battery_low.svg"
icons.battery_medium = icons_path .. "battery_medium.svg"
icons.battery_high = icons_path .. "battery_high.svg"
icons.battery_full = icons_path .. "battery_full.svg"

icons.image_outline = icons_path .. "image_outline.svg"
icons.video_outline = icons_path .. "video_outline.svg"

return icons
