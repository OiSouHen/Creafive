-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
vSERVER = Tunnel.getInterface("hud")
vRPS = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Experience = 0
local showHud = false
local clientStress = 0
local showMovie = false
local Compass = true
local pauseBreak = false
local clientHunger = 100
local clientThirst = 100
local homeInterior = false
local updateFoods = GetGameTimer()
local wantedTimer = GetGameTimer()
local reposeTimer = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- NITRO
-----------------------------------------------------------------------------------------------------------------------------------------
local nitroFuel = 0
local nitroActive = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATBELT
-----------------------------------------------------------------------------------------------------------------------------------------
local beltSpeed = 0
local beltLock = false
local beltVelocity = vector3(0,0,0)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIVINABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local divingMask = nil
local divingTank = nil
local clientOxigen = 100
local divingTimers = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- MUMBLABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Mumble = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- MUMBLECONNECTED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("mumbleConnected",function()
	if not Mumble then
		SendNUIMessage({ mumble = false })
		Mumble = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MUMBLEDISCONNECTED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("mumbleDisconnected",function()
	if Mumble then
		SendNUIMessage({ mumble = true })
		Mumble = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:WANTEDCLIENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:wantedClient")
AddEventHandler("hud:wantedClient",function(Seconds)
	wantedTimer = GetGameTimer() + (Seconds * 1000)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:REPOSECLIENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:reposeClient")
AddEventHandler("hud:reposeClient",function(Seconds)
	reposeTimer = GetGameTimer() + (Seconds * 1000)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:EXP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Exp")
AddEventHandler("hud:Exp",function(Amount)
	Experience = Amount
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCIRCLE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	DisplayRadar(false)

	RequestStreamedTextureDict("circlemap",false)
	while not HasStreamedTextureDictLoaded("circlemap") do
		Citizen.Wait(100)
	end

	AddReplaceTexture("platform:/textures/graphics","radarmasksm","circlemap","radarmasksm")

	SetMinimapClipType(1)
	SetMinimapComponentPosition("minimap","L","B",0.009,-0.0125,0.16,0.28)
	SetMinimapComponentPosition("minimap_mask","L","B",0.155,0.12,0.080,0.15)
	SetMinimapComponentPosition("minimap_blur","L","B",0.0095,0.015,0.229,0.311)

	SetBigmapActive(true,false)

	Citizen.Wait(5000)

	SetBigmapActive(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADGLOBAL
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	DisplayRadar(false)

	while true do
		if LocalPlayer["state"]["Active"] then
			if divingMask ~= nil then
				if GetGameTimer() >= divingTimers then
					SendNUIMessage({ oxigen = clientOxigen - 1, oxigenShow = divingMask })
					divingTimers = GetGameTimer() + 30000
					clientOxigen = clientOxigen - 1
					vRPS.clientOxigen()

					if clientOxigen <= 0 then
						local ped = PlayerPedId()
						local health = GetEntityHealth(ped)
					
						SetEntityHealth(ped,health - 50)
					end
				end
			end
		end

		Citizen.Wait(5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADFOODS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if LocalPlayer["state"]["Active"] then
			local ped = PlayerPedId()
			if GetGameTimer() >= updateFoods and GetEntityHealth(ped) > 101 then
				SendNUIMessage({ thirst = clientThirst - 1 })
				SendNUIMessage({ hunger = clientHunger - 1 })
				updateFoods = GetGameTimer() + 90000
				clientThirst = clientThirst - 1
				clientHunger = clientHunger - 1
				vRPS.clientFoods()
			end
		end

		Citizen.Wait(30000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if homeInterior then
			SetWeatherTypeNow("CLEAR")
			SetWeatherTypePersist("CLEAR")
			SetWeatherTypeNowPersist("CLEAR")
			NetworkOverrideClockTime(00,00,00)
		else
			SetWeatherTypeNow(GlobalState["Weather"])
			SetWeatherTypePersist(GlobalState["Weather"])
			SetWeatherTypeNowPersist(GlobalState["Weather"])
			NetworkOverrideClockTime(GlobalState["Hours"],GlobalState["Minutes"],00)
		end

		Citizen.Wait(1)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROGRESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Progress")
AddEventHandler("Progress",function(progressTimer)
	SendNUIMessage({ progress = true, progressTimer = progressTimer })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHUD
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		if LocalPlayer["state"]["Active"] then
			if IsPauseMenuActive() then
				SendNUIMessage({ hud = false })
				pauseBreak = true
			else
				if showHud then
					if pauseBreak then
						SendNUIMessage({ hud = true })
						pauseBreak = false
						displayHud()
					else
						displayHud()

						local ped = PlayerPedId()
						if IsPedInAnyVehicle(ped) then
							timeDistance = 500
						end
					end
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISPLAYHUD
-----------------------------------------------------------------------------------------------------------------------------------------
function displayHud()
	local pid = PlayerId()
	local ped = PlayerPedId()
	local armour = GetPedArmour(ped)
	local coords = GetEntityCoords(ped)
	local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords["x"],coords["y"],coords["z"]))

	if IsPedInAnyVehicle(ped) then
		if not IsMinimapRendering() then
			DisplayRadar(true)
		end

		local vehicle = GetVehiclePedIsUsing(ped)
		local fuel = GetVehicleFuelLevel(vehicle)
		local speed = GetEntitySpeed(vehicle) * 3.6
		local vehPlate = GetVehicleNumberPlateText(vehicle)

		local nitroShow = 0
		if nitroActive then
			nitroShow = nitroFuel
		else
			nitroShow = GlobalState["Nitro"][vehPlate] or 0
		end

		SendNUIMessage({ vehicle = true, timer = GetGameTimer(), wanted = wantedTimer, repose = reposeTimer, talking = MumbleIsPlayerTalking(pid), nitro = nitroShow, health = GetEntityHealth(ped), armour = armour, street = streetName, fuel = fuel, speed = speed, belt = beltLock, locked = GetVehicleDoorLockStatus(vehicle) })
	else
		if IsMinimapRendering() then
			DisplayRadar(false)
		end

		SendNUIMessage({ vehicle = false, timer = GetGameTimer(), wanted = wantedTimer, repose = reposeTimer, talking = MumbleIsPlayerTalking(pid), health = GetEntityHealth(ped), armour = armour, street = streetName })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hud",function(source,args,rawCommand)
	if exports["chat"]:statusChat() and MumbleIsConnected() then
		showHud = not showHud

		displayHud()
		SendNUIMessage({ hud = showHud })

		if IsMinimapRendering() and not showHud then
			DisplayRadar(false)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPASS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("compass",function(source,args,rawCommand)
	if exports["chat"]:statusChat() and MumbleIsConnected() then
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			Compass = not Compass
			SendNUIMessage({ compass = Compass, vehicle = 1 })

			if Compass then
				TriggerEvent("Notify","verde","Compasso ativado.",3000)
			else
				TriggerEvent("Notify","verde","Compasso desativado.",3000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOVIE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("movie",function(source,args,rawCommand)
	if exports["chat"]:statusChat() and MumbleIsConnected() then
		showMovie = not showMovie

		displayHud()
		SendNUIMessage({ movie = showMovie })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:TOGGLEHOOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:toggleHood")
AddEventHandler("hud:toggleHood",function()
	showHood = not showHood

	if showHood then
		SetPedComponentVariation(PlayerPedId(),1,69,0,1)
	else
		SetPedComponentVariation(PlayerPedId(),1,0,0,1)
	end

	SendNUIMessage({ hood = showHood })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:REMOVEHOOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:RemoveHood")
AddEventHandler("hud:RemoveHood",function()
	if showHood then
		showHood = false
		SendNUIMessage({ hood = showHood })
		SetPedComponentVariation(PlayerPedId(),1,0,0,1)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:HUNGER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Hunger")
AddEventHandler("hud:Hunger",function(number)
	SendNUIMessage({ hunger = number })
	clientHunger = number
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:THIRST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Thirst")
AddEventHandler("hud:Thirst",function(number)
	SendNUIMessage({ thirst = number })
	clientThirst = number
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:STRESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Stress")
AddEventHandler("hud:Stress",function(number)
	SendNUIMessage({ stress = number })
	clientStress = number
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:OXIGEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Oxigen")
AddEventHandler("hud:Oxigen",function(number)
	SendNUIMessage({ oxigen = number, oxigenShow = divingMask })
	clientOxigen = number
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECHARGEOXIGEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:rechargeOxigen")
AddEventHandler("hud:rechargeOxigen",function()
	TriggerEvent("Notify","verde","Reabastecimento concluído.",3000)
	SendNUIMessage({ oxigen = 100, oxigenShow = divingMask })
	vRPS.rechargeOxigen()
	clientOxigen = 100
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:ACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Active")
AddEventHandler("hud:Active",function(status)
	showHud = status

	displayHud()

	SendNUIMessage({ hud = showHud })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:RADIO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Radio")
AddEventHandler("hud:Radio",function(number)
	if number <= 0 then
		SendNUIMessage({ radio = "" })
	else
		SendNUIMessage({ radio = "<text>"..parseInt(number).." Mhz</text>" })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:VOIP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Voip")
AddEventHandler("hud:Voip",function(number)
	local Number = tonumber(number)
	local voiceTarget = { "Baixo","Médio","Alto","Muito Alto" }

	SendNUIMessage({ voice = voiceTarget[Number] })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FOWARDPED
-----------------------------------------------------------------------------------------------------------------------------------------
function fowardPed(ped)
	local heading = GetEntityHeading(ped) + 90.0
	if heading < 0.0 then
		heading = 360.0 + heading
	end

	heading = heading * 0.0174533

	return { x = math.cos(heading) * 2.0, y = math.sin(heading) * 2.0 }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBELT
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		if LocalPlayer["state"]["Active"] then
			local ped = PlayerPedId()
			if IsPedInAnyVehicle(ped) then
				if not IsPedOnAnyBike(ped) and not IsPedInAnyHeli(ped) and not IsPedInAnyPlane(ped) then
					timeDistance = 1

					local vehicle = GetVehiclePedIsUsing(ped)
					if GetVehicleDoorLockStatus(vehicle) == 2 or beltLock then
						DisableControlAction(1,75,true)
					end

					local speed = GetEntitySpeed(vehicle) * 3.6
					if speed ~= beltSpeed then
						if (beltSpeed - speed) >= 45 and not beltLock then
							local fowardVeh = fowardPed(ped)
							local coords = GetEntityCoords(ped)
							local health = GetEntityHealth(ped)
							SetEntityCoords(ped,coords["x"] + fowardVeh["x"],coords["y"] + fowardVeh["y"],coords["z"] + 1,1,0,0,0)
							SetEntityVelocity(ped,beltVelocity["x"],beltVelocity["y"],beltVelocity["z"])
							SetEntityHealth(ped,health - 50)

							Citizen.Wait(1)

							SetPedToRagdoll(ped,5000,5000,0,0,0,0)
						end

						beltVelocity = GetEntityVelocity(vehicle)
						beltSpeed = speed
					end
				end
			else
				if beltSpeed ~= 0 then
					beltSpeed = 0
				end

				if beltLock then
					SendNUIMessage({ seatbelt = false })
					beltLock = false
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATBELT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("seatbelt",function(source,args,rawCommand)
	if MumbleIsConnected() then
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			if not IsPedOnAnyBike(ped) then
				if beltLock then
					TriggerEvent("sounds:source","unbelt",0.5)
					SendNUIMessage({ seatbelt = false })
					beltLock = false
				else
					TriggerEvent("sounds:source","belt",0.5)
					SendNUIMessage({ seatbelt = true })
					beltLock = true
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("seatbelt","Colocar/Retirar o cinto.","keyboard","G")
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOMES:HOURS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("homes:Hours")
AddEventHandler("homes:Hours",function(status)
	homeInterior = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHEALTHREDUCE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local foodTimers = GetGameTimer()

	while true do
		if LocalPlayer["state"]["Active"] then
			if GetGameTimer() >= foodTimers then
				foodTimers = GetGameTimer() + 10000

				local ped = PlayerPedId()
				local health = GetEntityHealth(ped)
				if health > 101 then
					if clientHunger >= 10 and clientHunger <= 20 then
						SetEntityHealth(ped,health - 1)
						TriggerEvent("Notify","hunger","Sofrendo com a fome.",3000)
					elseif clientHunger <= 9 then
						SetEntityHealth(ped,health - 2)
						TriggerEvent("Notify","hunger","Sofrendo com a fome.",3000)
					end

					if clientThirst >= 10 and clientThirst <= 20 then
						SetEntityHealth(ped,health - 1)
						TriggerEvent("Notify","thirst","Sofrendo com a sede.",3000)
					elseif clientThirst <= 9 then
						SetEntityHealth(ped,health - 2)
						TriggerEvent("Notify","thirst","Sofrendo com a sede.",3000)
					end
				end
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSHAKESTRESS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		if LocalPlayer["state"]["Active"] then
			local ped = PlayerPedId()
			if GetEntityHealth(ped) > 101 then
				if clientStress >= 99 then
					timeDistance = 2500
					ShakeGameplayCam("LARGE_EXPLOSION_SHAKE",0.75)
				elseif clientStress >= 80 and clientStress <= 98 then
					timeDistance = 5000
					ShakeGameplayCam("LARGE_EXPLOSION_SHAKE",0.50)
				elseif clientStress >= 60 and clientStress <= 79 then
					timeDistance = 7500
					ShakeGameplayCam("LARGE_EXPLOSION_SHAKE",0.25)
				elseif clientStress >= 40 and clientStress <= 59 then
					timeDistance = 10000
					ShakeGameplayCam("LARGE_EXPLOSION_SHAKE",0.05)
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:REMOVESCUBA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:RemoveScuba")
AddEventHandler("hud:RemoveScuba",function()
	local ped = PlayerPedId()
	if DoesEntityExist(divingMask) or DoesEntityExist(divingTank) then
		if DoesEntityExist(divingMask) then
			SendNUIMessage({ oxigen = clientOxigen, oxigenShow = nil })
			TriggerServerEvent("tryDeleteObject",ObjToNet(divingMask))
			divingMask = nil
		end

		if DoesEntityExist(divingTank) then
			TriggerServerEvent("tryDeleteObject",ObjToNet(divingTank))
			divingTank = nil
		end

		SetEnableScuba(ped,false)
		SetPedMaxTimeUnderwater(ped,10.0)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:DIVING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Diving")
AddEventHandler("hud:Diving",function()
	local ped = PlayerPedId()

	if DoesEntityExist(divingMask) or DoesEntityExist(divingTank) then
		if DoesEntityExist(divingMask) then
			SendNUIMessage({ oxigen = clientOxigen, oxigenShow = nil })
			TriggerServerEvent("tryDeleteObject",ObjToNet(divingMask))
			divingMask = nil
		end

		if DoesEntityExist(divingTank) then
			TriggerServerEvent("tryDeleteObject",ObjToNet(divingTank))
			divingTank = nil
		end

		SetEnableScuba(ped,false)
		SetPedMaxTimeUnderwater(ped,10.0)
	else
		local coords = GetEntityCoords(ped)
		local myObject,objNet = vRPS.CreateObject("p_s_scuba_tank_s",coords["x"],coords["y"],coords["z"])
		if myObject then
			local spawnObjects = 0
			divingTank = NetworkGetEntityFromNetworkId(objNet)
			while not DoesEntityExist(divingTank) and spawnObjects <= 1000 do
				divingTank = NetworkGetEntityFromNetworkId(objNet)
				spawnObjects = spawnObjects + 1
				Citizen.Wait(1)
			end

			spawnObjects = 0
			local objectControl = NetworkRequestControlOfEntity(divingTank)
			while not objectControl and spawnObjects <= 1000 do
				objectControl = NetworkRequestControlOfEntity(divingTank)
				spawnObjects = spawnObjects + 1
				Citizen.Wait(1)
			end

			AttachEntityToEntity(divingTank,ped,GetPedBoneIndex(ped,24818),-0.28,-0.24,0.0,180.0,90.0,0.0,1,1,0,0,2,1)
	
			SetEntityAsNoLongerNeeded(divingTank)
		end

		local myObject,objNet = vRPS.CreateObject("p_s_scuba_mask_s",coords["x"],coords["y"],coords["z"])
		if myObject then
			local spawnObjects = 0
			divingMask = NetworkGetEntityFromNetworkId(objNet)
			while not DoesEntityExist(divingMask) and spawnObjects <= 1000 do
				divingMask = NetworkGetEntityFromNetworkId(objNet)
				spawnObjects = spawnObjects + 1
				Citizen.Wait(1)
			end

			spawnObjects = 0
			local objectControl = NetworkRequestControlOfEntity(divingMask)
			while not objectControl and spawnObjects <= 1000 do
				objectControl = NetworkRequestControlOfEntity(divingMask)
				spawnObjects = spawnObjects + 1
				Citizen.Wait(1)
			end

			AttachEntityToEntity(divingMask,ped,GetPedBoneIndex(ped,12844),0.0,0.0,0.0,180.0,90.0,0.0,1,1,0,0,2,1)
	
			SetEntityAsNoLongerNeeded(divingMask)
		end

		SetEnableScuba(ped,true)
		SetPedMaxTimeUnderwater(ped,2000.0)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NITROENABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function nitroEnable()
	if nitroActive then return end

	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		local vehicle = GetVehiclePedIsUsing(ped)
		if GetPedInVehicleSeat(vehicle,-1) == ped then
			local vehPlate = GetVehicleNumberPlateText(vehicle)
			nitroFuel = GlobalState["Nitro"][vehPlate] or 0

			if nitroFuel >= 1 then
				TriggerEvent("sounds:source","nitro",1.0)
				nitroActive = true

				while nitroActive do
					if nitroFuel >= 1 then
						nitroFuel = nitroFuel - 1

						if not GetScreenEffectIsActive("RaceTurbo") then
							StartScreenEffect("RaceTurbo",0,true)
						end

						SetVehicleCheatPowerIncrease(vehicle,5.0)
						ModifyVehicleTopSpeed(vehicle,20.0)
						fireExaust(vehicle)
					else
						SetVehicleCheatPowerIncrease(vehicle,0.0)
						vSERVER.updateNitro(vehPlate,nitroFuel)
						ModifyVehicleTopSpeed(vehicle,0.0)

						if GetScreenEffectIsActive("RaceTurbo") then
							StopScreenEffect("RaceTurbo")
						end

						nitroActive = false
					end

					Citizen.Wait(100)
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NITRODISABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function nitroDisable()
	if nitroActive then
		nitroActive = false

		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsUsing(ped)
			local vehPlate = GetVehicleNumberPlateText(vehicle)

			SetVehicleCheatPowerIncrease(vehicle,0.0)
			vSERVER.updateNitro(vehPlate,nitroFuel)
			ModifyVehicleTopSpeed(vehicle,0.0)

			if GetScreenEffectIsActive("RaceTurbo") then
				StopScreenEffect("RaceTurbo")
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXAUSTS
-----------------------------------------------------------------------------------------------------------------------------------------
local exausts = {
	"exhaust","exhaust_2","exhaust_3","exhaust_4","exhaust_5","exhaust_6","exhaust_7","exhaust_8",
	"exhaust_9","exhaust_10","exhaust_11","exhaust_12","exhaust_13","exhaust_14","exhaust_15","exhaust_16"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIREEXAUST
-----------------------------------------------------------------------------------------------------------------------------------------
function fireExaust(vehicle)
	for k,v in ipairs(exausts) do
		local exaustNumber = GetEntityBoneIndexByName(vehicle,v)

		if exaustNumber > -1 then
			UseParticleFxAssetNextCall("core")
			StartNetworkedParticleFxNonLoopedOnEntityBone("veh_backfire",vehicle,0.0,0.0,0.0,0.0,0.0,0.0,exaustNumber,1.75,false,false,false)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVENITRO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("+activeNitro",nitroEnable)
RegisterCommand("-activeNitro",nitroDisable)
RegisterKeyMapping("+activeNitro","Ativação do nitro.","keyboard","LMENU")