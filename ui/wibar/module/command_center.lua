local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local make_popup = require("ui/wibar/module/make_popup")
local naughty = require("naughty")
local ui_common = require("ui/common")
local utilities = require("utilities")
local volume = require("module/volume")
local user_system_signal = require("enums/user_system_signal")

return function()
	-- Button in the wibar
	local brightness_button = wibox.widget({
		{
			text = "󰜘",
			font = "FiraCode Nerd Font Mono 12",
			widget = wibox.widget.textbox,
		},
		margins = beautiful.dpi(6),
		widget = wibox.container.margin,
	})

	local function colored_text(text, color)
		return '<span foreground="' .. color .. '">' .. text .. "</span>"
	end

	local connectivity_item = function(def)
		def = def or {}
		local value = def.value or ""
		local active = false
		local active_bg = def.active_bg or beautiful.colors.base
		local icon_active_color = def.icon_active_color or beautiful.colors.text
		local icon_active = def.icon_active or def.icon or ""

		local value_textbox = wibox.widget({
			markup = colored_text(value or "", beautiful.colors.subtext1),
			widget = wibox.widget.textbox,
			font = beautiful.font_family .. " 9",
			align = "left",
		})

		local icon_text = wibox.widget({
			widget = wibox.widget.textbox,
			markup = colored_text(def.icon or "", beautiful.colors.text),
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
			value_textbox.markup = colored_text(new_value, beautiful.colors.subtext1)
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
			icon_text.markup = colored_text(icon, fg)

			active = new_value
		end

		build.value = value
		build.active = active

		return build
	end

	local sound_item = connectivity_item({
		title = "Sound",
		icon = "󰝟",
		value = volume.get(),
		icon_active = "󰕾",
		active_bg = beautiful.colors.green,
		icon_active_color = beautiful.colors.base,
	})

	sound_item:connect_signal("button::press", function()
		utilities.volume.toggle_mute()
		utilities.volume.get_mute_value(function(value)
			sound_item:set_active_value(value)
			sound_item.active = value
		end)
	end)

	utilities.volume.get_mute_value(function(value)
		sound_item:set_active_value(value)
		sound_item.active = value
	end)

	local wifi_item = connectivity_item({
		title = "Wi-Fi",
		icon = "󰤨",
		value = "Iruha",
		active_bg = beautiful.colors.mauve,
		icon_active_color = beautiful.colors.base,
	})

	wifi_item:connect_signal("button::press", function()
		wifi_item:set_active_value(not wifi_item.active)
		wifi_item.active = not wifi_item.active
	end)

	local bluetooth_item = connectivity_item({
		title = "Bluetooth",
		icon = "󰂯",
		value = "Off",
		icon_size = 16,
		active_bg = beautiful.colors.teal,
		icon_active_color = beautiful.colors.base,
	})

	bluetooth_item:connect_signal("button::press", function()
		bluetooth_item:set_active_value(not bluetooth_item.active)
		bluetooth_item.active = not bluetooth_item.active
	end)

	local connectivity_card = ui_common.card.section_card({
		wibox.widget({
			wifi_item,
			bluetooth_item,
			sound_item,
			spacing = beautiful.dpi(10),
			layout = wibox.layout.fixed.vertical,
		}),
	})

	local other_card = ui_common.card.section_card({
		widget = wibox.layout.fixed.vertical,
	})

	local focus_card = ui_common.card.section_card({
		{
			text = "",
			widget = wibox.widget.textbox,
		},
		widget = wibox.layout.fixed.horizontal,
	})

	local extra_card_1 = ui_common.card.section_card({
		{
			text = "",
			widget = wibox.widget.textbox,
		},
		widget = wibox.layout.fixed.horizontal,
	})

	local extra_card_2 = ui_common.card.section_card({
		{
			text = "",
			widget = wibox.widget.textbox,
		},
		widget = wibox.layout.fixed.horizontal,
	})

	local additional_grid = wibox.widget({
		{
			row_index = 1,
			col_index = 1,
			col_span = 2,
			widget = focus_card,
		},
		{
			row_index = 2,
			col_index = 1,
			col_span = 1,
			widget = extra_card_1,
		},
		{
			row_index = 2,
			col_index = 2,
			col_span = 1,
			widget = extra_card_2,
		},
		homogeneous = true,
		expand = true,
		widget = wibox.layout.grid,
		spacing = beautiful.dpi(10),
	})

	local brightness_slider = ui_common.slider.slider()
	local brightness_card = ui_common.card.section_card({
		{
			{
				text = "Brightness",
				widget = wibox.widget.textbox,
			},
			brightness_slider,
			spacing = beautiful.dpi(6),
			widget = wibox.layout.fixed.vertical,
		},
	})

	utilities.brightness.get_initial_value(function(value)
		brightness_slider.value = value
	end)
	brightness_slider:connect_signal("property::value", function(_, new_value)
		utilities.brightness.set_value(new_value)
	end)

	local sound_slider = ui_common.slider.slider()
	local sound_card = ui_common.card.section_card({
		{
			{
				text = "Sound",
				widget = wibox.widget.textbox,
			},
			sound_slider,
			spacing = beautiful.dpi(6),
			widget = wibox.layout.fixed.vertical,
		},
	})

	sound_slider:connect_signal("property::value", function(_, new_value)
		volume.set(new_value)
	end)

	awesome.connect_signal(user_system_signal.volume.update, function(new_value)
		sound_item:update_value(new_value .. "%")
		sound_slider.value = new_value
	end)

	local content = wibox.widget({
		{
			row_index = 1,
			col_index = 1,
			col_span = 2,
			widget = connectivity_card,
		},
		{
			row_index = 1,
			col_index = 3,
			col_span = 2,
			widget = additional_grid,
		},
		{
			row_index = 2,
			col_index = 1,
			col_span = 4,
			widget = brightness_card,
		},
		{
			row_index = 3,
			col_index = 1,
			col_span = 4,
			widget = sound_card,
		},
		homogeneous = false,
		expand = true,
		spacing = beautiful.dpi(10),
		column_count = 4,
		layout = wibox.layout.grid,
		-- border_width = 1,
		-- border_color = "#ffffff",
	})

	local popup = make_popup(content, brightness_button)

	brightness_button:connect_signal("button::press", function()
		awful.placement.next_to(popup, {
			preferred_positions = { "bottom" },
			preferred_anchors = { "middle" },
			offset = { y = beautiful.dpi(6) },
		})

		popup.visible = not popup.visible
	end)

	return brightness_button
end
