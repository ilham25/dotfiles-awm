local gfs = require("gears.filesystem")
local icons_path = gfs.get_configuration_dir() .. "theme/default/icons/"

local icons = {}

icons.wifi = icons_path .. "wifi.svg"

return icons
