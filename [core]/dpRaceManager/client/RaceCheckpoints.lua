RaceCheckpoints = {}
local checkpointsList = {}
local currentCheckpoint = 1

local currentMarker
local nextMarker

local function onMarkerHit(player)
	if source ~= currentMarker or player ~= localPlayer then
		return
	end
	playSoundFrontEnd(43)
	if currentCheckpoint < #checkpointsList then
		RaceCheckpoints.showNext()
	else
		outputDebugString("Client finished")
	end
end

local function destroyMarkers()
	if isElement(currentMarker) then
		destroyElement(currentMarker)
	end

	if isElement(nextMarker) then
		destroyElement(nextMarker)
	end
end

function RaceCheckpoints.start(checkpoints)
	checkpointsList = checkpoints
	currentCheckpoint = 0
	RaceCheckpoints.showNext()

	addEventHandler("onClientMarkerHit", resourceRoot, onMarkerHit)
end

function RaceCheckpoints.stop()
	destroyMarkers()
	removeEventHandler("onClientMarkerHit", resourceRoot, onMarkerHit)
end

function RaceCheckpoints.showNext()
	destroyMarkers()
	currentCheckpoint = currentCheckpoint + 1

	local cp = checkpointsList[currentCheckpoint]
	local x, y, z = unpack(cp)
	local r,g,b = exports.dpUI:getThemeColor()
	currentMarker = createMarker(x, y, z, "checkpoint", 8, r, g, b)
	currentMarker.dimension = Race.dimension

	local isLast = currentCheckpoint == #checkpointsList
	if not isLast then
		local cp = checkpointsList[currentCheckpoint + 1]
		local x, y, z = unpack(cp)
		currentMarker:setTarget(x, y, z)

		nextMarker = createMarker(x, y, z, "checkpoint", 8, r, g, b, 100)
		nextMarker.dimension = Race.dimension
		local isLast = currentCheckpoint + 1 == #checkpointsList
		if isLast then
			nextMarker.icon = "finish"
		end
	else
		currentMarker.icon = "finish"
	end
end