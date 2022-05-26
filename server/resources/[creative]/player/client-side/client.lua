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
Tunnel.bindInterface("player",cRP)
vSERVER = Tunnel.getInterface("player")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
LocalPlayer["state"]["Handcuff"] = false
LocalPlayer["state"]["Commands"] = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:COMMANDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:Commands")
AddEventHandler("player:Commands",function(status)
	LocalPlayer["state"]["Commands"] = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:PLAYERCARRY
-----------------------------------------------------------------------------------------------------------------------------------------
local playerCarry = false
RegisterNetEvent("player:playerCarry")
AddEventHandler("player:playerCarry",function(entity,mode)
	if playerCarry then
		DetachEntity(PlayerPedId(),false,false)
		playerCarry = false
	else
		if mode == "handcuff" then
			AttachEntityToEntity(PlayerPedId(),GetPlayerPed(GetPlayerFromServerId(entity)),11816,0.0,0.5,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
		else
			AttachEntityToEntity(PlayerPedId(),GetPlayerPed(GetPlayerFromServerId(entity)),11816,0.6,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
		end

		playerCarry = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:ROPECARRY
-----------------------------------------------------------------------------------------------------------------------------------------
local ropeCarry = false
RegisterNetEvent("player:ropeCarry")
AddEventHandler("player:ropeCarry",function(entity)
	ropeCarry = not ropeCarry

	if not ropeCarry then
		DetachEntity(PlayerPedId(),false,false)
		ropeCarry = false
	else
		AttachEntityToEntity(PlayerPedId(),GetPlayerPed(GetPlayerFromServerId(entity)),0,0.20,0.12,0.63,0.5,0.5,0.0,false,false,false,false,2,false)
		ropeCarry = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADROPEANIM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		if ropeCarry then
			timeDistance = 1
			local ped = PlayerPedId()
			if not IsEntityPlayingAnim(ped,"nm","firemans_carry",3) then
				vRP.playAnim(false,{"nm","firemans_carry"},true)
			end

			DisableControlAction(1,23,true)
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECEIVESALARY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local salaryCounts = 0
	local salaryTimers = GetGameTimer()

	while true do
		local ped = PlayerPedId()
		if GetGameTimer() >= salaryTimers and GetEntityHealth(ped) > 101 then
			salaryTimers = GetGameTimer() + 60000
			salaryCounts = salaryCounts + 1

			if salaryCounts >= 30 then
				vSERVER.receiveSalary()
				salaryCounts = 0
			end
		end

		Citizen.Wait(10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATSHUFFLE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) and not IsPedOnAnyBike(ped) then
			timeDistance = 100
			local vehicle = GetVehiclePedIsUsing(ped)
			if GetPedInVehicleSeat(vehicle,0) == ped then
				if not GetIsTaskActive(ped,164) and GetIsTaskActive(ped,165) then
					SetPedIntoVehicle(ped,vehicle,0)
					SetPedConfigFlag(ped,184,true)
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AWAYSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local awayTimers = GetGameTimer()
	local awaySystem = {
		["coords"] = vector3(0.0,0.0,0.0),
		["time"] = 20
	}

	while true do
		if GetGameTimer() >= awayTimers then
			awayTimers = GetGameTimer() + 60000

			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)
			local distance = #(coords - awaySystem["coords"])

			if distance <= 1 then
				if awaySystem["time"] > 0 then
					awaySystem["time"] = awaySystem["time"] - 1

					if awaySystem["time"] == 3 then
						TriggerEvent("Notify","amarelo","Mova-se e evite ser desconectado.",3000)
					end
				else
					if GetEntityHealth(ped) > 101 then
						TriggerServerEvent("player:kickSystem","Desconectado, muito tempo ausente.")
						awaySystem["coords"] = coords
						awaySystem["time"] = 20
					end
				end
			else
				awaySystem["coords"] = coords
				awaySystem["time"] = 20
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETENERGETIC
-----------------------------------------------------------------------------------------------------------------------------------------
local energetic = 0
RegisterNetEvent("setEnergetic")
AddEventHandler("setEnergetic",function(timers,number)
	energetic = energetic + timers
	SetRunSprintMultiplierForPlayer(PlayerId(),number)
end)

Citizen.CreateThread(function()
	while true do
		if energetic > 0 then
			energetic = energetic - 1
			RestorePlayerStamina(PlayerId(),1.0)

			if energetic <= 0 or GetEntityHealth(PlayerPedId()) <= 101 then
				SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
				energetic = 0
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETECSTASY
-----------------------------------------------------------------------------------------------------------------------------------------
local ecstasy = 0
RegisterNetEvent("setEcstasy")
AddEventHandler("setEcstasy",function()
	ecstasy = ecstasy + 10

	if not GetScreenEffectIsActive("MinigameTransitionIn") then
		StartScreenEffect("MinigameTransitionIn",0,true)
	end
end)

Citizen.CreateThread(function()
	while true do
		if ecstasy > 0 then
			ecstasy = ecstasy - 1
			ShakeGameplayCam("LARGE_EXPLOSION_SHAKE",0.05)

			if ecstasy <= 0 or GetEntityHealth(PlayerPedId()) <= 101 then
				ecstasy = 0

				TriggerServerEvent("upgradeStress",100)
				if GetScreenEffectIsActive("MinigameTransitionIn") then
					StopScreenEffect("MinigameTransitionIn")
				end
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETMETH
-----------------------------------------------------------------------------------------------------------------------------------------
local methanfetamine = 0
RegisterNetEvent("setMeth")
AddEventHandler("setMeth",function()
	methanfetamine = methanfetamine + 30

	if not GetScreenEffectIsActive("DMT_flight") then
		StartScreenEffect("DMT_flight",0,true)
	end
end)

Citizen.CreateThread(function()
	while true do
		if methanfetamine > 0 then
			methanfetamine = methanfetamine - 1

			if methanfetamine <= 0 or GetEntityHealth(PlayerPedId()) <= 101 then
				methanfetamine = 0

				if GetScreenEffectIsActive("DMT_flight") then
					StopScreenEffect("DMT_flight")
				end
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETCOCAINE
-----------------------------------------------------------------------------------------------------------------------------------------
local cocaine = 0
RegisterNetEvent("setCocaine")
AddEventHandler("setCocaine",function()
	cocaine = cocaine + 30

	if not GetScreenEffectIsActive("MinigameTransitionIn") then
		StartScreenEffect("MinigameTransitionIn",0,true)
	end
end)

Citizen.CreateThread(function()
	while true do
		if cocaine > 0 then
			cocaine = cocaine - 1

			if cocaine <= 0 or GetEntityHealth(PlayerPedId()) <= 101 then
				cocaine = 0

				if GetScreenEffectIsActive("MinigameTransitionIn") then
					StopScreenEffect("MinigameTransitionIn")
				end
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANEFFECTDRUGS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("cleanEffectDrugs")
AddEventHandler("cleanEffectDrugs",function()
	if GetScreenEffectIsActive("MinigameTransitionIn") then
		StopScreenEffect("MinigameTransitionIn")
	end

	if GetScreenEffectIsActive("DMT_flight") then
		StopScreenEffect("DMT_flight")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETDRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
local drunkTime = 0
RegisterNetEvent("setDrunkTime")
AddEventHandler("setDrunkTime",function(timers)
	drunkTime = drunkTime + timers

	LocalPlayer["state"]["Drunk"] = true
	RequestAnimSet("move_m@drunk@verydrunk")
	while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
		Citizen.Wait(1)
	end

	SetPedMovementClipset(PlayerPedId(),"move_m@drunk@verydrunk",0.25)
end)

Citizen.CreateThread(function()
	while true do
		if drunkTime > 0 then
			drunkTime = drunkTime - 1

			if drunkTime <= 0 or GetEntityHealth(PlayerPedId()) <= 101 then
				ResetPedMovementClipset(PlayerPedId(),0.25)
				LocalPlayer["state"]["Drunk"] = false
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCHOODOPTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:syncHoodOptions")
AddEventHandler("player:syncHoodOptions",function(vehNet,Active)
	if NetworkDoesNetworkIdExist(vehNet) then
		local Vehicle = NetToEnt(vehNet)
		if DoesEntityExist(Vehicle) then
			if Active == "open" then
				SetVehicleDoorOpen(Vehicle,4,0,0)
			elseif Active == "close" then
				SetVehicleDoorShut(Vehicle,4,0)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCDOORSOPTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:syncDoorsOptions")
AddEventHandler("player:syncDoorsOptions",function(vehNet,Active)
	if NetworkDoesNetworkIdExist(vehNet) then
		local Vehicle = NetToEnt(vehNet)
		if DoesEntityExist(Vehicle) then
			if Active == "open" then
				SetVehicleDoorOpen(Vehicle,5,0,0)
			elseif Active == "close" then
				SetVehicleDoorShut(Vehicle,5,0)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCWINS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:syncWins")
AddEventHandler("player:syncWins",function(vehNet,Active)
	if NetworkDoesNetworkIdExist(vehNet) then
		local Vehicle = NetToEnt(vehNet)
		if DoesEntityExist(Vehicle) then
			if Active == "1" then
				RollUpWindow(Vehicle,0)
				RollUpWindow(Vehicle,1)
				RollUpWindow(Vehicle,2)
				RollUpWindow(Vehicle,3)
			else
				RollDownWindow(Vehicle,0)
				RollDownWindow(Vehicle,1)
				RollDownWindow(Vehicle,2)
				RollDownWindow(Vehicle,3)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCDOORS
-----------------------------------------------------------------------------------------------------------------------------------------
local doorStatus = { ["1"] = 0, ["2"] = 1, ["3"] = 2, ["4"] = 3, ["5"] = 5, ["6"] = 4 }
RegisterNetEvent("player:syncDoors")
AddEventHandler("player:syncDoors",function(vehNet,Active)
	if NetworkDoesNetworkIdExist(vehNet) then
		local v = NetToEnt(vehNet)
		if DoesEntityExist(v) and GetVehicleDoorLockStatus(v) == 1 then
			if doorStatus[Active] then
				if GetVehicleDoorAngleRatio(v,doorStatus[Active]) == 0 then
					SetVehicleDoorOpen(v,doorStatus[Active],0,0)
				else
					SetVehicleDoorShut(v,doorStatus[Active],0)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:seatPlayer")
AddEventHandler("player:seatPlayer",function(vehIndex)
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		local vehicle = GetVehiclePedIsUsing(ped)

		if vehIndex == "0" then
			if IsVehicleSeatFree(vehicle,-1) then
				SetPedIntoVehicle(ped,vehicle,-1)
			end
		else
			if IsVehicleSeatFree(vehicle,parseInt(vehIndex - 1)) then
				SetPedIntoVehicle(ped,vehicle,parseInt(vehIndex - 1))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLEHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.toggleHandcuff()
	if not LocalPlayer["state"]["Handcuff"] then
		TriggerEvent("radio:outServers")
		LocalPlayer["state"]["Handcuff"] = true
		exports["smartphone"]:closeSmartphone()
	else
		LocalPlayer["state"]["Handcuff"] = false
		vRP.stopAnim(false)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getHandcuff()
	return LocalPlayer["state"]["Handcuff"]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("resetHandcuff")
AddEventHandler("resetHandcuff",function()
	if LocalPlayer["state"]["Handcuff"] then
		LocalPlayer["state"]["Handcuff"] = false
		vRP.stopAnim(false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		if LocalPlayer["state"]["Handcuff"] then
			timeDistance = 1
			DisableControlAction(1,18,true)
			DisableControlAction(1,21,true)
			DisableControlAction(1,55,true)
			DisableControlAction(1,102,true)
			DisableControlAction(1,179,true)
			DisableControlAction(1,203,true)
			DisableControlAction(1,76,true)
			DisableControlAction(1,23,true)
			DisableControlAction(1,24,true)
			DisableControlAction(1,25,true)
			DisableControlAction(1,140,true)
			DisableControlAction(1,142,true)
			DisableControlAction(1,143,true)
			DisableControlAction(1,75,true)
			DisableControlAction(1,22,true)
			DisableControlAction(1,243,true)
			DisableControlAction(1,257,true)
			DisableControlAction(1,263,true)
			DisablePlayerFiring(PlayerPedId(),true)
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if LocalPlayer["state"]["Handcuff"] and GetEntityHealth(ped) > 101 and not ropeCarry and not playerCarry then
			if not IsEntityPlayingAnim(ped,"mp_arresting","idle",3) then
				RequestAnimDict("mp_arresting")
				while not HasAnimDictLoaded("mp_arresting") do
					Citizen.Wait(1)
				end

				TaskPlayAnim(ped,"mp_arresting","idle",3.0,3.0,-1,49,0,0,0,0)
				timeDistance = 1
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOTDISTANCE
-----------------------------------------------------------------------------------------------------------------------------------------
local losSantos = PolyZone:Create({
	vector2(-2153.08,-3131.33),
	vector2(-1581.58,-2092.38),
	vector2(-3271.05,275.85),
	vector2(-3460.83,967.42),
	vector2(-3202.39,1555.39),
	vector2(-1642.50,993.32),
	vector2(312.95,1054.66),
	vector2(1313.70,341.94),
	vector2(1739.01,-1280.58),
	vector2(1427.42,-3440.38),
	vector2(-737.90,-3773.97)
},{ name = "santos" })

local sandyShores = PolyZone:Create({
	vector2(-375.38,2910.14),
	vector2(307.66,3664.47),
	vector2(2329.64,4128.52),
	vector2(2349.93,4578.50),
	vector2(1680.57,4462.48),
	vector2(1570.01,4961.27),
	vector2(1967.55,5203.67),
	vector2(2387.14,5273.98),
	vector2(2735.26,4392.21),
	vector2(2512.33,3711.16),
	vector2(1681.79,3387.82),
	vector2(258.85,2920.16)
},{ name = "sandy" })

local paletoBay = PolyZone:Create({
	vector2(-529.40,5755.14),
	vector2(-234.39,5978.46),
	vector2(278.16,6381.84),
	vector2(672.67,6434.39),
	vector2(699.56,6877.77),
	vector2(256.59,7058.49),
	vector2(17.64,7054.53),
	vector2(-489.45,6449.50),
	vector2(-717.59,6030.94)
},{ name = "paleto" })
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSHOTSFIRED
-----------------------------------------------------------------------------------------------------------------------------------------
local residual = false
local sprayTimers = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSHOT
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if IsPedArmed(ped,6) and GetGameTimer() >= sprayTimers then
			timeDistance = 1

			if IsPedShooting(ped) then
				sprayTimers = GetGameTimer() + 60000
				residual = true

				if not IsPedCurrentWeaponSilenced(ped) then
					local coords = GetEntityCoords(ped)
					if (losSantos:isPointInside(coords) or sandyShores:isPointInside(coords) or paletoBay:isPointInside(coords)) and not LocalPlayer["state"]["Police"] then
						TriggerServerEvent("evidence:dropEvidence","blue")
						vSERVER.shotsFired()
					end
				else
					if math.random(100) >= 80 then
						local coords = GetEntityCoords(ped)
						if (losSantos:isPointInside(coords) or sandyShores:isPointInside(coords) or paletoBay:isPointInside(coords)) and not LocalPlayer["state"]["Police"] then
							TriggerServerEvent("evidence:dropEvidence","blue")
							vSERVER.shotsFired()
						end
					end
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYGSR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:applyGsr")
AddEventHandler("player:applyGsr",function()
	residual = true
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GSRCHECK
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.gsrCheck()
	return residual
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKSOAP
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkSoap()
	local ped = PlayerPedId()
	if IsEntityInWater(ped) and residual then
		return true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANRESIDUAL
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.cleanResidual()
	residual = false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:inBennys")
AddEventHandler("player:inBennys",function(status)
	inBennys = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.removeVehicle()
	if not inBennys then
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			TaskLeaveVehicle(ped,GetVehiclePedIsUsing(ped),16)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PUTVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.putVehicle(vehNet)
	if NetworkDoesNetworkIdExist(vehNet) then
		local Vehicle = NetToEnt(vehNet)
		if DoesEntityExist(Vehicle) then
			local vehSeats = 10
			local ped = PlayerPedId()

			repeat
				vehSeats = vehSeats - 1

				if IsVehicleSeatFree(Vehicle,vehSeats) then
					ClearPedTasks(ped)
					ClearPedSecondaryTask(ped)
					SetPedIntoVehicle(ped,Vehicle,vehSeats)

					vehSeats = true
				end
			until vehSeats == true or vehSeats == 0
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRUISER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cr",function(source,args,rawCommand)
	if exports["chat"]:statusChat() and MumbleIsConnected() then
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local Vehicle = GetVehiclePedIsUsing(ped)
			if GetPedInVehicleSeat(Vehicle,-1) == ped and not IsEntityInAir(Vehicle) then
				local speed = GetEntitySpeed(Vehicle) * 2.236936

				if speed >= 10 then
					if args[1] == nil then
						SetEntityMaxSpeed(Vehicle,GetVehicleEstimatedMaxSpeed(Vehicle))
						TriggerEvent("Notify","amarelo","Controle de cruzeiro desativado.",3000)
					else
						if parseInt(args[1]) > 10 then
							SetEntityMaxSpeed(Vehicle,0.45 * args[1])
							TriggerEvent("Notify","verde","Controle de cruzeiro ativado.",3000)
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GAMEEVENTTRIGGERED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("gameEventTriggered",function(name,args)
	if name == "CEventNetworkEntityDamage" then
		if (GetEntityHealth(args[1]) <= 101 and PlayerPedId() == args[2] and IsPedAPlayer(args[1])) then
			local index = NetworkGetPlayerIndexFromPed(args[1])
			local source = GetPlayerServerId(index)
			TriggerServerEvent("player:deathLogs",source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNKABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local inTrunk = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:ENTERTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:enterTrunk")
AddEventHandler("player:enterTrunk",function(entity)
	if not inTrunk then
		local Vehicle = entity[3]
		if GetVehicleDoorLockStatus(Vehicle) == 1 then
			local Selected = GetEntityBoneIndexByName(Vehicle,"boot")
			if Selected ~= -1 then
				local ped = PlayerPedId()
				local coords = GetEntityCoords(ped)
				local coordsEnt = GetWorldPositionOfEntityBone(Vehicle,Selected)
				local distance = #(coords - coordsEnt)
				if distance <= 2.0 then
					LocalPlayer["state"]["Invisible"] = true
					LocalPlayer["state"]["Commands"] = true
					SetEntityVisible(ped,false,false)
					AttachEntityToEntity(ped,Vehicle,-1,0.0,-2.2,0.5,0.0,0.0,0.0,false,false,false,false,20,true)
					inTrunk = true
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:checkTrunk")
AddEventHandler("player:checkTrunk",function()
	if inTrunk then
		local ped = PlayerPedId()
		local Vehicle = GetEntityAttachedTo(ped)
		if DoesEntityExist(Vehicle) then
			inTrunk = false
			DetachEntity(ped,false,false)
			SetEntityVisible(ped,true,false)
			LocalPlayer["state"]["Commands"] = false
			LocalPlayer["state"]["Invisible"] = false
			SetEntityCoords(ped,GetOffsetFromEntityInWorldCoords(ped,0.0,-1.25,-0.25),1,0,0,0)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADINTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999

		if inTrunk then
			local ped = PlayerPedId()
			local Vehicle = GetEntityAttachedTo(ped)
			if DoesEntityExist(Vehicle) then
				timeDistance = 1

				DisablePlayerFiring(ped,true)

				if IsEntityVisible(ped) then
					LocalPlayer["state"]["Invisible"] = true
					SetEntityVisible(ped,false,false)
				end

				if IsControlJustPressed(1,38) then
					inTrunk = false
					DetachEntity(ped,false,false)
					SetEntityVisible(ped,true,false)
					LocalPlayer["state"]["Commands"] = false
					LocalPlayer["state"]["Invisible"] = false
					SetEntityCoords(ped,GetOffsetFromEntityInWorldCoords(ped,0.0,-1.25,-0.25),1,0,0,0)
				end
			else
				inTrunk = false
				DetachEntity(ped,false,false)
				SetEntityVisible(ped,true,false)
				LocalPlayer["state"]["Commands"] = false
				LocalPlayer["state"]["Invisible"] = false
				SetEntityCoords(ped,GetOffsetFromEntityInWorldCoords(ped,0.0,-1.25,-0.25),1,0,0,0)
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAFEBURGER
-----------------------------------------------------------------------------------------------------------------------------------------
local safeBurger = PolyZone:Create({
	vector2(-1188.68,-878.83),
	vector2(-1198.82,-885.54),
	vector2(-1197.20,-888.00),
	vector2(-1202.07,-891.40),
	vector2(-1201.24,-892.50),
	vector2(-1200.82,-893.32),
	vector2(-1203.37,-895.03),
	vector2(-1199.14,-901.76),
	vector2(-1199.65,-902.25),
	vector2(-1198.75,-903.63),
	vector2(-1195.35,-901.35),
	vector2(-1194.95,-901.98),
	vector2(-1195.20,-902.93),
	vector2(-1196.38,-903.84),
	vector2(-1194.87,-906.07),
	vector2(-1193.38,-906.36),
	vector2(-1193.20,-905.87),
	vector2(-1190.91,-906.13),
	vector2(-1189.97,-905.46),
	vector2(-1193.19,-900.83),
	vector2(-1193.91,-901.34),
	vector2(-1195.49,-898.63),
	vector2(-1191.54,-896.07),
	vector2(-1190.37,-897.74),
	vector2(-1180.39,-890.96)
},{ name = "BurgerShot" })
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAFEFISH
-----------------------------------------------------------------------------------------------------------------------------------------
local safeFish = PolyZone:Create({
	vector2(1522.36,3772.69),
	vector2(1529.41,3778.89),
	vector2(1537.68,3783.54),
	vector2(1535.88,3787.09),
	vector2(1552.66,3795.83),
	vector2(1549.07,3802.40),
	vector2(1529.33,3793.77),
	vector2(1527.99,3796.13),
	vector2(1521.92,3793.16),
	vector2(1516.26,3788.72),
	vector2(1513.64,3786.12),
	vector2(1515.38,3784.12),
	vector2(1510.12,3778.29),
	vector2(1508.61,3774.59),
	vector2(1509.24,3771.86),
	vector2(1512.11,3771.08),
	vector2(1516.23,3772.85),
	vector2(1519.52,3775.65)
},{ name = "FishPlanet" })
-----------------------------------------------------------------------------------------------------------------------------------------
-- SQUARE
-----------------------------------------------------------------------------------------------------------------------------------------
local safeSquare = PolyZone:Create({
	  vector2(152.63,-1001.17),
	  vector2(129.78,-993.32),
	  vector2(127.38,-991.56),
	  vector2(126.56,-990.27),
	  vector2(126.05,-988.42),
	  vector2(126.35,-985.75),
	  vector2(160.35,-892.59),
	  vector2(162.87,-887.34),
	  vector2(164.63,-884.61),
	  vector2(166.54,-882.10),
	  vector2(168.37,-879.66),
	  vector2(170.03,-877.06),
	  vector2(171.45,-874.34),
	  vector2(172.82,-871.61),
	  vector2(174.15,-868.74),
	  vector2(175.21,-866.23),
	  vector2(176.44,-863.35),
	  vector2(177.66,-860.56),
	  vector2(178.70,-857.81),
	  vector2(183.97,-843.75),
	  vector2(185.89,-841.26),
	  vector2(188.63,-840.02),
	  vector2(191.54,-840.19),
	  vector2(193.14,-841.48),
	  vector2(194.11,-843.38),
	  vector2(195.16,-845.01),
	  vector2(196.72,-845.92),
	  vector2(246.74,-864.14),
	  vector2(248.81,-864.08),
	  vector2(251.73,-862.72),
	  vector2(253.52,-862.86),
	  vector2(260.32,-865.34),
	  vector2(262.11,-866.44),
	  vector2(264.38,-868.85),
	  vector2(265.62,-871.46),
	  vector2(266.05,-874.31),
	  vector2(265.69,-877.25),
	  vector2(264.72,-879.99),
	  vector2(213.15,-1021.55),
	  vector2(211.52,-1023.84),
	  vector2(208.98,-1024.99),
	  vector2(205.42,-1024.66),
	  vector2(202.17,-1023.48),
	  vector2(196.34,-1021.55),
	  vector2(194.97,-1019.53),
	  vector2(193.14,-1015.18),
	  vector2(192.23,-1014.49),
	  vector2(169.87,-1006.99),
	  vector2(167.61,-1007.46),
	  vector2(163.31,-1009.85),
	  vector2(161.97,-1009.95),
	  vector2(156.65,-1008.10),
	  vector2(155.68,-1007.06),
	  vector2(154.50,-1004.24),
	  vector2(153.67,-1002.24)
},{ name = "squareGarden" })
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSAFE
-----------------------------------------------------------------------------------------------------------------------------------------
local safeTimer = 0
local safeZone = false
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)

		if safeSquare:isPointInside(coords) or safeBurger:isPointInside(coords) or safeFish:isPointInside(coords) then
			safeTimer = safeTimer + 1

			if not safeZone then
				SetPlayerInvincible(ped,true)
				safeZone = true
			end

			if safeTimer >= 60 then
				TriggerServerEvent("downgradeStress",10)
				safeTimer = 0
			end
		else
			if safeTimer > 0 then
				safeTimer = 0
			end

			if safeZone then
				SetPlayerInvincible(ped,false)
				safeZone = false
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FPS
-----------------------------------------------------------------------------------------------------------------------------------------
local commandFps = false
RegisterCommand("fps",function(source,args,rawCommand)
	if commandFps then
		ClearTimecycleModifier()
		commandFps = false
	else
		SetTimecycleModifier("cinema")
		commandFps = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BIKESBACKPACK
-----------------------------------------------------------------------------------------------------------------------------------------
local bikesPoints = 0
local bikesTea = false
local bikesTeaPoints = 0
local bikeMaxPoints = 900
local bikesTimer = GetGameTimer()
local bikesTeaTimer = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- BIKESMODEL
-----------------------------------------------------------------------------------------------------------------------------------------
local bikesModel = {
	[1131912276] = true,
	[448402357] = true,
	[-836512833] = true,
	[-186537451] = true,
	[1127861609] = true,
	[-1233807380] = true,
	[-400295096] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:MUSHROOMTEA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:MushroomTea")
AddEventHandler("player:MushroomTea",function()
	bikesTea = true
	bikesTeaPoints = 0
	bikeMaxPoints = 600
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBIKES
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()

		if IsPedInAnyVehicle(ped) then
			local Vehicle = GetVehiclePedIsUsing(ped)
			local vehModel = GetEntityModel(Vehicle)
			local speed = GetEntitySpeed(Vehicle) * 2.236936

			if bikesModel[vehModel] and GetGameTimer() >= bikesTimer and speed >= 10 then
				bikesTimer = GetGameTimer() + 1000
				bikesPoints = bikesPoints + 1

				if bikesPoints >= bikeMaxPoints then
					vSERVER.bikesBackpack()
					bikesPoints = 0
				end
			end
		end

		if commandFps then
			if IsPedSwimming(ped) then
				ClearTimecycleModifier()
				commandFps = false
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBIKETEA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if bikesTea then
			if GetGameTimer() >= bikesTeaTimer then
				bikesTeaTimer = GetGameTimer() + 1000
				bikesTeaPoints = bikesTeaPoints + 1

				if bikesTeaPoints >= 3600 then
					bikeMaxPoints = 900
					bikesTeaPoints = 0
					bikesTea = false
				end
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:RELATIONSHIP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:Relationship")
AddEventHandler("player:Relationship",function(Group)
	if Group == "Ballas" then
		SetRelationshipBetweenGroups(1,GetHashKey("AMBIENT_GANG_BALLAS"),GetHashKey("PLAYER"))
		SetRelationshipBetweenGroups(1,GetHashKey("PLAYER"),GetHashKey("AMBIENT_GANG_BALLAS"))
	elseif Group == "Families" then
		SetRelationshipBetweenGroups(1,GetHashKey("AMBIENT_GANG_FAMILY"),GetHashKey("PLAYER"))
		SetRelationshipBetweenGroups(1,GetHashKey("PLAYER"),GetHashKey("AMBIENT_GANG_FAMILY"))
	elseif Group == "Vagos" then
		SetRelationshipBetweenGroups(1,GetHashKey("AMBIENT_GANG_MEXICAN"),GetHashKey("PLAYER"))
		SetRelationshipBetweenGroups(1,GetHashKey("PLAYER"),GetHashKey("AMBIENT_GANG_MEXICAN"))
	elseif Group == "TheLost" then
		SetRelationshipBetweenGroups(1,GetHashKey("AMBIENT_GANG_LOST"),GetHashKey("PLAYER"))
		SetRelationshipBetweenGroups(1,GetHashKey("PLAYER"),GetHashKey("AMBIENT_GANG_LOST"))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANCORAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ancorar",function(source,args,rawCommand)
	local ped = PlayerPedId()
	if IsPedInAnyBoat(ped) then
		local Vehicle = GetVehiclePedIsUsing(ped)
		if CanAnchorBoatHere(Vehicle) then
			TriggerEvent("Notify","verde","Embarcação desancorado.",5000)
			SetBoatAnchor(Vehicle,false)
		else
			TriggerEvent("Notify","verde","Embarcação ancorada.",5000)
			SetBoatAnchor(Vehicle,true)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COWCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local cowCoords = {
	{ 2440.58,4736.35,34.29 },
	{ 2432.5,4744.58,34.31 },
	{ 2424.47,4752.37,34.31 },
	{ 2416.28,4760.8,34.31 },
	{ 2408.6,4768.88,34.31 },
	{ 2400.32,4777.48,34.53 },
	{ 2432.46,4802.66,34.83 },
	{ 2440.62,4794.22,34.66 },
	{ 2448.65,4786.57,34.64 },
	{ 2456.88,4778.08,34.49 },
	{ 2464.53,4770.04,34.37 },
	{ 2473.38,4760.98,34.31 },
	{ 2495.03,4762.77,34.37 },
	{ 2503.13,4754.08,34.31 },
	{ 2511.34,4746.04,34.31 },
	{ 2519.56,4737.35,34.29 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCOWS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	for k,v in pairs(cowCoords) do
		exports["target"]:AddCircleZone("Cows:"..k,vector3(v[1],v[2],v[3]),0.75,{
			name = "Cows:"..k,
			heading = 3374176
		},{
			distance = 1.25,
			options = {
				{
					event = "inventory:makeProducts",
					label = "Retirar Leite",
					tunnel = "police",
					service = "milkBottle"
				}
			}
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNKABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local inTrash = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:ENTERTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:enterTrash")
AddEventHandler("player:enterTrash",function(entity)
	if not inTrash then
		LocalPlayer["state"]["Commands"] = true
		LocalPlayer["state"]["Invisible"] = true

		local ped = PlayerPedId()
		FreezeEntityPosition(ped,true)
		SetEntityVisible(ped,false,false)
		SetEntityCoords(ped,entity[4],1,0,0,0)

		inTrash = GetOffsetFromEntityInWorldCoords(entity[1],0.0,-1.5,0.0)

		while inTrash do
			Wait(1)

			if IsControlJustPressed(1,38) then
				FreezeEntityPosition(ped,false)
				SetEntityVisible(ped,true,false)
				SetEntityCoords(ped,inTrash,1,0,0,0)
				LocalPlayer["state"]["Commands"] = false
				LocalPlayer["state"]["Invisible"] = false

				inTrash = false
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKTRASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:checkTrash")
AddEventHandler("player:checkTrash",function()
	if inTrash then
		local ped = PlayerPedId()
		FreezeEntityPosition(ped,false)
		SetEntityVisible(ped,true,false)
		SetEntityCoords(ped,inTrash,1,0,0,0)
		LocalPlayer["state"]["Commands"] = false
		LocalPlayer["state"]["Invisible"] = false

		inTrash = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- YOGABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Yoga = false
local YogaPoints = 0
local YogaTimer = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:YOGA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:Yoga")
AddEventHandler("player:Yoga",function()
	if not Yoga then
		Yoga = true
		YogaPoints = 0
		TriggerEvent("Notify","amarelo","Yoga iniciado, para finalizar pressione <b>E</b>.",5000)

		while Yoga do
			if GetGameTimer() >= YogaTimer then
				YogaTimer = GetGameTimer() + 1000
				YogaPoints = YogaPoints + 1

				if YogaPoints >= 5 then
					TriggerServerEvent("player:Stress",1)
					YogaPoints = 0
				end
			end

			local Ped = PlayerPedId()
			if not IsEntityPlayingAnim(Ped,"amb@world_human_yoga@male@base","base_a",3) then
				vRP.playAnim(false,{"amb@world_human_yoga@male@base","base_a"},true)
			end

			if IsControlJustPressed(1,38) then
				vRP.removeObjects()
				Yoga = false
				break
			end

			Wait(1)
		end
	end
end)