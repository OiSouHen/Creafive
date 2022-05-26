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
Tunnel.bindInterface("drugs",cRP)
vSERVER = Tunnel.getInterface("drugs")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local pedList = {}
local gridAmount = {}
local selectPeds = false
local initSelling = false
local drugsSelling = false
local stopProximity = false
local timeSelling = GetGameTimer()
local timeCalling = GetGameTimer()
local timeProximity = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- GRIDCHUNK
-----------------------------------------------------------------------------------------------------------------------------------------
function gridChunk(x)
	return math.floor((x + 8192) / 128)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOCHANNEL
-----------------------------------------------------------------------------------------------------------------------------------------
function toChannel(v)
	return (v["x"] << 8) | v["y"]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETGRIDZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function getGridzone(x,y)
	local gridChunk = vector2(gridChunk(x),gridChunk(y))
	return toChannel(gridChunk)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRUGS:INITSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("drugs:initService")
AddEventHandler("drugs:initService",function()
	if drugsSelling then
		if selectPeds then
			TaskWanderStandard(selectPeds,10,10)
		end

		selectPeds = false
		initSelling = false
		drugsSelling = false
		stopProximity = false
		timeSelling = GetGameTimer()
		timeCalling = GetGameTimer()
		timeProximity = GetGameTimer()

		TriggerEvent("Notify","verde","Número removido da lista.",5000)
	else
		drugsSelling = true
		timeCalling = GetGameTimer() + math.random(15000,45000)
		TriggerEvent("Notify","verde","Número adicionado na lista.",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSEARCHPED
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if drugsSelling then
			local ped = PlayerPedId()
			if not IsPedInAnyVehicle(ped) and not selectPeds then
				local _,searchPeds = FindFirstPed()
				repeat
					if GetGameTimer() >= timeCalling and not IsEntityDead(searchPeds) and not pedList[searchPeds] and not IsPedDeadOrDying(searchPeds) and GetPedArmour(searchPeds) <= 0 and not IsPedAPlayer(searchPeds) and not IsPedInAnyVehicle(searchPeds) and GetPedType(searchPeds) ~= 28 then
						local coords = GetEntityCoords(ped)
						local pCoords = GetEntityCoords(searchPeds)
						local distance = #(coords - pCoords)
						if distance <= 50 then
							SetEntityAsMissionEntity(searchPeds,true,true)
							ClearPedTasksImmediately(searchPeds)
							ClearPedSecondaryTask(searchPeds)
							ClearPedTasks(searchPeds)

							TriggerEvent("Notify","verde","Um cliente em potencial está a caminho,<br>aguarde até que o mesmo venha até você.",5000)
							TaskGoToEntity(searchPeds,ped,-1,2.0,1.0,1073741824,0)
							timeProximity = GetGameTimer() + 180000
							SetEntityHealth(searchPeds,200)
							pedList[searchPeds] = true
							selectPeds = searchPeds
							stopProximity = false
							initSelling = false
							goto finishSearch
						end
					end

					search,searchPeds = FindNextPed()
				until not search EndFindPed()

				::finishSearch::
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSEARCHPED
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		if selectPeds then
			if DoesEntityExist(selectPeds) then
				local ped = PlayerPedId()

				if GetEntityHealth(ped) <= 101 or IsPedInAnyVehicle(ped) then
					TaskWanderStandard(selectPeds,10,10)
					drugsSelling = false
					selectPeds = false
				end

				if GetEntityHealth(selectPeds) < 200 or IsPedDeadOrDying(selectPeds) or IsPedInAnyVehicle(selectPeds) or IsEntityDead(selectPeds) then
					TaskWanderStandard(selectPeds,10,10)
					selectPeds = false
				end

				timeDistance = 1
				local coords = GetEntityCoords(ped)
				local pCoords = GetEntityCoords(selectPeds)
				local distance = #(coords - pCoords)

				if not stopProximity then
					if distance <= 2.0 then
						if not stopProximity then
							PlayAmbientSpeech1(selectPeds,"GENERIC_HI","SPEECH_PARAMS_STANDARD")
							stopProximity = true
						end
					end

					if GetGameTimer() >= timeProximity then
						TriggerEvent("Notify","amarelo","O cliente desistiu da negociação, aguarde<br>até que o próximo entre em contato com você.",5000)
						timeCalling = GetGameTimer() + math.random(15000,45000)
						TaskWanderStandard(selectPeds,10,10)
						selectPeds = false
					end
				else
					if not initSelling then
						text3D(pCoords["x"],pCoords["y"],pCoords["z"],"~g~E~w~  NEGOCIAR",0.40)

						if IsControlJustPressed(1,38) and not initSelling then
							if vSERVER.checkAmount() then
								timeSelling = GetGameTimer() + 10000
								initSelling = true
							else
								TriggerEvent("Notify","amarelo","O cliente desistiu da negociação<br>porque você não possui mais mercadoria.",5000)
								timeCalling = GetGameTimer() + math.random(15000,45000)
								TaskWanderStandard(selectPeds,10,10)
								selectPeds = false
							end
						end
					else
						if GetGameTimer() < timeSelling then
							text3D(pCoords["x"],pCoords["y"],pCoords["z"],"NEGOCIAÇÃO EM ANDAMENTO",0.55)

							if distance > 2.0 then
								TaskWanderStandard(selectPeds,10,10)
								selectPeds = false
							end
						else
							vRP.removeObjects()

							local objHash = "prop_anim_cash_note"
							local pedAnim = "mp_safehouselost@"

							RequestModel(objHash)
							while not HasModelLoaded(objHash) do
								Citizen.Wait(1)
							end

							RequestAnimDict(pedAnim)
							while not HasAnimDictLoaded(pedAnim) do
								Citizen.Wait(1)
							end

							if HasModelLoaded(objHash) and HasAnimDictLoaded(pedAnim) then
								local pedObjects = CreateObject(objHash,coords["x"],coords["y"],coords["z"],false,false,false)
								AttachEntityToEntity(pedObjects,selectPeds,GetPedBoneIndex(selectPeds,28422),0.0,0.0,0.0,90.0,0.0,0.0,false,false,false,false,2,true)
								vRP.createObjects(pedAnim,"package_dropoff","prop_paper_bag_small",16,28422,0.0,-0.05,0.05,180.0,0.0,0.0)
								TaskPlayAnim(selectPeds,pedAnim,"package_dropoff",8.0,1.0,-1,16,0,0,0,0)
								LocalPlayer["state"]["Cancel"] = true

								Citizen.Wait(3000)

								timeCalling = GetGameTimer() + math.random(15000,45000)
								LocalPlayer["state"]["Cancel"] = false
								TaskWanderStandard(selectPeds,10,10)

								if DoesEntityExist(pedObjects) then
									DeleteEntity(pedObjects)
								end

								local gridZone = getGridzone(coords["x"],coords["y"])
								if gridAmount[gridZone] == nil then
									gridAmount[gridZone] = 0
								end

								gridAmount[gridZone] = gridAmount[gridZone] + 1

								vSERVER.paymentMethod(gridAmount[gridZone])
								vRP.removeObjects()
								selectPeds = false

								if gridAmount[gridZone] >= 5 then
									gridAmount = {}
								end
							end
						end
					end
				end
			else
				selectPeds = false
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function text3D(x,y,z,text,weight)
	local onScreen,_x,_y = GetScreenCoordFromWorldCoord(x,y,z + 0.25)

	if onScreen then
		BeginTextCommandDisplayText("STRING")
		AddTextComponentSubstringKeyboardDisplay(text)
		SetTextColour(255,255,255,150)
		SetTextScale(0.35,0.35)
		SetTextFont(4)
		SetTextCentre(1)
		EndTextCommandDisplayText(_x,_y)

		local width = (string.len(text) + 4) / 170 * weight
		DrawRect(_x,_y + 0.0125,width,0.03,15,15,15,175)
	end
end