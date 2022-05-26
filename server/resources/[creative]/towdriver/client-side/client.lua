-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("towdriver")
vGARAGE = Tunnel.getInterface("garages")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local inTowed = nil
local vehTower = nil
local spawnSelect = 0
local spawnCoords = 0
local inService = false
local serviceLocate = 1
local spawnVehicle = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITLOCATES
-----------------------------------------------------------------------------------------------------------------------------------------
local initLocates = {
	{ -193.23,-1162.39,23.67 },
	{ 1737.95,3709.1,34.14 },
	{ -273.96,6121.63,31.41 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHMODELS
-----------------------------------------------------------------------------------------------------------------------------------------
local vehModels = {
	"baller","jackal","mule","youga","mesa","nemesis","primo","biff","bison","seminole","zion2","landstalker","panto",
	"boxville2","premier","scrap","rhapsody","pcj","jester","superd","sentinel","bus","sentinel2","blazer2","asea",
	"regina","pounder","huntley","tornado","rubble","tribike","bjxl","patriot","ingot","serrano","fq2","bobcatxl",
	"journey","bfinjection","sanchez2","surfer2","caddy2","rebel2","bagger","dilettante","blista","hexer",
	"buffalo","emperor2","fugitive","rocoto","dukes","thrust","faggio2","double","camper","massacro","feltzer2",
	"sabregt","ninef2","banshee","infernus","bullet","coquette","phoenix","cavalcade","stratum","minivan","picador",
	"taco","glendale","intruder","ruffian","schafter2","asterope","mixer2","rumpo","exemplar","surfer","cavalcade2"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHRESCUE
-----------------------------------------------------------------------------------------------------------------------------------------
local vehRescue = {
	[1] = {
		{ 28.5,-854.84,30.33,158.75 },
		{ 252.45,-993.12,28.81,343.0 },
		{ 556.83,-862.98,40.42,269.3 },
		{ 1149.26,-887.2,52.72,170.08 },
		{ 1155.34,-1516.53,34.44,272.13 },
		{ 1373.69,-1681.71,58.97,212.6 },
		{ 1178.81,-2064.17,42.5,102.05 },
		{ 1050.14,-2168.41,31.49,172.92 },
		{ 961.48,-2457.54,28.07,82.21 },
		{ 291.67,-2488.37,6.12,0.0 },
		{ 405.66,-2179.16,15.43,294.81 },
		{ 416.83,-1968.63,23.02,42.52 },
		{ 175.5,-1890.31,23.35,65.2 },
		{ 44.56,-1883.22,21.72,51.03 },
		{ -222.87,-1792.68,29.28,119.06 },
		{ -351.04,-1664.13,18.35,331.66 },
		{ -511.33,-1336.99,28.98,345.83 },
		{ -513.07,-1280.71,26.52,155.91 },
		{ -691.92,-951.57,19.66,87.88 },
		{ -952.37,-1083.27,1.82,212.6 },
		{ -1213.22,-1217.7,7.25,192.76 },
		{ -1257.85,-1318.35,3.71,291.97 },
		{ -1286.37,-1391.73,4.03,107.72 },
		{ -1468.04,-876.73,10.09,65.2 },
		{ -2067.89,-372.87,11.46,65.2 },
		{ -1810.02,-336.98,43.24,317.49 },
		{ -1295.11,-75.57,46.45,257.96 },
		{ -849.42,-308.54,38.3,243.78 },
		{ -816.79,-214.54,36.92,28.35 },
		{ -1005.2,103.94,51.98,31.19 },
		{ -1082.61,455.74,76.35,328.82 },
		{ -1416.98,536.48,121.32,107.72 },
		{ -1106.72,789.79,163.97,189.93 },
		{ -613.22,979.3,240.3,277.8 },
		{ 51.47,1039.24,217.83,68.04 },
		{ 304.2,929.97,205.21,167.25 }
	},
	[2] = {
		{ 1879.32,3821.21,32.0,300.48 },
		{ 1966.01,3777.16,31.86,25.52 },
		{ 2187.55,3510.93,45.11,70.87 },
		{ 1754.84,3342.44,40.81,294.81 },
		{ 2008.58,3074.77,46.72,325.99 },
		{ 1537.71,2781.66,37.71,121.89 },
		{ 1168.17,2695.24,37.52,175.75 },
		{ 685.6,2707.86,40.12,87.88 },
		{ 646.21,2757.55,41.65,187.09 },
		{ 253.86,2634.52,44.82,96.38 },
		{ -6.81,2800.15,57.22,59.53 },
		{ 231.59,3094.28,42.12,102.05 },
		{ 225.71,3368.46,38.92,34.02 },
		{ 100.01,3460.58,39.39,0.0 },
		{ 437.64,3521.79,33.33,93.55 },
		{ 888.22,3656.44,32.5,181.42 },
		{ 1573.38,3768.74,34.26,306.15 },
		{ 1707.0,3876.76,34.53,5.67 },
		{ 1925.95,3871.48,32.0,116.23 },
		{ 2437.43,4005.0,36.7,246.62 },
		{ 2502.0,4197.8,39.58,209.77 }
	},
	[3] = {
		{ -325.38,6138.76,31.16,42.52 },
		{ -82.76,6561.0,31.16,223.94 },
		{ 23.69,6527.71,31.1,45.36 },
		{ 134.72,6652.75,31.32,226.78 },
		{ 21.24,6663.29,31.21,184.26 },
		{ -577.95,6108.47,7.95,5.67 },
		{ -433.78,6360.32,13.01,34.02 },
		{ -199.21,6562.95,10.75,314.65 },
		{ -681.17,5939.75,15.5,178.59 },
		{ -804.36,5556.76,32.01,221.11 },
		{ -971.22,5419.9,39.14,121.89 },
		{ -1291.04,5230.11,53.82,331.66 },
		{ -1463.12,5056.95,61.54,124.73 },
		{ -1732.24,4796.22,58.06,127.56 },
		{ 809.78,6485.31,23.05,266.46 },
		{ 1314.11,6511.21,19.46,133.23 },
		{ 1478.02,6352.05,23.4,297.64 },
		{ 1951.09,6200.55,44.6,204.1 },
		{ 1819.56,6372.82,39.51,82.21 },
		{ 1604.44,6542.75,14.68,11.34 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICETOGGLE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	for k,v in pairs(initLocates) do
		exports["target"]:AddCircleZone("TowDriver:"..k,vector3(v[1],v[2],v[3]),1.0,{
			name = "TowDriver:"..k,
			heading = 3374176
		},{
			shop = k,
			distance = 1.5,
			options = {
				{
					event = "towdriver:Toggle",
					label = "Trabalhar",
					tunnel = "shop"
				},{
					event = "garages:Impound",
					label = "Apreendidos",
					tunnel = "shop"
				}
			}
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOWDRIVER:TOGGLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("towdriver:Toggle")
AddEventHandler("towdriver:Toggle",function(id)
	if inService then
		inService = false
	else
		inService = true
		serviceLocate = id
		spawnSelect = math.random(#vehModels)
		spawnCoords = math.random(#vehRescue[serviceLocate])

		TriggerEvent("NotifyPush",{ code = 20, title = "Registro de Veículo", x = vehRescue[serviceLocate][spawnCoords][1], y = vehRescue[serviceLocate][spawnCoords][2], z = vehRescue[serviceLocate][spawnCoords][3], name = "Aguardando reboque", blipColor = 2 })
	end

	vSERVER.toggleService()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if inService and not spawnVehicle then
			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)
			local distance = #(coords - vector3(vehRescue[serviceLocate][spawnCoords][1],vehRescue[serviceLocate][spawnCoords][2],vehRescue[serviceLocate][spawnCoords][3]))

			if distance <= 100 then
				spawnVehicle = true
				local vehName = vehModels[spawnSelect]
				local heading = vehRescue[serviceLocate][spawnCoords][4]

				vGARAGE.serverVehicle(vehName,vehRescue[serviceLocate][spawnCoords][1],vehRescue[serviceLocate][spawnCoords][2],vehRescue[serviceLocate][spawnCoords][3],heading,nil,0,nil,100)
			end
		end

		Citizen.Wait(5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOWDRIVER:TOGGLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("towdriver:Tow")
AddEventHandler("towdriver:Tow",function(entity)
	if entity[2] == vehModels[spawnSelect] then
		spawnVehicle = false
		vSERVER.paymentMethod()
		spawnSelect = math.random(#vehModels)
		spawnCoords = math.random(#vehRescue[serviceLocate])

		TriggerServerEvent("garages:deleteVehicle",entity[4],entity[1])

		TriggerEvent("NotifyPush",{ code = 20, title = "Registro de Veículo", x = vehRescue[serviceLocate][spawnCoords][1], y = vehRescue[serviceLocate][spawnCoords][2], z = vehRescue[serviceLocate][spawnCoords][3], name = "Aguardando reboque.", blipColor = 2 })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOWDRIVER:INVOKETOW
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("towdriver:invokeTow")
AddEventHandler("towdriver:invokeTow",function()
	local ped = PlayerPedId()
	local vehicle = GetLastDrivenVehicle()
	if IsVehicleModel(vehicle,GetHashKey("flatbed")) and not IsPedInAnyVehicle(ped) then
		local vehTowed = vRP.nearVehicle(10)

		if DoesEntityExist(vehicle) and DoesEntityExist(vehTowed) then
			local vehCoords01 = GetEntityCoords(vehicle)
			local vehCoords02 = GetEntityCoords(vehTowed)
			local vehDistance = #(vehCoords01 - vehCoords02)

			if vehDistance <= 15 then
				if inTowed then
					TriggerServerEvent("towdriver:ServerTow",VehToNet(vehicle),VehToNet(inTowed),"out")
					vehTower = nil
					inTowed = nil
				else
					if vehicle ~= vehTowed then
						RequestAnimDict("mini@repair")
						while not HasAnimDictLoaded("mini@repair") do
							Citizen.Wait(1)
						end

						vehTower = vehTowed
						LocalPlayer["state"]["Cancel"] = true
						TriggerEvent("sounds:source","tow",0.5)
						TaskTurnPedToFaceEntity(ped,vehTowed,5000)
						LocalPlayer["state"]["Commands"] = true
						TaskPlayAnim(ped,"mini@repair","fixing_a_player",3.0,3.0,-1,50,0,0,0,0)

						Citizen.Wait(4500)

						inTowed = vehTowed
						LocalPlayer["state"]["Cancel"] = false
						LocalPlayer["state"]["Commands"] = false
						StopAnimTask(ped,"mini@repair","fixing_a_player",2.0)
						TriggerServerEvent("towdriver:ServerTow",VehToNet(vehicle),VehToNet(vehTowed),"in")
					end
				end
			else
				TriggerEvent("Notify","amarelo","Reboque precisa estar próximo do veículo.",3000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCTOW
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("towdriver:ClientTow")
AddEventHandler("towdriver:ClientTow",function(veh01,veh02,mode)
	if NetworkDoesNetworkIdExist(veh01) and NetworkDoesNetworkIdExist(veh02) then
		local vehicle = NetToEnt(veh01)
		local vehTowed = NetToEnt(veh02)
		if DoesEntityExist(vehicle) and DoesEntityExist(vehTowed) then
			if mode == "in" then
				local min,max = GetModelDimensions(GetEntityModel(vehTowed))
				AttachEntityToEntity(vehTowed,vehicle,GetEntityBoneIndexByName(vehicle,"bodyshell"),0,-2.2,0.4 - min["z"],0,0,0,1,1,0,1,0,1)
			elseif mode == "out" then
				DetachEntity(vehTowed,false,false)

				local vehHeading = GetEntityHeading(vehicle)
				local vehCoords = GetOffsetFromEntityInWorldCoords(vehicle,0.0,-10.0,0.0)
				SetEntityCoords(vehTowed,vehCoords["x"],vehCoords["y"],vehCoords["z"],1,0,0,0)
				SetEntityHeading(vehTowed,vehHeading)
				SetVehicleOnGroundProperly(vehTowed)
			end
		end
	end
end)