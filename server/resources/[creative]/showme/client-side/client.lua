-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local showMe = {}
local showActive = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOWME:PRESSME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("showme:pressMe")
AddEventHandler("showme:pressMe",function(source,message,seconds,border)
	local pedSource = GetPlayerFromServerId(source)
	if pedSource ~= -1 then
		showMe[GetPlayerPed(pedSource)] = { message,seconds,border }
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOWME:REMOVEME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("showme:removeMe")
AddEventHandler("showme:removeMe",function(source)
	local pedSource = GetPlayerFromServerId(source)
	if pedSource ~= -1 then
		local ped = GetPlayerPed(pedSource)

		if showActive[ped] then
			SendNUIMessage({ action = "remove", id = ped })
			showActive[ped] = nil
			showMe[ped] = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSHOWMEDISPLAY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)

		for k,v in pairs(showMe) do
			local coordsMe = GetEntityCoords(k)
			local distance = #(coords - coordsMe)
			if distance <= 5 then
				timeDistance = 1

				local _,x,y = GetScreenCoordFromWorldCoord(coordsMe["x"],coordsMe["y"],coordsMe["z"] + 0.7)
				if showActive[k] == nil then
					SendNUIMessage({ show = true, text = v[1], id = k, x = x, y = y, border = v[3] })
					showActive[k] = true
				end

				SendNUIMessage({ action = "update", text = v[1], id = k, x = x, y = y, border = v[3] })
			else
				if showActive[k] then
					SendNUIMessage({ action = "remove", id = k })
					showActive[k] = nil
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRHEADSHOWMETIMER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		for k,v in pairs(showMe) do
			if v[2] > 0 then
				v[2] = v[2] - 1

				if v[2] <= 0 then
					showMe[k] = nil

					if showActive[k] then
						SendNUIMessage({ action = "remove", id = k })
						showActive[k] = nil
					end
				end
			end
		end

		Citizen.Wait(1000)
	end
end)