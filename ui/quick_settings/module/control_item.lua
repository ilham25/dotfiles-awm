local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")

local utilities = require("utilities")

return function(def)
	def = def or {}
	local value = def.value or ""
	local active = false
	local active_bg = def.active_bg or beautiful.colors.base
	local icon_active_color = def.icon_active_color or beautiful.colors.text
	local icon_active = def.icon_active or def.icon or ""

	local value_textbox = wibox.widget({
		markup = utilities.text.colored_text(value or "", beautiful.colors.subtext1),
		widget = wibox.widget.textbox,
		font = beautiful.font_family .. " 9",
		align = "left",
	})

	local icon_text = wibox.widget({
		widget = wibox.widget.textbox,
		markup = utilities.text.colored_text(def.icon or "", beautiful.colors.text),
		font = "FiraCode Nerd Font Mono " .. (def.icon_size and tostring(def.icon_size) or "20"),
	})

	local indicator = wibox.widget({
		{
			widget = wibox.container.place,
			valign = "center",
			halign = "center",
			icon_text,
		},
		bg = beautiful.colors.base,
		shape = gears.shape.circle,
		border_width = beautiful.dpi(1),
		border_color = beautiful.colors.surface1,
		widget = wibox.container.background,
		forced_height = beautiful.dpi(40),
		forced_width = beautiful.dpi(40),
	})

	local build = wibox.widget({
		layout = wibox.layout.fixed.horizontal,
		spacing = beautiful.dpi(8),

		-- Circle icon
		indicator,
		-- Centered Wi-Fi text
		{
			widget = wibox.container.place,
			valign = "center",
			halign = "left",
			{
				layout = wibox.layout.fixed.vertical,
				{
					text = def.title or "",
					widget = wibox.widget.textbox,
					font = beautiful.font_family .. "Medium 11",
					align = "left",
				},
				value_textbox,
			},
		},
	})

	function build:update_value(new_value)
		value = new_value
		value_textbox.markup = utilities.text.colored_text(new_value, beautiful.colors.subtext1)
	end

	function build:set_active_value(new_value)
		local bg = beautiful.colors.base
		local fg = beautiful.colors.text
		local icon = def.icon or ""

		if new_value then
			bg = active_bg
			fg = icon_active_color
			icon = icon_active
		end

		indicator.bg = bg
		icon_text.markup = utilities.text.colored_text(icon, fg)

		active = new_value
	end

	build.value = value
	build.active = active

	return build
end
