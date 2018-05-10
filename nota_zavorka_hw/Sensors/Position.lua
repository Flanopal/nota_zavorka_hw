local sensorInfo = {
	name = "unitPosition",
	desc = "Return position of unit.",
	author = "Flanopal",
	date = "201-05-10",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = 0 -- acutal, no caching

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

-- speedups
local GetPosition = Spring.GetUnitPosition

-- @description return current wind statistics
return function(unitID)
	local x, y, z = GetPosition(unitID)
	return {
		x=x,
		y=y,
		z=z,
	}
end