local sensorInfo = {
	name = "Send units to positions",
	desc = "Set units to positions",
	author = "Flanopal",
	date = "2018-05-13",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = 0 -- acutal, no caching

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end
local MoveOrder = Spring.GiveOrderToUnit

-- @send units
return function(points)
	local i=1
	while i<=#units and i<=#points do
		MoveOrder(units[i], CMD.MOVE, {points[i].x,points[i].y,points[i].z}, {})
		i=i+1
	end
	return 
end