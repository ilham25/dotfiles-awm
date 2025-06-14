local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")

local ui_common = require("ui/common")
local utilities = require("utilities")
local media = require("module/media")
local user_system_signal = require("enums/user_system_signal")

return function()
	local image = wibox.widget({
		image = beautiful.icons.battery_empty,
		widget = wibox.widget.imagebox,
		forced_height = beautiful.dpi(60),
		forced_width = beautiful.dpi(60),
		resize = false,
		valign = "center",
		halign = "center",
		upscale = true,
		downscale = true,
	})

	local album_art = wibox.widget({
		{
			image,
			widget = wibox.container.background,
			forced_height = beautiful.dpi(60),
			forced_width = beautiful.dpi(60),
			bg = beautiful.colors.base,
			shape = gears.shape.rounded_rect,
			border_width = beautiful.dpi(1),
			border_color = beautiful.colors.surface1,
		},
		widget = wibox.container.constraint,
		height = beautiful.dpi(60),
		width = beautiful.dpi(60),
		strategy = "exact",
	})

	local title_textbox = wibox.widget({
		widget = wibox.widget.textbox,
		text = "-",
		font = beautiful.font_family .. "Medium 12",
		forced_height = beautiful.dpi(16),
	})
	local artist_textbox = wibox.widget({
		widget = wibox.widget.textbox,
		text = "-",
		font = beautiful.font_family .. " 9",
		forced_height = beautiful.dpi(16),
	})

	local progress_minute = wibox.widget({
		widget = wibox.widget.textbox,
		text = "--:--",
	})
	local media_length = wibox.widget({
		widget = wibox.widget.textbox,
		text = "--:--",
		halign = "right",
	})
	local media_slider = wibox.widget({
		bar_shape = gears.shape.rounded_bar,
		bar_height = beautiful.dpi(5),
		bar_color = beautiful.colors.text,
		handle_color = beautiful.colors.text,
		handle_shape = gears.shape.circle,
		handle_width = beautiful.dpi(15),
		handle_border_color = beautiful.border_color,
		handle_border_width = 1,
		value = 0,
		maximum = 100,
		minimum = 0,
		widget = wibox.widget.slider,
		forced_height = beautiful.dpi(20),
	})

	local media_play_toggle_button = wibox.widget({
		widget = wibox.widget.imagebox,
		stylesheet = utilities.svg.set_color(beautiful.colors.text),
		forced_height = beautiful.dpi(20),
		forced_width = beautiful.dpi(20),
		image = beautiful.icons.media_play,
	})
	local media_next_button = wibox.widget({
		widget = wibox.widget.imagebox,
		stylesheet = utilities.svg.set_color(beautiful.colors.text),
		forced_height = beautiful.dpi(20),
		forced_width = beautiful.dpi(20),
		image = beautiful.icons.media_next,
	})
	local media_previous_button = wibox.widget({
		widget = wibox.widget.imagebox,
		stylesheet = utilities.svg.set_color(beautiful.colors.text),
		forced_height = beautiful.dpi(20),
		forced_width = beautiful.dpi(20),
		image = beautiful.icons.media_previous,
	})

	local widget = ui_common.card.section_card({
		wibox.widget({
			{
				album_art,
				widget = wibox.container.place,
				valign = "top",
				halign = "left",
			},
			{
				{
					title_textbox,
					artist_textbox,
					layout = wibox.layout.fixed.vertical,
					spacing = beautiful.dpi(5),
				},
				{
					{
						progress_minute,
						nil,
						media_length,
						layout = wibox.layout.flex.horizontal,
					},
					media_slider,
					{
						{
							media_previous_button,
							media_play_toggle_button,
							media_next_button,
							spacing = beautiful.dpi(10),
							layout = wibox.layout.fixed.horizontal,
						},
						widget = wibox.container.place,
						halign = "center",
					},
					layout = wibox.layout.fixed.vertical,
				},
				spacing = beautiful.dpi(10),
				layout = wibox.layout.fixed.vertical,
			},
			spacing = beautiful.dpi(10),
			layout = wibox.layout.fixed.horizontal,
			forced_width = beautiful.dpi(160),
		}),
	})

	local user_dragging_slider = false

	awesome.connect_signal(user_system_signal.media.update, function(args)
		-- if not args.is_active then
		-- 	widget.visible = false
		-- end

		image.image = args.album_art

		utilities.color.get_dominant_color_from_image(args.album_art, function(new_color)
			widget.bg = new_color
			local is_light_color = utilities.color.is_light_color(new_color)

			local text_color = beautiful.colors.text

			if is_light_color then
				text_color = beautiful.colors.base
			end

			title_textbox.markup = utilities.text.colored_text(args.title, text_color)
			artist_textbox.markup = utilities.text.colored_text(args.title, text_color)
			media_length.markup = utilities.text.colored_text(media.format_duration(args.length), text_color)
			progress_minute.markup = utilities.text.colored_text(media.format_duration(args.position), text_color)
			media_slider.bar_color = text_color
			media_slider.handle_color = text_color
			media_play_toggle_button.stylesheet = utilities.svg.set_color(text_color)
			media_previous_button.stylesheet = utilities.svg.set_color(text_color)
			media_next_button.stylesheet = utilities.svg.set_color(text_color)

			if not user_dragging_slider then
				media_slider.value = math.ceil((args.position / args.length) * 100)
			end

			-- status
			if args.status == "Paused" then
				media_play_toggle_button.image = beautiful.icons.media_play
			else
				media_play_toggle_button.image = beautiful.icons.media_pause
			end
		end)
	end)

	-- Detect when user starts dragging
	media_slider:connect_signal("button::press", function()
		user_dragging_slider = true
	end)

	-- Detect when user releases
	media_slider:connect_signal("button::release", function()
		user_dragging_slider = false
	end)

	-- Handle value change only when user did it
	media_slider:connect_signal("property::value", function(_, new_value)
		if not user_dragging_slider then
			return
		end

		local seconds = math.ceil((new_value / 100) * media.length)
		media.set_position(seconds)
	end)

	media_play_toggle_button:connect_signal("button::press", function()
		media.toggle_play_pause()
	end)

	media_previous_button:connect_signal("button::press", function()
		media.previous()
	end)

	media_next_button:connect_signal("button::press", function()
		media.next()
	end)

	return widget
end
