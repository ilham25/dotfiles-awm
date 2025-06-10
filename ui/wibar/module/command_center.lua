local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

return function()
  -- Brightness slider widget
  local brightness_slider = wibox.widget {
      bar_shape           = gears.shape.rounded_rect,
      bar_height          = 4,
      bar_color           = "#555555",
      handle_color        = "#ffaa00",
      handle_shape        = gears.shape.circle,
      minimum             = 0,
      maximum             = 100,
      value               = 50,
      forced_width        = 150,
      widget              = wibox.widget.slider,
  }

  -- Brightness control on change
  brightness_slider:connect_signal("property::value", function(_, value)
      awful.spawn("brightnessctl set " .. math.floor(value) .. "%", false)
  end)

  -- Popup widget
  local brightness_popup = awful.popup {
      widget = {
          {
              brightness_slider,
              margins = 10,
              widget = wibox.container.margin
          },
          bg = "#222222",
          shape = gears.shape.rounded_rect,
          widget = wibox.container.background,
      },
      visible = false,
      ontop = true,
      border_width = 1,
      border_color = "#444444",
      placement = function(d)
          awful.placement.bottom_left(d, { margins = { bottom = 30, left = 10 }, honor_workarea = true })
      end,
      preferred_positions = { "bottom" }
  }

  -- Button in the wibar
  local brightness_button = wibox.widget {
      {
          text = "☀",
          font = "sans 16",
          widget = wibox.widget.textbox
      },
      margins = 6,
      widget = wibox.container.margin
  }

  brightness_button:connect_signal("button::press", function()
      brightness_popup.visible = not brightness_popup.visible
  end)
 
  return brightness_button
end
