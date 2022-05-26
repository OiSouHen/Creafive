-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local vehMenu = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHCONTROL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("enterVehmenus",function(source,args,rawCommand)
	if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not vehMenu and MumbleIsConnected() then
		local ped = PlayerPedId()
		if not IsEntityInWater(ped) and GetEntityHealth(ped) > 101 then
			local vehicle = vRP.vehList(7)
			if vehicle then
				SendNUIMessage({ show = true })
				SetCursorLocation(0.5,0.8)
				SetNuiFocus(true,true)
				vehMenu = true
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHCONTROL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("enterVehmenus","Interação veícular.","keyboard","F1")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSESYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("closeSystem",function()
	SendNUIMessage({ show = false })
	SetCursorLocation(0.5,0.5)
	SetNuiFocus(false,false)
	vehMenu = false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MENUACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("menuActive",function(data)
	local ped = PlayerPedId()
	if GetVehiclePedIsTryingToEnter(ped) <= 0 then
		if data["active"] == "chest" then
			TriggerServerEvent("trunkchest:openTrunk")

			SendNUIMessage({ show = false })
			SetCursorLocation(0.5,0.5)
			SetNuiFocus(false,false)
			vehMenu = false
		elseif data["active"] == "door1" then
			TriggerServerEvent("player:Doors","1")
		elseif data["active"] == "door2" then
			TriggerServerEvent("player:Doors","2")
		elseif data["active"] == "door3" then
			TriggerServerEvent("player:Doors","3")
		elseif data["active"] == "door4" then
			TriggerServerEvent("player:Doors","4")
		elseif data["active"] == "trunk" then
			TriggerServerEvent("player:Doors","5")
		elseif data["active"] == "hood" then
			TriggerServerEvent("player:Doors","6")
		elseif data["active"] == "vtuning" then
			TriggerEvent("engine:vehTuning")

			SendNUIMessage({ show = false })
			SetCursorLocation(0.5,0.5)
			SetNuiFocus(false,false)
			vehMenu = false
		end
	end
end)