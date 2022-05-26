-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("engine")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local isPrice = 0
local lastFuel = 0
local vehFuels = {}
local isFuel = false
local showNui = false
local gameTimer = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- GAMEEVENTTRIGGERED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("gameEventTriggered",function(eventName,args)
	if eventName == "CEventNetworkPlayerEnteredVehicle" then
		if args[1] == PlayerId() then
			local vehPlate = GetVehicleNumberPlateText(args[2])
			vehFuels[vehPlate] = vSERVER.vehicleFuel(vehPlate)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHCLASS
-----------------------------------------------------------------------------------------------------------------------------------------
local vehClass = {
	[0] = 1.0,
	[1] = 1.0,
	[2] = 1.0,
	[3] = 1.0,
	[4] = 1.0,
	[5] = 1.0,
	[6] = 1.0,
	[7] = 1.0,
	[8] = 1.0,
	[9] = 1.0,
	[10] = 1.0,
	[11] = 1.0,
	[12] = 1.0,
	[13] = 0.0,
	[14] = 0.0,
	[15] = 2.5,
	[16] = 1.0,
	[17] = 1.0,
	[18] = 1.0,
	[19] = 1.0,
	[20] = 1.0,
	[21] = 0.0
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHFUEL
-----------------------------------------------------------------------------------------------------------------------------------------
local vehFuel = {
	[1.0] = 0.80,
	[0.9] = 0.75,
	[0.8] = 0.70,
	[0.7] = 0.65,
	[0.6] = 0.60,
	[0.5] = 0.50,
	[0.4] = 0.40,
	[0.3] = 0.30,
	[0.2] = 0.20,
	[0.1] = 0.10,
	[0.0] = 0.00
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUELLOCS
-----------------------------------------------------------------------------------------------------------------------------------------
local fuelLocs = {
	{ 265.05,-1262.65,29.3,15.0,0.085 },
	{ 819.14,-1028.65,26.41,15.0,0.085 },
	{ 1208.61,-1402.43,35.23,15.0,0.065 },
	{ 1181.48,-330.26,69.32,10.0,0.075 },
	{ 621.01,268.68,103.09,15.0,0.075 },
	{ 2581.09,361.79,108.47,17.0,0.055 },
	{ 175.08,-1562.12,29.27,15.0,0.075 },
	{ -319.76,-1471.63,30.55,17.0,0.075 },
	{ 1784.51,3330.1,41.27,5.0,0.085 },
	{ 49.42,2778.8,58.05,15.0,0.055 },
	{ 264.09,2606.56,44.99,15.0,0.065 },
	{ 1039.38,2671.28,39.56,15.0,0.065 },
	{ 1207.4,2659.93,37.9,10.0,0.065 },
	{ 2539.19,2594.47,37.95,9.0,0.055 },
	{ 2679.95,3264.18,55.25,10.0,0.065 },
	{ 2005.03,3774.43,32.41,15.0,0.075 },
	{ 1687.07,4929.53,42.08,15.0,0.055 },
	{ 1701.53,6415.99,32.77,10.0,0.065 },
	{ 179.86,6602.97,31.86,15.0,0.085 },
	{ -94.46,6419.59,31.48,15.0,0.085 },
	{ -2555.17,2334.23,33.08,16.0,0.065 },
	{ -1800.09,803.54,138.72,16.0,0.065 },
	{ -1437.0,-276.8,46.21,15.0,0.075 },
	{ -2096.3,-320.17,13.17,17.0,0.085 },
	{ -724.56,-935.97,19.22,17.0,0.075 },
	{ -525.26,-1211.19,18.19,15.0,0.075 },
	{ -70.96,-1762.21,29.54,15.0,0.085 },
	{ -1112.4,-2884.08,13.93,15.0,0.075 },
	{ -2505.68,4079.25,38.79,7.0,0.075 },
	{ 2505.42,4079.81,38.79,7.0,0.075 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FLOOR
-----------------------------------------------------------------------------------------------------------------------------------------
function floor(num)
	local mult = 10 ^ 1
	return math.floor(num * mult + 0.5) / mult
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONSUMEFUEL
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)

	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsUsing(ped)
			local speed = GetEntitySpeed(vehicle) * 2.236936
			if GetVehicleFuelLevel(vehicle) >= 1 then
				if speed >= 1 then
					local vehPlate = GetVehicleNumberPlateText(vehicle)

					if vehFuels[vehPlate] ~= nil then
						local vehClasses = GetVehicleClass(vehicle)

						vehFuels[vehPlate] = (vehFuels[vehPlate] - (vehFuel[floor(GetVehicleCurrentRpm(vehicle))] or 1.0) * (vehClass[vehClasses] or 1.0) / 10)
						SetVehicleFuelLevel(vehicle,vehFuels[vehPlate])
					end

					if GetPedInVehicleSeat(vehicle,-1) == ped then
						TriggerServerEvent("engine:tryFuel",vehPlate,vehFuels[vehPlate])
					end
				end
			else
				SetVehicleEngineOn(vehicle,false,true,true)
				timeDistance = 1
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREDREFUEL
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			if GetSelectedPedWeapon(ped) == 883325847 then
				local vehicle = GetPlayersLastVehicle()
				if DoesEntityExist(vehicle) then
					local coords = GetEntityCoords(ped)
					local coordsVeh = GetEntityCoords(vehicle)
					local vehFuel = GetVehicleFuelLevel(vehicle)
					local vehPlate = GetVehicleNumberPlateText(vehicle)
					local distance = #(coords - vector3(coordsVeh["x"],coordsVeh["y"],coordsVeh["z"]))
					if distance <= 3.5 then
						timeDistance = 1

						if not isFuel then
							if GetAmmoInPedWeapon(ped,883325847) - 0.02 * 100 <= 1 then
								text3D(coordsVeh["x"],coordsVeh["y"],coordsVeh["z"] + 1,"~b~GALÃO VAZIO")
							elseif vehFuel < 100.0 then
								text3D(coordsVeh["x"],coordsVeh["y"],coordsVeh["z"] + 1,"~g~E~w~   ABASTECER")
							end
						else
							if GetAmmoInPedWeapon(ped,883325847) - 0.02 * 100 > 1 then
								SetPedAmmo(ped,883325847,math.floor(GetAmmoInPedWeapon(ped,883325847) - 0.02 * 100))

								SetVehicleFuelLevel(vehicle,vehFuel + 0.025)
								text3D(coordsVeh["x"],coordsVeh["y"],coordsVeh["z"] + 1,"~g~E~w~   CANCELAR")
								text3D(coordsVeh["x"],coordsVeh["y"],coordsVeh["z"] + 0.85,"TANQUE: ~y~"..parseInt(floor(vehFuel)).."%   ~w~GALÃO: ~y~"..parseInt(GetAmmoInPedWeapon(ped,883325847) / 4500 * 100).."%")

								if not IsEntityPlayingAnim(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",3) then
									TaskPlayAnim(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",3.0,3.0,-1,50,0,0,0,0)
								end

								if vehFuel >= 100.0 or GetAmmoInPedWeapon(ped,883325847) - 0.02 * 100 <= 1 or GetEntityHealth(ped) <= 101 then
									TriggerServerEvent("engine:tryFuel",vehPlate,vehFuel)
									StopAnimTask(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",2.0)
									RemoveAnimDict("timetable@gardener@filling_can")
									isFuel = false
								end
							end
						end

						if IsControlJustPressed(1,38) and GetGameTimer() >= gameTimer and MumbleIsConnected() then
							gameTimer = GetGameTimer() + 3000

							if isFuel then
								TriggerServerEvent("engine:tryFuel",vehPlate,vehFuel)
								StopAnimTask(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",2.0)
								RemoveAnimDict("timetable@gardener@filling_can")
								isFuel = false
							else
								if GetAmmoInPedWeapon(ped,883325847) - 0.02 * 100 >= 0 and vehFuel <= 100.0 then
									TaskTurnPedToFaceEntity(ped,vehicle,5000)
									loadAnim("timetable@gardener@filling_can")
									TaskPlayAnim(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",3.0,3.0,-1,50,0,0,0,0)
									isFuel = true
								end
							end
						end
					end

					if isFuel and distance > 3.5 then
						TriggerServerEvent("engine:tryFuel",vehPlate,vehFuel)
						StopAnimTask(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",2.0)
						RemoveAnimDict("timetable@gardener@filling_can")
						isFuel = false
					end
				end
			else
				local coords = GetEntityCoords(ped)

				for k,v in pairs(fuelLocs) do
					local distance = #(coords - vector3(v[1],v[2],v[3]))
					if distance <= v[4] then
						timeDistance = 1
						local vehicle = GetPlayersLastVehicle()
						if DoesEntityExist(vehicle) then
							local coordsVeh = GetEntityCoords(vehicle)
							local vehFuel = GetVehicleFuelLevel(vehicle)
							local vehPlate = GetVehicleNumberPlateText(vehicle)
							local distance = #(coords - vector3(coordsVeh["x"],coordsVeh["y"],coordsVeh["z"]))

							if distance <= 3.5 then
								if not isFuel then
									if vehFuel < 100.0 then
										text3D(coordsVeh["x"],coordsVeh["y"],coordsVeh["z"] + 1,"~g~E~w~   ABASTECER")
									end
								else
									if not showNui then
										SendNUIMessage({ show = true })
										showNui = true
									end

									isPrice = isPrice + v[5]
									SetVehicleFuelLevel(vehicle,vehFuel + 0.025)
									SendNUIMessage({ tank = parseInt(floor(vehFuel)), price = parseInt(isPrice), lts = v[5] * 4 })
									text3D(coordsVeh["x"],coordsVeh["y"],coordsVeh["z"] + 1,"~g~E~w~   FINALIZAR")

									if not IsEntityPlayingAnim(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",3) then
										TaskPlayAnim(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",3.0,3.0,-1,50,0,0,0,0)
									end

									if vehFuel >= 100.0 or GetEntityHealth(ped) <= 101 then
										if vSERVER.paymentFuel(isPrice,vehPlate,vehFuel) then
											TriggerServerEvent("engine:tryFuel",vehPlate,vehFuel)
											vehFuels[vehPlate] = vehFuel
										else
											TriggerServerEvent("engine:tryFuel",vehPlate,lastFuel)
											vehFuels[vehPlate] = lastFuel
										end

										StopAnimTask(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",2.0)
										RemoveAnimDict("timetable@gardener@filling_can")
										SendNUIMessage({ show = false })
										showNui = false
										isFuel = false
										isPrice = 0
									end
								end

								if IsControlJustPressed(1,38) and GetGameTimer() >= gameTimer and MumbleIsConnected() then
									gameTimer = GetGameTimer() + 3000

									if isFuel then
										if vSERVER.paymentFuel(isPrice,vehPlate,vehFuel) then
											TriggerServerEvent("engine:tryFuel",vehPlate,vehFuel)
											vehFuels[vehPlate] = vehFuel
										else
											TriggerServerEvent("engine:tryFuel",vehPlate,lastFuel)
											vehFuels[vehPlate] = lastFuel
										end

										StopAnimTask(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",2.0)
										RemoveAnimDict("timetable@gardener@filling_can")
										SendNUIMessage({ show = false })
										showNui = false
										isFuel = false
										isPrice = 0
									else
										if vehFuel < 100.0 then
											lastFuel = vehFuel
											TaskTurnPedToFaceEntity(ped,vehicle,5000)
											loadAnim("timetable@gardener@filling_can")
											TaskPlayAnim(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",3.0,3.0,-1,50,0,0,0,0)
											isFuel = true
										end
									end
								end
							end

							if isFuel and distance > 3.5 then
								if vSERVER.paymentFuel(isPrice,vehPlate,vehFuel) then
									TriggerServerEvent("engine:tryFuel",vehPlate,vehFuel)
									vehFuels[vehPlate] = vehFuel
								else
									TriggerServerEvent("engine:tryFuel",vehPlate,lastFuel)
									vehFuels[vehPlate] = lastFuel
								end

								StopAnimTask(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",2.0)
								RemoveAnimDict("timetable@gardener@filling_can")
								SendNUIMessage({ show = false })
								showNui = false
								isFuel = false
								isPrice = 0
							end
						end
					end
				end
			end

			if isFuel then
				DisableControlAction(1,18,true)
				DisableControlAction(1,22,true)
				DisableControlAction(1,23,true)
				DisableControlAction(1,24,true)
				DisableControlAction(1,29,true)
				DisableControlAction(1,30,true)
				DisableControlAction(1,31,true)
				DisableControlAction(1,140,true)
				DisableControlAction(1,142,true)
				DisableControlAction(1,143,true)
				DisableControlAction(1,257,true)
				DisableControlAction(1,263,true)
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCFUEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("engine:syncFuel")
AddEventHandler("engine:syncFuel",function(vehPlate,vehResult)
	vehFuels[vehPlate] = vehResult
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function text3D(x,y,z,text)
	local onScreen,_x,_y = GetScreenCoordFromWorldCoord(x,y,z)

	if onScreen then
		BeginTextCommandDisplayText("STRING")
		AddTextComponentSubstringKeyboardDisplay(text)
		SetTextColour(255,255,255,150)
		SetTextScale(0.35,0.35)
		SetTextFont(4)
		SetTextCentre(1)
		EndTextCommandDisplayText(_x,_y)

		local width = (string.len(text) + 4) / 170 * 0.45
		DrawRect(_x,_y + 0.0125,width,0.03,15,15,15,175)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADANIM
-----------------------------------------------------------------------------------------------------------------------------------------
function loadAnim(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(1)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VTUNING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("engine:vehTuning")
AddEventHandler("engine:vehTuning",function()
	local vehicle = vRP.nearVehicle(5)
	if vehicle then
		local motor = GetVehicleMod(vehicle,11)
		local freio = GetVehicleMod(vehicle,12)
		local transmissao = GetVehicleMod(vehicle,13)
		local suspensao = GetVehicleMod(vehicle,15)
		local blindagem = GetVehicleMod(vehicle,16)
		local body = GetVehicleBodyHealth(vehicle)
		local engine = GetVehicleEngineHealth(vehicle)
		local fuel = GetVehicleFuelLevel(vehicle)
		local plate = GetVehicleNumberPlateText(vehicle)

		if motor == -1 then
			motor = "Desativado"
		elseif motor == 0 then
			motor = "Nível 1 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 1 then
			motor = "Nível 2 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 2 then
			motor = "Nível 3 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 3 then
			motor = "Nível 4 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 4 then
			motor = "Nível 5 / "..GetNumVehicleMods(vehicle,11)
		end

		if freio == -1 then
			freio = "Desativado"
		elseif freio == 0 then
			freio = "Nível 1 / "..GetNumVehicleMods(vehicle,12)
		elseif freio == 1 then
			freio = "Nível 2 / "..GetNumVehicleMods(vehicle,12)
		elseif freio == 2 then
			freio = "Nível 3 / "..GetNumVehicleMods(vehicle,12)
		end

		if transmissao == -1 then
			transmissao = "Desativado"
		elseif transmissao == 0 then
			transmissao = "Nível 1 / "..GetNumVehicleMods(vehicle,13)
		elseif transmissao == 1 then
			transmissao = "Nível 2 / "..GetNumVehicleMods(vehicle,13)
		elseif transmissao == 2 then
			transmissao = "Nível 3 / "..GetNumVehicleMods(vehicle,13)
		elseif transmissao == 3 then
			transmissao = "Nível 4 / "..GetNumVehicleMods(vehicle,13)
		end

		if suspensao == -1 then
			suspensao = "Desativado"
		elseif suspensao == 0 then
			suspensao = "Nível 1 / "..GetNumVehicleMods(vehicle,15)
		elseif suspensao == 1 then
			suspensao = "Nível 2 / "..GetNumVehicleMods(vehicle,15)
		elseif suspensao == 2 then
			suspensao = "Nível 3 / "..GetNumVehicleMods(vehicle,15)
		elseif suspensao == 3 then
			suspensao = "Nível 4 / "..GetNumVehicleMods(vehicle,15)
		elseif suspensao == 4 then
			suspensao = "Nível 5 / "..GetNumVehicleMods(vehicle,15)
		end

		if blindagem == -1 then
			blindagem = "Desativado"
		elseif blindagem == 0 then
			blindagem = "Nível 1 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 1 then
			blindagem = "Nível 2 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 2 then
			blindagem = "Nível 3 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 3 then
			blindagem = "Nível 4 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 4 then
			blindagem = "Nível 5 / "..GetNumVehicleMods(vehicle,16)
		end

		TriggerEvent("Notify","default","<b>Motor:</b> "..motor.."<br><b>Freio:</b> "..freio.."<br><b>Transmissão:</b> "..transmissao.."<br><b>Suspensão:</b> "..suspensao.."<br><b>Blindagem:</b> "..blindagem.."<br><b>Lataria:</b> "..parseInt(body / 10).."%<br><b>Nitro:</b> "..parseInt((GlobalState["Nitro"][plate] or 0) / 2).."%<br><b>Motor:</b> "..parseInt(engine / 10).."%<br><b>Gasolina:</b> "..parseInt(fuel).."%",10000)
	end
end)