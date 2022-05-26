-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 100
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) and IsPedJumping(ped) then
			timeDistance = 1

			if IsControlJustReleased(1,51) then
				local tackled = {}
				local coords = GetEntityForwardVector(ped)

				TriggerServerEvent("upgradeStress",5)
				SetPedToRagdollWithFall(ped,1000,1000,0,coords,1.0,0.0,0.0,0.0,0.0,0.0,0.0)

				while IsPedRagdoll(ped) do
					for _,v in ipairs(touchedPlayers()) do
						if not tackled[v] then
							tackled[v] = true
							TriggerServerEvent("inventory:Cancel")
							TriggerServerEvent("tackle:Update",GetPlayerServerId(v),{ coords["x"],coords["y"],coords["z"] })
						end
					end

					Citizen.Wait(1)
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TACKLE:PLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("tackle:Player")
AddEventHandler("tackle:Player",function(coords)
	SetPedToRagdollWithFall(PlayerPedId(),10000,10000,0,coords[1],coords[2],coords[3],10.0,0.0,0.0,0.0,0.0,0.0,0.0)
	TriggerServerEvent("inventory:Cancel")
	TriggerServerEvent("upgradeStress",5)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOUCHEDPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function touchedPlayers()
	local players = {}
	local ped = PlayerPedId()
	for k,v in ipairs(GetActivePlayers()) do
		local uPed = GetPlayerPed(v)
		if IsEntityTouchingEntity(ped,uPed) and not IsPedInAnyVehicle(uPed) then
			table.insert(players,v)
		end
	end

	return players
end