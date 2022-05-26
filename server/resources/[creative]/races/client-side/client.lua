-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("races")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Races = {}
local Selected = 1
local raceTyres = {}
local savePoints = 0
local racePoints = 0
local Checkpoints = 1
local CheckBlip = nil
local Progress = false
local ExplodeTimers = 0
local ExplodeRace = false
local inativeRaces = false
local displayRanking = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADRACES
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		if not inativeRaces then
			local ped = PlayerPedId()

			if IsPedInAnyVehicle(ped) then
				if Progress then
					timeDistance = 100
					racePoints = (GetGameTimer() - savePoints)

					SendNUIMessage({ Points = racePoints, Explosive = (ExplodeTimers - GetGameTimer()) })

					local vehicle = GetVehiclePedIsUsing(ped)
					if GetPedInVehicleSeat(vehicle,-1) ~= ped then
						leaveRace()
					end

					if ExplodeRace and GetGameTimer() >= ExplodeTimers then
						leaveRace()
					end

					local coords = GetEntityCoords(ped)
					local distance = #(coords - vector3(Races[Selected]["coords"][Checkpoints][1][1],Races[Selected]["coords"][Checkpoints][1][2],Races[Selected]["coords"][Checkpoints][1][3]))
					if distance <= 5 then
						if Checkpoints >= #Races[Selected]["coords"] then
							PlaySoundFrontend(-1,"CHECKPOINT_UNDER_THE_BRIDGE","HUD_MINI_GAME_SOUNDSET",false)
							vSERVER.finishRace(Selected,racePoints)
							SendNUIMessage({ show = false })
							Progress = false
							cleanObjects()
							cleanBlips()

							Selected = 1
							raceTyres = {}
							savePoints = 0
							racePoints = 0
							Checkpoints = 1
							CheckBlip = nil
							ExplodeTimers = 0
							ExplodeRace = false
							displayRanking = false
						else
							SendNUIMessage({ upCheckpoint = true })
							Checkpoints = Checkpoints + 1
							makeObjects()
							makeBlips()
						end
					end
				else
					local coords = GetEntityCoords(ped)
					for k,v in pairs(Races) do
						local distance = #(coords - vector3(v["init"][1],v["init"][2],v["init"][3]))
						if distance <= 25 then
							local vehicle = GetVehiclePedIsUsing(ped)
							if GetPedInVehicleSeat(vehicle,-1) == ped then
								DrawMarker(23,v["init"][1],v["init"][2],v["init"][3] - 0.36,0.0,0.0,0.0,0.0,0.0,0.0,10.0,10.0,0.0,46,110,76,100,0,0,0,0)
								timeDistance = 1

								if distance <= 5 then
									if IsControlJustPressed(1,47) then
										if not displayRanking then
											SendNUIMessage({ ranking = vSERVER.requestRanking(k) })
											displayRanking = true
										else
											SendNUIMessage({ ranking = false })
											displayRanking = false
										end
									end

									if IsControlJustPressed(1,38) then
										local raceStatus,raceExplosive = vSERVER.checkPermission()
										if raceStatus then
											if displayRanking then
												SendNUIMessage({ ranking = false })
												displayRanking = false
											end

											SendNUIMessage({ show = true, maxCheckpoint = #Races[k]["coords"] })
											savePoints = GetGameTimer()
											Checkpoints = 1
											racePoints = 0
											Selected = k

											makeObjects()
											makeBlips()

											if raceExplosive then
												ExplodeTimers = GetGameTimer() + (v["explode"] * 1000)
												ExplodeRace = true
											end

											Progress = true
										end
									end
								else
									if displayRanking then
										SendNUIMessage({ ranking = false })
										displayRanking = false
									end
								end
							end
						end
					end
				end
			else
				if Progress then
					leaveRace()
				end

				if displayRanking then
					SendNUIMessage({ ranking = false })
					displayRanking = false
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAKEBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
function makeBlips()
	if DoesBlipExist(CheckBlip) then
		RemoveBlip(CheckBlip)
		CheckBlip = nil
	end

	CheckBlip = AddBlipForCoord(Races[Selected]["coords"][Checkpoints][1][1],Races[Selected]["coords"][Checkpoints][1][2],Races[Selected]["coords"][Checkpoints][1][3])
	SetBlipSprite(CheckBlip,1)
	SetBlipAsShortRange(CheckBlip,true)
	SetBlipScale(CheckBlip,0.5)
	SetBlipColour(CheckBlip,59)
	SetBlipRoute(CheckBlip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Checkpoint")
	EndTextCommandSetBlipName(CheckBlip)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAKEOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
function makeObjects()
	for k,objects in pairs(raceTyres) do
		if DoesEntityExist(objects) then
			DeleteEntity(objects)
			raceTyres[k] = nil
		end
	end

	local mHash = GetHashKey("prop_offroad_tyres02")

	RequestModel(mHash)
	while not HasModelLoaded(mHash) do
		Citizen.Wait(1)
	end

	local _,LeftZ = GetGroundZFor_3dCoord(Races[Selected]["coords"][Checkpoints][2][1],Races[Selected]["coords"][Checkpoints][2][2],Races[Selected]["coords"][Checkpoints][2][3])
	local _,RightZ = GetGroundZFor_3dCoord(Races[Selected]["coords"][Checkpoints][3][1],Races[Selected]["coords"][Checkpoints][3][2],Races[Selected]["coords"][Checkpoints][3][3])

	raceTyres[1] = CreateObject(mHash,Races[Selected]["coords"][Checkpoints][2][1],Races[Selected]["coords"][Checkpoints][2][2],LeftZ,false,false,false)
	raceTyres[2] = CreateObject(mHash,Races[Selected]["coords"][Checkpoints][3][1],Races[Selected]["coords"][Checkpoints][3][2],RightZ,false,false,false)

	PlaceObjectOnGroundProperly(raceTyres[1])
	PlaceObjectOnGroundProperly(raceTyres[2])

	SetEntityLodDist(raceTyres[1],0xFFFF)
	SetEntityLodDist(raceTyres[2],0xFFFF)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
function cleanBlips()
	if DoesBlipExist(CheckBlip) then
		RemoveBlip(CheckBlip)
		CheckBlip = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
function cleanObjects()
	for k,objects in pairs(raceTyres) do
		if DoesEntityExist(objects) then
			DeleteEntity(objects)
			raceTyres[k] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LEAVERACE
-----------------------------------------------------------------------------------------------------------------------------------------
function leaveRace()
	Progress = false
	SendNUIMessage({ show = false })
	cleanObjects()
	cleanBlips()

	Selected = 1
	raceTyres = {}
	savePoints = 0
	racePoints = 0
	Checkpoints = 1
	CheckBlip = nil
	displayRanking = false

	if ExplodeRace then
		Citizen.Wait(3000)

		local vehicle = GetPlayersLastVehicle()
		local coords = GetEntityCoords(vehicle)
		AddExplosion(coords,2,1.0,true,true,true)
		vSERVER.exitRace()
	end

	ExplodeTimers = 0
	ExplodeRace = false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RACES:INATIVERACES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("races:insertList")
AddEventHandler("races:insertList",function(status)
	inativeRaces = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RACES:TABLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("races:Table")
AddEventHandler("races:Table",function(table)
	Races = table

	for _,v in pairs(Races) do
		local blip = AddBlipForRadius(v["init"][1],v["init"][2],v["init"][3],10.0)
		SetBlipAlpha(blip,200)
		SetBlipColour(blip,59)
	end
end)