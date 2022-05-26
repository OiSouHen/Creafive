-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("checkin")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local treatmentUser = false
local treatmentTimer = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- BEDSIN
-----------------------------------------------------------------------------------------------------------------------------------------
local bedsIn = {
	["Santos"] = {
		{ 307.72,-581.74,44.2,340.16 },
		{ 311.06,-582.96,44.2,340.16 },
		{ 314.46,-584.2,44.2,340.16 },
		{ 317.68,-585.37,44.2,340.16 },
		{ 322.62,-587.16,44.2,340.16 },
		{ 324.26,-582.8,44.2,158.75 },
		{ 319.42,-581.05,44.2,158.75 },
		{ 313.93,-579.04,44.2,158.75 },
		{ 309.35,-577.38,44.2,158.75 }
	},
	["Sandy"] = {
		{ 1830.03,3679.52,35.18,28.35 },
		{ 1827.08,3677.79,35.18,28.35 },
		{ 1828.05,3683.17,35.18,212.6 },
		{ 1824.95,3681.45,35.18,212.6 }
	},
	["Paleto"] = {
		{ -252.15,6323.11,33.35,133.23 },
		{ -246.98,6317.95,33.35,133.23 },
		{ -245.27,6316.22,33.35,133.23 },
		{ -251.03,6310.51,33.35,317.49 },
		{ -252.63,6312.12,33.35,317.49 },
		{ -254.39,6313.88,33.35,317.49 },
		{ -256.1,6315.58,33.35,317.49 }
	},
	["Bolingbroke"] = {
		{ 1771.98,2591.79,46.66,87.88 },
		{ 1771.98,2594.88,46.66,87.88 },
		{ 1771.98,2597.95,46.66,87.88 },
		{ 1761.87,2597.73,46.66,272.13 },
		{ 1761.87,2594.64,46.66,272.13 },
		{ 1761.87,2591.56,46.66,272.13 }
	},
	["Clandestine"] = {
		{ -471.86,6287.42,14.63,235.28 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCHECKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("checkin:initCheck")
AddEventHandler("checkin:initCheck",function(Hospital)
	local ped = PlayerPedId()

	for _,v in pairs(bedsIn[Hospital]) do
		local checkPos = nearestPlayer(v[1],v[2],v[3])
		if not checkPos then
			if vSERVER.paymentCheckin() then
				TriggerEvent("inventory:preventWeapon",true)
				LocalPlayer["state"]["Commands"] = true
				LocalPlayer["state"]["Cancel"] = true
				TriggerEvent("resetDiagnostic")
				TriggerEvent("resetBleeding")

				if GetEntityHealth(ped) <= 101 then
					vRP.revivePlayer(102)
				end

				DoScreenFadeOut(0)
				Citizen.Wait(1000)

				treatmentUser = true
				SetEntityHeading(ped,v[4])
				SetEntityCoords(ped,v[1],v[2],v[3],1,0,0,0)
				vRP.playAnim(false,{"anim@gangops@morgue@table@","body_search"},true)

				Citizen.Wait(1000)
				DoScreenFadeIn(1000)
			end

			break
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEARESTPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function nearestPlayers(x,y,z)
	local userList = {}
	local ped = PlayerPedId()
	local userPlayers = GetPlayers()

	for k,v in pairs(userPlayers) do
		local uPlayer = GetPlayerFromServerId(k)
		if uPlayer ~= PlayerId() and NetworkIsPlayerConnected(uPlayer) then
			local uPed = GetPlayerPed(uPlayer)
			local uCoords = GetEntityCoords(uPed)
			local distance = #(uCoords - vector3(x,y,z))
			if distance <= 2 then
				userList[uPlayer] = distance
			end
		end
	end

	return userList
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEARESTPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function nearestPlayer(x,y,z)
	local userSelect = false
	local minRadius = 2.0001
	local userList = nearestPlayers(x,y,z)

	for _,_Infos in pairs(userList) do
		if _Infos <= minRadius then
			minRadius = _Infos
			userSelect = true
		end
	end

	return userSelect
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function GetPlayers()
	local pedList = {}

	for _,_player in ipairs(GetActivePlayers()) do
		pedList[GetPlayerServerId(_player)] = true
	end

	return pedList
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTTREATMENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("checkin:startTreatment")
AddEventHandler("checkin:startTreatment",function()
	if not treatmentUser then
		LocalPlayer["state"]["Commands"] = true
		TriggerEvent("resetDiagnostic")
		TriggerEvent("resetBleeding")
		treatmentUser = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTREATMENT
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if treatmentUser then
			if GetGameTimer() >= treatmentTimer then
				local ped = PlayerPedId()
				local health = GetEntityHealth(ped)
				treatmentTimer = GetGameTimer() + 1000

				if health < 200 then
					SetEntityHealth(ped,health + 1)
				else
					treatmentUser = false
					LocalPlayer["state"]["Cancel"] = false
					LocalPlayer["state"]["Commands"] = false
					TriggerEvent("Notify","amarelo","Tratamento concluido.",5000)
				end
			end
		end

		Citizen.Wait(1000)
	end
end)