-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("postit",cRP)
vSERVER = Tunnel.getInterface("postit")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local displayText = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCOORDSFROMCAM
-----------------------------------------------------------------------------------------------------------------------------------------
function GetCoordsFromCam(distance,coords)
	local rotation = GetGameplayCamRot()
	local adjustedRotation = vector3((math.pi / 180) * rotation["x"],(math.pi / 180) * rotation["y"],(math.pi / 180) * rotation["z"])
	local direction = vector3(-math.sin(adjustedRotation[3]) * math.abs(math.cos(adjustedRotation[1])),math.cos(adjustedRotation[3]) * math.abs(math.cos(adjustedRotation[1])),math.sin(adjustedRotation[1]))

	return vector3(coords[1] + direction[1] * distance, coords[2] + direction[2] * distance, coords[3] + direction[3] * distance)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POSTIT:INITPOSTIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("postit:initPostit")
AddEventHandler("postit:initPostit",function()
	Citizen.CreateThread(function()
		while true do
			local ped = PlayerPedId()
			local cam = GetGameplayCamCoord()
			local handle = StartExpensiveSynchronousShapeTestLosProbe(cam,GetCoordsFromCam(25.0,cam),-1,ped,4)
			local _,_,coords = GetShapeTestResult(handle)

			DrawMarker(28,coords["x"],coords["y"],coords["z"],0.0,0.0,0.0,0.0,0.0,0.0,0.05,0.05,0.05,46,110,76,255,0,0,0,0)

			if IsControlJustPressed(1,38) then
				vSERVER.newPostIts(coords)
				break
			end

			Citizen.Wait(1)
		end
	end)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADPOSTITS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)

		for k,v in pairs(GlobalState["Postit"]) do
			local distance = #(coords - vector3(v[1],v[2],v[3]))
			if distance <= v[5] then
				local _,x,y = GetScreenCoordFromWorldCoord(v[1],v[2],v[3])
				if displayText[k] == nil then
					SendNUIMessage({ show = true, text = "", id = k, x = x, y = y })
					displayText[k] = true
				end

				timeDistance = 1
				SendNUIMessage({ action = "update", text = v[4], id = k, x = x, y = y })

				if IsControlJustPressed(1,47) and distance <= 1 then
					vSERVER.deletePostIts(k)
				end
			else
				if displayText[k] then
					SendNUIMessage({ action = "remove", id = k })
					displayText[k] = nil
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POSTIT:DELETEPOSTITS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("postit:deletePostIts")
AddEventHandler("postit:deletePostIts",function(id)
	if displayText[id] then
		SendNUIMessage({ action = "remove", id = id })
		displayText[id] = nil
	end
end)