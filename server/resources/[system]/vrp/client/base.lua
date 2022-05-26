-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
tvRP = {}
Tunnel.bindInterface("vRP",tvRP)
vRPS = Tunnel.getInterface("vRP")
Proxy.addInterface("vRP",tvRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local animFlags = 0
local animDict = nil
local animName = nil
local Crensa = {}
local blipsAdmin = false
local animActived = false
local showPassports = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPSADMIN
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.blipsAdmin()
	blipsAdmin = not blipsAdmin

	while blipsAdmin do
		Crensa = vRPS.userPlayers()
		Citizen.Wait(10000)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		if blipsAdmin then
			timeDistance = 1

			local ped = PlayerPedId()
			local userPlayers = GetPlayers()
			local coords = GetEntityCoords(ped)

			for k,v in pairs(userPlayers) do
				local uPlayer = GetPlayerFromServerId(k)
				if uPlayer ~= PlayerId() and NetworkIsPlayerConnected(uPlayer) then
					local uPed = GetPlayerPed(uPlayer)
					local uCoords = GetEntityCoords(uPed)
					local distance = #(coords - uCoords)
					if distance <= 1000 and Crensa[k] ~= nil then
						DrawText3D(uCoords["x"],uCoords["y"],uCoords["z"] + 1.10,"~o~ID:~w~ "..Crensa[k].."     ~g~H:~w~ "..GetEntityHealth(uPed).."     ~y~A:~w~ "..GetPedArmour(uPed),0.275)
					end
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEARESTPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.nearestPlayers(vDistance)
	local userList = {}
	local ped = PlayerPedId()
	local userPlayers = GetPlayers()
	local coords = GetEntityCoords(ped)

	for k,v in pairs(userPlayers) do
		local uPlayer = GetPlayerFromServerId(k)
		if uPlayer ~= PlayerId() and NetworkIsPlayerConnected(uPlayer) then
			local uPed = GetPlayerPed(uPlayer)
			local uCoords = GetEntityCoords(uPed)
			local distance = #(coords - uCoords)
			if distance <= vDistance then
				userList[uPlayer] = { distance,k }
			end
		end
	end

	return userList
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVEPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.activePlayers()
	local activePlayers = {}
	for _,v in ipairs(GetActivePlayers()) do
		activePlayers[#activePlayers + 1] = GetPlayerServerId(v)
	end

	return activePlayers
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEARESTPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.nearestPlayer(radius)
	if radius == nil then
		radius = 2
	end

	local userSelect = false
	local minRadius = radius + 0.0001
	local userList = tvRP.nearestPlayers(radius)

	for _,v in pairs(userList) do
		if v[1] <= minRadius then
			userSelect = v[2]
			minRadius = v[1]
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
-- PLAYANIM
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.playAnim(animUpper,animSequency,animLoop)
	local playFlags = 0
	local ped = PlayerPedId()
	if animSequency["task"] then
		tvRP.stopAnim(true)

		if animSequency["task"] == "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER" then
			local coords = GetEntityCoords(ped)
			TaskStartScenarioAtPosition(ped,animSequency["task"],coords["x"],coords["y"],coords["z"] - 1,GetEntityHeading(ped),0,0,false)
		else
			TaskStartScenarioInPlace(ped,animSequency["task"],0,false)
		end
	else
		tvRP.stopAnim(animUpper)

		if animUpper then
			playFlags = playFlags + 48
		end

		if animLoop then
			playFlags = playFlags + 1
		end

		Citizen.CreateThread(function()
			RequestAnimDict(animSequency[1])
			while not HasAnimDictLoaded(animSequency[1]) do
				Citizen.Wait(1)
			end

			if HasAnimDictLoaded(animSequency[1]) then
				animDict = animSequency[1]
				animName = animSequency[2]
				animFlags = playFlags

				if playFlags == 49 then
					animActived = true
				end

				TaskPlayAnim(ped,animSequency[1],animSequency[2],3.0,3.0,-1,playFlags,0,0,0,0)
			end
		end)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADANIM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if animActived then
			if not IsEntityPlayingAnim(ped,animDict,animName,3) then
				TaskPlayAnim(ped,animDict,animName,3.0,3.0,-1,animFlags,0,0,0,0)
				timeDistance = 1
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBLOCK
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		if animActived then
			timeDistance = 1
			DisableControlAction(1,18,true)
			DisableControlAction(1,24,true)
			DisableControlAction(1,25,true)
			DisableControlAction(1,257,true)
			DisableControlAction(1,263,true)
			DisableControlAction(1,140,true)
			DisableControlAction(1,142,true)
			DisableControlAction(1,143,true)
			DisablePlayerFiring(PlayerPedId(),true)
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPANIM
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.stopAnim(animUpper)
	animActived = false
	local ped = PlayerPedId()

	if animUpper then
		ClearPedSecondaryTask(ped)
	else
		ClearPedTasks(ped)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPACTIVED
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.stopActived()
	animActived = false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYSOUND
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.playSound(dict,name)
	PlaySoundFrontend(-1,dict,name,false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PASSPORTENALBLE
-----------------------------------------------------------------------------------------------------------------------------------------
function passportEnable()
	if showPassports or not MumbleIsConnected() then return end

	showPassports = true
	local playerList = vRPS.userPlayers()

	while showPassports do
		local ped = PlayerPedId()
		local userPlayers = GetPlayers()
		local coords = GetEntityCoords(ped)

		for k,v in pairs(userPlayers) do
			local uPlayer = GetPlayerFromServerId(k)
			if uPlayer ~= PlayerId() and NetworkIsPlayerConnected(uPlayer) then
				local uPed = GetPlayerPed(uPlayer)
				local uCoords = GetEntityCoords(uPed)
				local distance = #(coords - uCoords)
				if distance <= 5 then
					DrawText3D(uCoords["x"],uCoords["y"],uCoords["z"] + 1.10,playerList[k],0.45)
				end
			end
		end

		Citizen.Wait(0)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PASSPORTDISABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function passportDisable()
	showPassports = false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PASSPORTCOMMANDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("+showPassports",passportEnable)
RegisterCommand("-showPassports",passportDisable)
RegisterKeyMapping("+showPassports","Visualizar passaportes.","keyboard","F7")
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text,weight)
	local onScreen,_x,_y = GetScreenCoordFromWorldCoord(x,y,z)

	if onScreen then
		BeginTextCommandDisplayText("STRING")
		AddTextComponentSubstringKeyboardDisplay(text)
		SetTextColour(255,255,255,150)
		SetTextScale(0.35,0.35)
		SetTextFont(4)
		SetTextCentre(1)
		EndTextCommandDisplayText(_x,_y)

		local width = (string.len(text) + 4) / 160 * weight
		DrawRect(_x,_y + 0.0125,width,0.03,15,15,15,175)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONRESOURCESTOP
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onResourceStop",function(resource)
	TriggerServerEvent("vRP:Print","pausou o resource "..resource)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLACKLISTWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
local blackWeapons = {
	"weapon_raypistol","weapon_grenade","weapon_bzgas","weapon_molotov","weapon_stickybomb","weapon_proxmine","weapon_snowball",
	"weapon_pipebomb","weapon_ball","weapon_smokegrenade","weapon_rayminigun","weapon_hominglauncher","weapon_firework","weapon_minigun",
	"weapon_grenadelauncher_smoke","weapon_grenadelauncher","weapon_rpg"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		for k,v in pairs(blackWeapons) do
			if HasPedGotWeapon(ped,GetHashKey(v),false) then
				TriggerServerEvent("vRP:Print","está usando uma arma bloqueada")
			end
		end

		Citizen.Wait(1000)
	end
end)