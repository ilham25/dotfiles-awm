local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')

local colors = require("theme/colors")

-- Add a titlebar if titlebars_enabled is set to true for the client in `config/rules.lua`.
client.connect_signal('request::titlebars', function(c)
   -- While this isn't actually in the example configuration, it's the most sane thing to do.
   -- If a client expressly says not to draw titlebars on it, just don't.
   if c.requests_no_titlebars then return end

   local titlebar = require('ui.titlebar').normal
   if c.class == 'kitty' and titlebar then
      titlebar(c, colors.mantle)
      return
   end
    
   titlebar(c)
   -- require('ui.titlebar').normal(c)
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal('mouse::enter', function(c)
   c:activate({ context = 'mouse_enter', raise = false })
end)

-- Fix weird windows height
client.connect_signal("request::manage", function(c)
	if c.maximized then
		c.x = c.screen.workarea.x
		c.y = c.screen.workarea.y
		c.width = c.screen.workarea.width
		c.height = c.screen.workarea.height
	end
end)

-- Add rounded corner
client.connect_signal("manage", function(c)
  c.shape = function(cr, w, h)
    gears.shape.rounded_rect(cr, w, h, beautiful.border_radius or 10)
  end
end)

client.connect_signal("property::fullscreen", function(c)
    if c.fullscreen then
        c.shape = nil
    else
        c.shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, beautiful.border_radius or 10)
        end
    end
end)

