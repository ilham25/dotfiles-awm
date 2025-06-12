local utility = {}

utility.colored_text = function(text, color)
	return '<span foreground="' .. color .. '">' .. text .. "</span>"
end

return utility
