local awful = require('awful')
local wibox = require('wibox')
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

--- The titlebar to be used on normal clients.
return function(c, bg)
   -- Buttons for the titlebar.
   local buttons = {
      awful.button(nil, 1, function()
         c:activate({ context = 'titlebar', action = 'mouse_move' })
      end),
      awful.button(nil, 3, function()
         c:activate({ context = 'titlebar', action = 'mouse_resize' })
      end)
   }
  
   local titlebar = awful.titlebar(c, { size = beautiful.titlebar_size, position = 'left', bg = bg })

  -- Draws the client titlebar at the default position (top) and size.
   titlebar.widget = wibox.container.margin(
      wibox.widget({
        layout = wibox.layout.align.vertical,
        -- Left
        {
           layout = wibox.layout.fixed.vertical,
           -- Widgets
           awful.titlebar.widget.closebutton(c),
           awful.titlebar.widget.maximizedbutton(c),
           awful.titlebar.widget.stickybutton(c),
        },
        {
           layout  = wibox.layout.flex.vertical,
           -- { -- Title
           --    widget = awful.titlebar.widget.titlewidget(c),
           --    halign = 'center'
           -- },
           buttons = buttons
        },
        {
           layout  = wibox.layout.fixed.vertical,
           -- awful.titlebar.widget.iconwidget(c),
           awful.titlebar.widget.floatingbutton(c),
           awful.titlebar.widget.ontopbutton(c),
           buttons = buttons
        }
     }),
     dpi(6), dpi(6), dpi(8), dpi(4) -- left, right, top, bottom padding in pixels
  )

  return titlebar
end
