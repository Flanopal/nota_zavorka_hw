local sensorInfo = {
	name = "Get hills in map",
	desc = "Return hill positions",
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
local GetHeight = Spring.GetGroundHeight

function IsSame(a,b,radius)
	if (a-b < radius and a-b > -radius) then return true end
	return false
end

function GetMiddle(x,z)
	local height = GetHeight(x,z)
	local leftX = x
	local rightX = x
	local topZ = z
	local botZ = z
	while IsSame (GetHeight(x,topZ),height,5) do topZ = topZ -20 end
	while IsSame (GetHeight(x,botZ),height,5) do botZ = botZ +20 end
	while IsSame (GetHeight(leftX,z),height,5) do leftX = leftX -20 end
	while IsSame (GetHeight(rightX,z),height,5) do rightX = rightX +20 end
	local midX = leftX + (rightX-leftX)/2
	local midZ = topZ + (botZ - topZ)/2

	if (botZ-topZ < 50) then midX=-1 end
	if (rightX-leftX < 50) then midX=-1 end	
	return {
		midX=midX,
		midZ=midZ,
		rightX=x
	}
end

function NotContains(elements, elem)
	if(#elements == 0) then return true end
	for i=1, #elements do
		if (IsSame(elements[i].x,elem.x,40) and IsSame(elements[i].y,elem.y,40)) then return false end
	end
	return true		
end

-- @retrun final point
return function()
	local sizeX = Game.mapSizeX
	local sizeZ = Game.mapSizeZ
	local y
	local prevY = GetHeight(10,10)
	local x = 10
	local z = 10
	local middle
	local counter=0
	local hills = {}
	while z<sizeZ do
		while x<sizeX do
			y=GetHeight(x,z)			
			if(y-prevY<10) then
				x=x+150
				prevY=y
			else
				
				middle=GetMiddle(x,z)
				local vector = Vec3(middle.midX,y,middle.midZ)
				if(middle.midX>0 and NotContains(hills,vector)) then hills[#hills+1]=vector end
				x=middle.rightX
				prevY=GetHeight(x,z)
			end
		
		end
		z=z+150
		x=10
	end
	return hills
end