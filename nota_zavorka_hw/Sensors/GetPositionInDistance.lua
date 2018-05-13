local sensorInfo = {
	name = "Position in radius from point",
	desc = "Return position in radius from point",
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

-- speedups
local GetPosition = Spring.GetUnitPosition

-- @retrun final point
return function(position, radius)
	local x,y,z = GetPosition(units[1])
	local distance = Vec3(x,y,z):Distance(position)
	if(radius == 0) then return { x=position.x, y=position.y, z=position.z } end
	local ratio = radius/distance
	local dx = ratio*(position.x-x)
	local dz = ratio*(position.z-z)
	return {
		x=position.x-dx,
		y=position.y,
		z=position.z-dz
	}
end