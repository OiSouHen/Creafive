-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
vRPS = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("taxi")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local locateSelect = 1
local lastPosition = 1
local serviceBlip = nil
local selectPosition = 1
local lastPassenger = nil
local currentStatus = false
local serviceStatus = false
local currentPassenger = nil
local initService = {
	{ 894.97,-179.07,74.7 },
	{ 1696.19,4785.25,42.02 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
local stopVehicle = {
	[1] = {
		{ -1966.18,-500.69,11.83,232.45 },
		{ -1649.93,-451.97,38.89,138.9 },
		{ -1375.14,-966.56,9.01,28.35 },
		{ -1253.14,-1314.72,3.99,201.26 },
		{ -1106.17,-1689.41,4.31,215.44 },
		{ -609.65,-1803.2,23.32,62.37 },
		{ -390.55,-1852.9,20.99,300.48 },
		{ -224.98,-2045.15,27.62,138.9 },
		{ 82.58,-1917.2,20.88,48.19 },
		{ 496.69,-1875.78,26.25,206.93 },
		{ 280.62,-2106.97,16.09,45.36 },
		{ 784.42,-2132.83,29.28,354.34 },
		{ 953.75,-1755.3,31.19,82.21 },
		{ 1307.21,-1718.47,54.31,113.39 },
		{ 502.32,-1725.65,29.27,158.75 },
		{ 789.17,-1392.76,27.04,178.59 },
		{ 1225.93,-1345.74,34.96,170.08 },
		{ 817.56,-1083.69,28.46,87.88 },
		{ 33.58,-1520.65,29.27,136.07 },
		{ -70.78,-1084.91,26.74,340.16 },
		{ -620.99,-921.48,23.3,357.17 },
		{ -741.52,-687.9,30.25,357.17 },
		{ -1227.9,-573.09,27.45,36.86 },
		{ -1311.16,228.57,58.72,87.88 },
		{ -1527.34,440.21,108.95,280.63 },
		{ -1062.61,447.58,74.41,303.31 },
		{ -515.49,423.41,97.09,36.86 },
		{ -755.98,-35.56,37.68,113.39 },
		{ -484.83,-386.07,34.22,263.63 },
		{ -48.76,-261.29,45.81,249.45 },
		{ -105.61,-612.03,36.08,158.75 },
		{ 239.69,-370.36,44.28,252.29 },
		{ 390.37,-83.02,67.75,68.04 },
		{ 709.88,53.65,83.95,141.74 },
		{ 385.57,312.39,103.14,73.71 },
		{ 317.75,570.27,154.45,221.11 },
		{ 247.24,-833.74,29.77,68.04 },
		{ 1150.78,-983.26,46.03,184.26 },
		{ 985.68,-688.99,57.39,204.1 },
		{ 1275.91,-420.3,69.05,206.93 },
		{ 1178.63,-286.08,69.0,218.27 },
		{ 917.39,48.98,80.9,325.99 }
	},
	[2] = {
		{ 2454.12,4952.11,44.72,133.23 },
		{ 2552.54,4690.08,33.35,308.98 },
		{ 1931.37,4598.96,38.6,102.05 },
		{ 2237.73,5143.71,55.3,45.36 },
		{ 2692.28,4329.99,45.48,314.65 },
		{ 2485.03,4089.95,37.61,153.08 },
		{ 1933.34,3716.18,31.95,116.23 },
		{ 1851.22,3747.09,32.69,28.35 },
		{ 1447.46,3662.85,33.82,201.26 },
		{ 1351.07,3595.18,34.49,17.01 },
		{ 922.62,3590.25,32.84,178.59 },
		{ 440.11,3580.88,32.84,257.96 },
		{ 210.59,3090.56,41.82,184.26 },
		{ 2669.94,3253.81,54.85,147.41 },
		{ 1177.36,2691.66,37.47,85.04 },
		{ 966.24,2699.61,39.68,85.04 },
		{ 638.88,2723.66,41.5,2.84 },
		{ 253.38,2600.37,44.48,283.47 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNPEDS
-----------------------------------------------------------------------------------------------------------------------------------------
local spawnPeds = {
	[1] = {
		{ -1978.03,-509.14,11.85,235.28 },
		{ -1667.57,-441.15,40.36,51.03 },
		{ -1359.63,-963.53,9.69,306.15 },
		{ -1256.22,-1330.9,4.08,110.56 },
		{ -1097.49,-1673.1,8.39,306.15 },
		{ -614.88,-1787.1,23.69,36.86 },
		{ -399.23,-1885.84,21.74,127.56 },
		{ -248.08,-2025.52,29.94,229.61 },
		{ 126.73,-1930.0,21.38,212.6 },
		{ 484.66,-1876.23,26.13,116.23 },
		{ 289.85,-2077.23,17.66,294.81 },
		{ 799.38,-2086.64,29.49,130.4 },
		{ 951.99,-1734.68,31.09,175.75 },
		{ 1287.91,-1697.01,55.08,212.6 },
		{ 480.4,-1724.63,29.2,172.92 },
		{ 757.15,-1400.33,26.52,184.26 },
		{ 1204.51,-1367.64,35.37,266.46 },
		{ 828.89,-1067.89,28.19,274.97 },
		{ 20.66,-1505.68,31.85,48.19 },
		{ -40.66,-1082.03,26.61,252.29 },
		{ -598.49,-929.96,23.86,272.13 },
		{ -727.85,-690.97,30.31,5.67 },
		{ -1213.56,-567.34,27.35,158.75 },
		{ -1306.03,240.33,58.99,90.71 },
		{ -1539.98,420.77,110.01,0.0 },
		{ -1052.05,432.44,77.26,11.34 },
		{ -516.68,433.26,97.8,314.65 },
		{ -766.74,-23.56,41.08,25.52 },
		{ -486.25,-401.03,34.54,351.5 },
		{ -83.39,-282.18,45.54,170.08 },
		{ -117.37,-605.81,36.28,70.87 },
		{ 233.12,-410.45,48.11,158.75 },
		{ 390.24,-75.59,68.17,175.75 },
		{ 678.12,74.08,83.14,85.04 },
		{ 380.72,323.91,103.56,192.76 },
		{ 318.48,561.37,154.83,204.1 },
		{ 273.59,-833.14,29.4,19.85 },
		{ 1130.35,-981.46,46.4,158.75 },
		{ 970.84,-701.24,58.49,348.67 },
		{ 1262.68,-429.67,70.01,110.56 },
		{ 1169.03,-291.63,69.02,136.07 },
		{ 935.95,47.06,81.1,328.82 }
	},
	[2] = {
		{ 2454.03,4965.18,46.57,133.23 },
		{ 2564.46,4680.23,34.07,42.52 },
		{ 1928.34,4609.06,40.3,187.09 },
		{ 2243.41,5154.26,57.88,147.41 },
		{ 2697.46,4324.57,45.85,42.52 },
		{ 2476.33,4087.31,38.11,249.45 },
		{ 1930.15,3721.56,32.81,212.6 },
		{ 1858.61,3750.91,33.01,119.06 },
		{ 1435.5,3657.16,34.39,294.81 },
		{ 1360.84,3603.86,34.95,204.1 },
		{ 916.57,3576.95,33.55,274.97 },
		{ 438.77,3571.8,33.23,343.0 },
		{ 191.11,3082.04,43.47,280.63 },
		{ 2662.21,3265.23,55.23,153.08 },
		{ 1177.72,2702.62,38.16,178.59 },
		{ 983.95,2718.64,39.5,178.59 },
		{ 648.49,2721.33,41.87,192.76 },
		{ 252.49,2596.09,44.89,11.34 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNMODELS
-----------------------------------------------------------------------------------------------------------------------------------------
local spawnModels = {
	"ig_abigail","a_m_m_afriamer_01","ig_mp_agent14","csb_agent","ig_amandatownley","s_m_y_ammucity_01","u_m_y_antonb","g_m_m_armboss_01",
	"g_m_m_armgoon_01","g_m_m_armlieut_01","ig_ashley","s_m_m_autoshop_01","ig_money","g_m_y_ballaeast_01","g_f_y_ballas_01","g_m_y_ballasout_01",
	"s_m_y_barman_01","u_m_y_baygor","a_m_o_beach_01","ig_bestmen","a_f_y_bevhills_01","a_m_m_bevhills_02","u_m_m_bikehire_01","u_f_y_bikerchic",
	"mp_f_boatstaff_01","s_m_m_bouncer_01","ig_brad","ig_bride","u_m_y_burgerdrug_01","a_m_m_business_01","a_m_y_business_02","s_m_o_busker_01",
	"ig_car3guy2","cs_carbuyer","g_m_m_chiboss_01","g_m_m_chigoon_01","g_m_m_chigoon_02","u_f_y_comjane","ig_dale","ig_davenorton","s_m_y_dealer_01",
	"ig_denise","ig_devin","a_m_y_dhill_01","ig_dom","a_m_y_downtown_01","ig_dreyfuss"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)

			for k,v in pairs(initService) do
				local distance = #(coords - vector3(v[1],v[2],v[3]))
				if distance <= 2 then
					timeDistance = 1

					if serviceStatus then
						DrawText3D(v[1],v[2],v[3],"~g~E~w~   FINALIZAR")
					else
						DrawText3D(v[1],v[2],v[3],"~g~E~w~   INICIAR")
					end

					if IsControlJustPressed(1,38) then
						if serviceStatus then
							if vSERVER.initService(false) then
								serviceStatus = false

								if DoesBlipExist(serviceBlip) then
									RemoveBlip(serviceBlip)
									serviceBlip = nil
								end

								if currentPassenger ~= nil then
									TriggerServerEvent("tryDeletePed",currentPassenger)
									currentPassenger = nil
								end

								if lastPassenger ~= nil then
									TriggerServerEvent("tryDeletePed",lastPassenger)
									lastPassenger = nil
								end
							end
						else
							if vSERVER.initService(true) then
								locateSelect = k

								repeat
									if lastPosition == selectPosition then
										selectPosition = math.random(#stopVehicle[locateSelect])
									end
									Citizen.Wait(1)
								until lastPosition ~= selectPosition

								currentPassenger = nil
								currentStatus = false
								serviceStatus = true
								lastPassenger = nil
								blipPassenger()
							end
						end
					end
				end
			end
		else
			if serviceStatus then
				local coords = GetEntityCoords(ped)
				local vehicle = GetVehiclePedIsUsing(ped)
				local distance = #(coords - vector3(stopVehicle[locateSelect][selectPosition][1],stopVehicle[locateSelect][selectPosition][2],stopVehicle[locateSelect][selectPosition][3]))
				if distance <= 100 then
					timeDistance = 1

					DrawMarker(1,stopVehicle[locateSelect][selectPosition][1],stopVehicle[locateSelect][selectPosition][2],stopVehicle[locateSelect][selectPosition][3] - 3,0,0,0,0,0,0,5.0,5.0,3.0,255,255,255,25,0,0,0,0)
					DrawMarker(21,stopVehicle[locateSelect][selectPosition][1],stopVehicle[locateSelect][selectPosition][2],stopVehicle[locateSelect][selectPosition][3],0,0,0,0,180.0,130.0,1.5,1.5,1.0,46,110,76,100,0,0,0,1)

					if IsControlJustPressed(1,38) and distance <= 2.5 and GetEntityModel(vehicle) == -956048545 then
						if currentStatus then
							FreezeEntityPosition(vehicle,true)

							if DoesEntityExist(currentPassenger) then
								vSERVER.paymentService()
								Citizen.Wait(1000)
								TaskLeaveVehicle(currentPassenger,vehicle,262144)
								TaskWanderStandard(currentPassenger,10.0,10)
								Citizen.Wait(1000)
								SetVehicleDoorShut(vehicle,3,0)
								Citizen.Wait(1000)
							end

							FreezeEntityPosition(vehicle,false)

							lastPassenger = PedToNet(currentPassenger)
							lastPosition = selectPosition
							currentStatus = false

							repeat
								if lastPosition == selectPosition then
									selectPosition = math.random(#stopVehicle[locateSelect])
								end
								Citizen.Wait(1)
							until lastPosition ~= selectPosition

							blipPassenger()

							Citizen.Wait(5000)

							if lastPassenger ~= nil then
								TriggerServerEvent("tryDeletePed",lastPassenger)
								lastPassenger = nil
							end
						else
							generatePassenger(vehicle)
						end
					end
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
function generatePassenger(vehicle)
	if lastPassenger ~= nil then
		TriggerServerEvent("tryDeletePed",lastPassenger)
		lastPassenger = nil
	end

	local randModels = math.random(#spawnModels)
	local myObject,objNet = vRPS.CreatePed(spawnModels[randModels],spawnPeds[locateSelect][selectPosition][1],spawnPeds[locateSelect][selectPosition][2],spawnPeds[locateSelect][selectPosition][3],3374176,4)
	if myObject then
		local spawnPassenger = 0
		currentPassenger = NetworkGetEntityFromNetworkId(objNet)
		while not DoesEntityExist(currentPassenger) and spawnPassenger <= 1000 do
			currentPassenger = NetworkGetEntityFromNetworkId(objNet)
			spawnPassenger = spawnPassenger + 1
			Citizen.Wait(1)
		end

		spawnPassenger = 0
		local pedControl = NetworkRequestControlOfEntity(currentPassenger)
		while not pedControl and spawnPassenger <= 1000 do
			pedControl = NetworkRequestControlOfEntity(currentPassenger)
			spawnPassenger = spawnPassenger + 1
			Citizen.Wait(1)
		end

		TaskEnterVehicle(currentPassenger,vehicle,-1,2,1.0,1,0)
		SetEntityInvincible(currentPassenger,true)
		SetEntityAsNoLongerNeeded(currentPassenger)

		while not IsPedSittingInVehicle(currentPassenger,vehicle) do
			Citizen.Wait(1)
		end

		lastPosition = selectPosition
		repeat
			if lastPosition == selectPosition then
				selectPosition = math.random(#stopVehicle[locateSelect])
			end
			Citizen.Wait(1)
		until lastPosition ~= selectPosition

		currentStatus = true
		blipPassenger()
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAKEBLIPMARKED
-----------------------------------------------------------------------------------------------------------------------------------------
function blipPassenger()
	if DoesBlipExist(serviceBlip) then
		RemoveBlip(serviceBlip)
		serviceBlip = nil
	end

	serviceBlip = AddBlipForCoord(stopVehicle[locateSelect][selectPosition][1],stopVehicle[locateSelect][selectPosition][2],stopVehicle[locateSelect][selectPosition][3])
	SetBlipSprite(serviceBlip,12)
	SetBlipColour(serviceBlip,5)
	SetBlipScale(serviceBlip,0.9)
	SetBlipRoute(serviceBlip,true)
	SetBlipAsShortRange(serviceBlip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Taxista")
	EndTextCommandSetBlipName(serviceBlip)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text)
	local onScreen,_x,_y = GetScreenCoordFromWorldCoord(x,y,z)

	if onScreen then
		BeginTextCommandDisplayText("STRING")
		AddTextComponentSubstringKeyboardDisplay(text)
		SetTextColour(255,255,255,150)
		SetTextScale(0.35,0.35)
		SetTextFont(4)
		SetTextCentre(1)
		EndTextCommandDisplayText(_x,_y)

		local width = string.len(text) / 160 * 0.45
		DrawRect(_x,_y + 0.0125,width,0.03,15,15,15,175)
	end
end