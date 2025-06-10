local awful = require("awful")
local variables = require("config/variables")

awful.spawn.with_shell(variables.config_dir .. "config/autostart.sh")
