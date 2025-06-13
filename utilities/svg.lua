local utility = {}

utility.set_color = function(color)
	return "svg { color: " .. color .. "; }"
end

return utility
