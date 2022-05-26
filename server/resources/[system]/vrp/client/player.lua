-----------------------------------------------------------------------------------------------------------------------------------------
-- SETHEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.setHealth(health)
	local ped = PlayerPedId()
	SetEntityHealth(ped,health)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEHEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.updateHealth(number)
	local ped = PlayerPedId()
	local health = GetEntityHealth(ped)
	if health > 101 then
		SetEntityHealth(ped,health + number)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOWNHEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.downHealth(number)
	local ped = PlayerPedId()
	local health = GetEntityHealth(ped)

	SetEntityHealth(ped,health - number)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYSKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.applySkin(mHash)
	RequestModel(mHash)
	while not HasModelLoaded(mHash) do
		Citizen.Wait(1)
	end

	if HasModelLoaded(mHash) then
		SetPlayerModel(PlayerId(),mHash)
		SetPedComponentVariation(PlayerPedId(),5,0,0,1)
		SetModelAsNoLongerNeeded(mHash)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETENTITYCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.getEntityCoords()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local _,GroundZ = GetGroundZFor_3dCoord(coords["x"],coords["y"],coords["z"])

	return {
		["x"] = coords["x"],
		["y"] = coords["y"],
		["z"] = GroundZ
	}
end