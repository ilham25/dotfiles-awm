----------------------------
-- Global Theme Variables --
----------------------------

local gfs = require("gears.filesystem")
local variables = {}

variables.home = os.getenv("HOME")
variables.user = os.getenv("USER")
variables.config_dir = gfs.get_configuration_dir()

--- Wallpapers Setup
local wallpapers = {}

wallpapers.get_dir = function()
	return variables.home .. "/Pictures/Wallpapers/"
end

wallpapers.default = wallpapers.get_dir() .. "aether-dark.png"

variables.wallpapers = wallpapers

--- Color Palette Setup
variables.palette = "catpuccin/mocha"

--- Other vars
variables.font_family = "Product Sans"
variables.font_size = 11

return variables
