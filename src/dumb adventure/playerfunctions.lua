local playerFilter = function(item, other) 
	if item.main then
		return "slide"
	else
		return "cross"
	end
end

return {
  playerFilter = playerFilter
}