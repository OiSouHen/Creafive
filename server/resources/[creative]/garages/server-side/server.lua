-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("garages",cRP)
vPLAYER = Tunnel.getInterface("player")
vCLIENT = Tunnel.getInterface("garages")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local vehSpawn = {}
local vehSignal = {}
local searchTimers = {}
GlobalState["vehPlates"] = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVERVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.serverVehicle(model,x,y,z,heading,vehPlate,nitroFuel,vehDoors,vehBody)
	local spawnVehicle = 0
	local mHash = GetHashKey(model)
	local myVeh = CreateVehicle(mHash,x,y,z,heading,true,true)

	while not DoesEntityExist(myVeh) and spawnVehicle <= 1000 do
		spawnVehicle = spawnVehicle + 1
		Citizen.Wait(100)
	end

	if DoesEntityExist(myVeh) then
		if vehPlate ~= nil then
			SetVehicleNumberPlateText(myVeh,vehPlate)
		else
			vehPlate = vRP.generatePlate()
			SetVehicleNumberPlateText(myVeh,vehPlate)
		end

		SetVehicleBodyHealth(myVeh,vehBody + 0.0)

		if vehDoors then
			local vehDoors = json.decode(vehDoors)
			if vehDoors ~= nil then
				for k,v in pairs(vehDoors) do
					if v then
						SetVehicleDoorBroken(myVeh,parseInt(k),true)
					end
				end
			end
		end

		local netVeh = NetworkGetNetworkIdFromEntity(myVeh)

		if model ~= "wheelchair" then
			local idNetwork = NetworkGetEntityFromNetworkId(netVeh)
			SetVehicleDoorsLocked(idNetwork,2)

			local Nitro = GlobalState["Nitro"]
			Nitro[vehPlate] = nitroFuel or 0
			GlobalState["Nitro"] = Nitro
		end

		return true,netVeh,mHash,myVeh
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGELOCATES
-----------------------------------------------------------------------------------------------------------------------------------------
local garageLocates = {
	-- Garages
	["1"] = { name = "Garage", payment = false },
	["2"] = { name = "Garage", payment = true },
	["3"] = { name = "Garage", payment = false },
	["4"] = { name = "Garage", payment = true },
	["5"] = { name = "Garage", payment = true },
	["6"] = { name = "Garage", payment = true },
	["7"] = { name = "Garage", payment = true },
	["8"] = { name = "Garage", payment = true },
	["9"] = { name = "Garage", payment = true },
	["10"] = { name = "Garage", payment = true },
	["11"] = { name = "Garage", payment = true },
	["12"] = { name = "Garage", payment = true },
	["13"] = { name = "Garage", payment = true },
	["14"] = { name = "Garage", payment = true },
	["15"] = { name = "Garage", payment = true },
	["16"] = { name = "Garage", payment = true },
	["17"] = { name = "Garage", payment = true },
	["18"] = { name = "Garage", payment = true },
	["19"] = { name = "Garage", payment = true },
	["20"] = { name = "Garage", payment = true },
	["21"] = { name = "Garage", payment = true },
	["22"] = { name = "Garage", payment = true },
	["23"] = { name = "Garage", payment = false },
	["24"] = { name = "Garage", payment = true },
	["25"] = { name = "Garage", payment = true },

	-- Paramedic
	["41"] = { name = "Paramedic", payment = false, perm = "Paramedic" },
	["42"] = { name = "heliParamedic", payment = false, perm = "Paramedic" },

	["43"] = { name = "Paramedic", payment = false, perm = "Paramedic" },
	["44"] = { name = "heliParamedic", payment = false, perm = "Paramedic" },

	["45"] = { name = "Paramedic", payment = false, perm = "Paramedic" },
	["46"] = { name = "heliParamedic", payment = false, perm = "Paramedic" },

	-- Police
	["61"] = { name = "Police", payment = false, perm = "Police" },
	["62"] = { name = "heliPolice", payment = false, perm = "Police" },

	["63"] = { name = "Police", payment = false, perm = "Police" },
	["64"] = { name = "heliPolice", payment = false, perm = "Police" },

	["65"] = { name = "Police", payment = false, perm = "Police" },
	["66"] = { name = "heliPolice", payment = false, perm = "Police" },

	["67"] = { name = "Police", payment = false, perm = "Police" },
	["68"] = { name = "busPolice", payment = false, perm = "Police" },

	["69"] = { name = "Police", payment = false, perm = "Police" },

	["70"] = { name = "Police", payment = false, perm = "Police" },
	["71"] = { name = "heliPolice", payment = false, perm = "Police" },
	["72"] = { name = "busPolice", payment = false, perm = "Police" },

	-- Bikes
	["101"] = { name = "Bikes", payment = false },
	["102"] = { name = "Bikes", payment = false },
	["103"] = { name = "Bikes", payment = false },
	["104"] = { name = "Bikes", payment = false },
	["105"] = { name = "Bikes", payment = false },
	["106"] = { name = "Bikes", payment = false },
	["107"] = { name = "Bikes", payment = false },
	["108"] = { name = "Bikes", payment = false },
	["109"] = { name = "Bikes", payment = false },
	["110"] = { name = "Bikes", payment = false },
	["111"] = { name = "Bikes", payment = false },
	["112"] = { name = "Bikes", payment = false },
	["113"] = { name = "Bikes", payment = false },
	["114"] = { name = "Bikes", payment = false },
	["115"] = { name = "Bikes", payment = false },
	["116"] = { name = "Bikes", payment = false },
	["117"] = { name = "Bikes", payment = false },
	["118"] = { name = "Bikes", payment = false },

	-- Boats
	["121"] = { name = "Boats", payment = false },
	["122"] = { name = "Boats", payment = false },
	["123"] = { name = "Boats", payment = false },
	["124"] = { name = "Boats", payment = false },
	["125"] = { name = "Boats", payment = false },
	["126"] = { name = "Boats", payment = false },

	-- Works
	["141"] = { name = "Lumberman", payment = false },
	["142"] = { name = "Driver", payment = false },
	["143"] = { name = "Garbageman", payment = false },
	["144"] = { name = "Transporter", payment = false },
	["145"] = { name = "Taxi", payment = false },
	["146"] = { name = "TowDriver", payment = false },
	["147"] = { name = "TowDriver", payment = false },
	["148"] = { name = "TowDriver", payment = false },
	["149"] = { name = "Garbageman", payment = false },
	["150"] = { name = "Garbageman", payment = false },
	["151"] = { name = "Taxi", payment = false },
	["152"] = { name = "TowDriver", payment = false, perm = "Mechanic" },
	["153"] = { name = "Desserts", payment = false, perm = "Desserts" },
	["154"] = { name = "Vinhedo", payment = true, perm = "Vinhedo" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SIGNALREMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("signalRemove")
AddEventHandler("signalRemove",function(vehPlate)
	vehSignal[vehPlate] = true
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATEREVERYONE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("plateReveryone")
AddEventHandler("plateReveryone",function(vehPlate)
	if GlobalState["vehPlates"][vehPlate] then
		local vehPlates = GlobalState["vehPlates"]
		vehPlates[vehPlate] = nil
		GlobalState["vehPlates"] = vehPlates
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATEEVERYONE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("plateEveryone")
AddEventHandler("plateEveryone",function(vehPlate)
	local vehPlates = GlobalState["vehPlates"]
	vehPlates[vehPlate] = true
	GlobalState["vehPlates"] = vehPlates
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATEPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("platePlayers")
AddEventHandler("platePlayers",function(vehPlate,user_id)
	local userPlate = vRP.userPlate(vehPlate)
	if not userPlate then
		local vehPlates = GlobalState["vehPlates"]
		vehPlates[vehPlate] = user_id
		GlobalState["vehPlates"] = vehPlates
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATEROBBERYS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("plateRobberys")
AddEventHandler("plateRobberys",function(vehPlate,vehName)
	if vehPlate ~= nil and vehName ~= nil then
		local source = source
		local user_id = vRP.getUserId(source)
		if user_id then
			if GlobalState["vehPlates"][vehPlate] ~= user_id then
				local vehPlates = GlobalState["vehPlates"]
				vehPlates[vehPlate] = user_id
				GlobalState["vehPlates"] = vehPlates
			end

			vRP.generateItem(user_id,"vehkey-"..vehPlate,1,true,false)

			if math.random(100) >= 50 then
				local ped = GetPlayerPed(source)
				local coords = GetEntityCoords(ped)

				local policeResult = vRP.numPermission("Police")
				for k,v in pairs(policeResult) do
					async(function()
						TriggerClientEvent("NotifyPush",v,{ code = 31, title = "Roubo de Veículo", x = coords["x"], y = coords["y"], z = coords["z"], vehicle = vehicleName(vehName).." - "..vehPlate, time = "Recebido às "..os.date("%H:%M"), blipColor = 44 })
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WORKGARAGES
-----------------------------------------------------------------------------------------------------------------------------------------
local workGarages = {
	["Paramedic"] = {
		"lguard",
		"blazer2",
		"ambulance",
		"ambulance2"
	},
	["heliParamedic"] = {
		"maverick2",
		"firetruk"
	},
	["Police"] = {
		"bmwr1200",
		"hondanc700",
		"fordtaurus",
		"fordexplorer",
		"corvette",
		"challenger",
		"fordmustanggt",
		"crownvictoria",
		"dodgecharger2014"
	},
	["heliPolice"] = {
		"maverick2"
	},
	["busPolice"] = {
		"pbus",
		"riot"
	},
	["Driver"] = {
		"bus"
	},
	["Boats"] = {
		"dinghy",
		"jetmax",
		"marquis",
		"seashark",
		"speeder",
		"squalo",
		"suntrap",
		"toro",
		"tropic"
	},
	["Transporter"] = {
		"stockade"
	},
	["Lumberman"] = {
		"ratloader"
	},
	["TowDriver"] = {
		"flatbed",
		"towtruck2"
	},
	["Garbageman"] = {
		"trash"
	},
	["Taxi"] = {
		"taxi"
	},
	["Desserts"] = {
		"youga2"
	},
	["Bikes"] = {
		"bmx",
		"cruiser",
		"fixter",
		"scorcher",
		"tribike",
		"tribike2",
		"tribike3"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.Vehicles(Garage)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and not exports["hud"]:Wanted(user_id) then
		if vRP.getFines(user_id) > 0 then
			TriggerClientEvent("Notify",source,"vermelho","Multas pendentes encontradas.",3000)
			return false
		end

		local garageName = garageLocates[Garage]["name"]
		if string.sub(garageName,0,5) == "Homes" then
			local consult = vRP.query("propertys/userPermissions",{ name = garageName, user_id = user_id })
			if consult[1] == nil then
				return false
			else
				local ownerConsult = vRP.query("propertys/userOwnermissions",{ name = garageName })
				if ownerConsult[1] then
					if ownerConsult[1]["tax"] <= os.time() then
						TriggerClientEvent("Notify",source,"amarelo","Taxa da propriedade atrasada.",10000)
						return false
					end
				end
			end
		end

		if garageLocates[Garage]["perm"] then
			if not vRP.hasGroup(user_id,garageLocates[Garage]["perm"]) then
				return false
			end
		end

		local Vehicle = {}
		if workGarages[garageName] then
			for k,v in pairs(workGarages[garageName]) do
				table.insert(Vehicle,{ ["model"] = v, ["name"] = vehicleName(v) })
			end
		else
			local vehicle = vRP.query("vehicles/getVehicles",{ user_id = user_id })
			for k,v in ipairs(vehicle) do
				if v["work"] == "false" then
					table.insert(Vehicle,{ ["model"] = vehicle[k]["vehicle"], ["name"] = vehicleName(vehicle[k]["vehicle"]) })
				end
			end
		end

		return Vehicle
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- IMPOUND
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.Impound()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local myVehicle = {}
		local vehicle = vRP.query("vehicles/getVehicles",{ user_id = user_id })

		for k,v in ipairs(vehicle) do
			if v["arrest"] >= os.time() then
				table.insert(myVehicle,{ ["model"] = vehicle[k]["vehicle"], ["name"] = vehicleName(vehicle[k]["vehicle"]) })
			end
		end

		return myVehicle
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:IMPOUND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Impound")
AddEventHandler("garages:Impound",function(vehName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehPrice = vehiclePrice(vehName)
		TriggerClientEvent("dynamic:closeSystem",source)

		if vRP.request(source,"A liberação do veículo tem o custo de <b>$"..parseFormat(vehPrice * 0.25).."</b> dólares, deseja prosseguir com a liberação do mesmo?","Sim","Não") then
			if vRP.paymentFull(user_id,vehPrice * 0.25) then
				vRP.execute("vehicles/paymentArrest",{ user_id = user_id, vehicle = vehName })
				TriggerClientEvent("Notify",source,"verde","Veículo liberado.",5000)
			else
				TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:SPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Spawn")
AddEventHandler("garages:Spawn",function(Table)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local splitName = splitString(Table,"-")
		local garageName = splitName[2]
		local vehName = splitName[1]

		local vehicle = vRP.query("vehicles/selectVehicles",{ user_id = user_id, vehicle = vehName })
		if vehicle[1] == nil then
			vRP.execute("vehicles/addVehicles",{ user_id = user_id, vehicle = vehName, plate = vRP.generatePlate(), work = "true" })
			TriggerClientEvent("Notify",source,"verde","Veículo adicionado em sua lista de veículos.",5000)
		else
			local vehPlates = GlobalState["vehPlates"]
			local vehPlate = vehicle[1]["plate"]

			if vehSpawn[vehPlate] then
				if vehSignal[vehPlate] == nil then
					if searchTimers[user_id] == nil then
						searchTimers[user_id] = os.time()
					end

					if os.time() >= parseInt(searchTimers[user_id]) then
						searchTimers[user_id] = os.time() + 60

						local vehNet = vehSpawn[vehPlate][3]
						local idNetwork = NetworkGetEntityFromNetworkId(vehNet)
						if DoesEntityExist(idNetwork) and not IsPedAPlayer(idNetwork) and GetEntityType(idNetwork) == 2 then
							vCLIENT.searchBlip(source,GetEntityCoords(idNetwork))
							TriggerClientEvent("Notify",source,"amarelo","Rastreador do veículo foi ativado por <b>30 segundos</b>, lembrando que se o mesmo estiver em movimento a localização pode ser imprecisa.",10000)
						else
							if vehSpawn[vehPlate] then
								vehSpawn[vehPlate] = nil
							end

							if vehPlates[vehPlate] then
								vehPlates[vehPlate] = nil
								GlobalState["vehPlates"] = vehPlates
							end

							TriggerClientEvent("Notify",source,"verde","A seguradora efetuou o resgate do seu veículo e o mesmo já se encontra disponível para retirada.",5000)
						end
					else
						TriggerClientEvent("Notify",source,"amarelo","Rastreador só pode ser ativado a cada <b>60 segundos</b>.",5000)
					end
				else
					TriggerClientEvent("Notify",source,"amarelo","Rastreador está desativado.",5000)
				end
			else
				if vehicle[1]["tax"] <= os.time() then
					TriggerClientEvent("Notify",source,"amarelo","Taxa do veículo atrasada, efetue o pagamento<br>através do sistema da concessionária.",5000)
				elseif vehicle[1]["arrest"] >= os.time() then
					TriggerClientEvent("Notify",source,"amarelo","Veículo apreendido, dirija-se até o <b>Impound</b> e efetue o pagamento da liberação do mesmo.",5000)
				else
					if vehicle[1]["rental"] ~= 0 then
						if vehicle[1]["rental"] <= os.time() then
							TriggerClientEvent("Notify",source,"amarelo","Validade do veículo expirou, efetue a renovação do mesmo.",5000)
							return
						end
					end

					local Coords = vCLIENT.spawnPosition(source,garageName)
					if Coords then
						local vehMods = nil
						local custom = vRP.query("entitydata/getData",{ dkey = "custom:"..user_id..":"..vehName })
						if parseInt(#custom) > 0 then
							vehMods = custom[1]["dvalue"]
						end

						if garageLocates[garageName]["payment"] then
							if vRP.userPremium(user_id) then
								TriggerClientEvent("dynamic:closeSystem",source)
								local netExist,netVeh,mHash = cRP.serverVehicle(vehName,Coords[1],Coords[2],Coords[3],Coords[4],vehPlate,vehicle[1]["nitro"],vehicle[1]["doors"],vehicle[1]["body"])

								if netExist then
									vCLIENT.createVehicle(-1,mHash,netVeh,vehicle[1]["engine"],vehMods,vehicle[1]["windows"],vehicle[1]["tyres"])
									TriggerEvent("engine:tryFuel",vehPlate,vehicle[1]["fuel"])
									vehSpawn[vehPlate] = { user_id,vehName,netVeh }

									vehPlates[vehPlate] = user_id
									GlobalState["vehPlates"] = vehPlates
								end
							else
								local vehPrice = vehiclePrice(vehName)
								if vRP.request(source,"Retirar o veículo por <b>$"..parseFormat(vehPrice * 0.05).."</b> dólares?") then
									if vRP.getBank(user_id) >= parseInt(vehPrice * 0.05) then
										TriggerClientEvent("dynamic:closeSystem",source)
										local netExist,netVeh,mHash = cRP.serverVehicle(vehName,Coords[1],Coords[2],Coords[3],Coords[4],vehPlate,vehicle[1]["nitro"],vehicle[1]["doors"],vehicle[1]["body"])

										if netExist then
											vCLIENT.createVehicle(-1,mHash,netVeh,vehicle[1]["engine"],vehMods,vehicle[1]["windows"],vehicle[1]["tyres"])
											TriggerEvent("engine:tryFuel",vehPlate,vehicle[1]["fuel"])
											vehSpawn[vehPlate] = { user_id,vehName,netVeh }

											vehPlates[vehPlate] = user_id
											GlobalState["vehPlates"] = vehPlates
										end
									else
										TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
									end
								end
							end
						else
							TriggerClientEvent("dynamic:closeSystem",source)
							local netExist,netVeh,mHash = cRP.serverVehicle(vehName,Coords[1],Coords[2],Coords[3],Coords[4],vehPlate,vehicle[1]["nitro"],vehicle[1]["doors"],vehicle[1]["body"])

							if netExist then
								vCLIENT.createVehicle(-1,mHash,netVeh,vehicle[1]["engine"],vehMods,vehicle[1]["windows"],vehicle[1]["tyres"])
								TriggerEvent("engine:tryFuel",vehPlate,vehicle[1]["fuel"])
								vehSpawn[vehPlate] = { user_id,vehName,netVeh }

								vehPlates[vehPlate] = user_id
								GlobalState["vehPlates"] = vehPlates
							end
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("car",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") and vehicleExist(args[1]) then
			local ped = GetPlayerPed(source)
			local coords = GetEntityCoords(ped)
			local heading = GetEntityHeading(ped)
			local vehPlate = "VEH"..math.random(10000,99999)
			local netExist,netVeh,mHash,myVeh = cRP.serverVehicle(args[1],coords["x"],coords["y"],coords["z"],heading,vehPlate,200,nil,1000)

			if not netExist then
				return
			end

			vCLIENT.createVehicle(-1,mHash,netVeh,1000,nil,false,false)
			vehSpawn[vehPlate] = { user_id,vehName,netVeh }
			TriggerEvent("engine:tryFuel",vehPlate,100)
			SetPedIntoVehicle(ped,myVeh,-1)

			local vehPlates = GlobalState["vehPlates"]
			vehPlates[vehPlate] = user_id
			GlobalState["vehPlates"] = vehPlates
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("dv",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Moderator") then
			TriggerClientEvent("garages:Delete",source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:VEHICLEKEY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garages:vehicleKey")
AddEventHandler("garages:vehicleKey",function(entity)
	local source = source
	local vehPlate = entity[1]
	local user_id = vRP.getUserId(source)
	if user_id then
		if GlobalState["vehPlates"][vehPlate] == user_id then
			vRP.generateItem(user_id,"vehkey-"..vehPlate,1,true,false)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:LOCKVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:lockVehicle")
AddEventHandler("garages:lockVehicle",function(vehNet,vehPlate)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if GlobalState["vehPlates"][vehPlate] == user_id then
			TriggerEvent("garages:keyVehicle",source,vehNet)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:KEYVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:keyVehicle")
AddEventHandler("garages:keyVehicle",function(source,vehNet)
	local idNetwork = NetworkGetEntityFromNetworkId(vehNet)
	local doorStatus = GetVehicleDoorLockStatus(idNetwork)

	if parseInt(doorStatus) <= 1 then
		TriggerClientEvent("Notify",source,"locked","Veículo trancado.",5000)
		TriggerClientEvent("sounds:source",source,"locked",0.4)
		SetVehicleDoorsLocked(idNetwork,2)
	else
		TriggerClientEvent("Notify",source,"unlocked","Veículo destrancado.",5000)
		TriggerClientEvent("sounds:source",source,"unlocked",0.4)
		SetVehicleDoorsLocked(idNetwork,1)
	end

	if not vRPC.inVehicle(source) then
		vRPC.playAnim(source,true,{"anim@mp_player_intmenu@key_fob@","fob_click"},false)
		Citizen.Wait(400)
		vRPC.stopAnim(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.tryDelete(vehNet,vehEngine,vehBody,vehFuel,vehDoors,vehWindows,vehTyres,vehPlate)
	if vehSpawn[vehPlate] then
		local user_id = vehSpawn[vehPlate][1]
		local vehName = vehSpawn[vehPlate][2]

		if parseInt(vehEngine) <= 100 then
			vehEngine = 100
		end

		if parseInt(vehBody) <= 100 then
			vehBody = 100
		end

		if parseInt(vehFuel) >= 100 then
			vehFuel = 100
		end

		if parseInt(vehFuel) <= 0 then
			vehFuel = 0
		end

		local vehicle = vRP.query("vehicles/selectVehicles",{ user_id = user_id, vehicle = vehName })
		if vehicle[1] ~= nil then
			vRP.execute("vehicles/updateVehicles",{ user_id = user_id, vehicle = vehName, nitro = GlobalState["Nitro"][vehPlate] or 0, engine = parseInt(vehEngine), body = parseInt(vehBody), fuel = parseInt(vehFuel), doors = json.encode(vehDoors), windows = json.encode(vehWindows), tyres = json.encode(vehTyres) })
		end
	end

	TriggerEvent("garages:deleteVehicle",vehNet,vehPlate)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:DELETEVEHICLEADMIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:deleteVehicleAdmin")
AddEventHandler("garages:deleteVehicleAdmin",function(entity)
	TriggerEvent("garages:deleteVehicle",entity[1],entity[2])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:DELETEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:deleteVehicle")
AddEventHandler("garages:deleteVehicle",function(vehNet,vehPlate)
	if GlobalState["vehPlates"][vehPlate] then
		local vehPlates = GlobalState["vehPlates"]
		vehPlates[vehPlate] = nil
		GlobalState["vehPlates"] = vehPlates
	end

	if GlobalState["Nitro"][vehPlate] then
		local Nitro = GlobalState["Nitro"]
		Nitro[vehPlate] = nil
		GlobalState["Nitro"] = Nitro
	end

	if vehSignal[vehPlate] then
		vehSignal[vehPlate] = nil
	end

	if vehSpawn[vehPlate] then
		vehSpawn[vehPlate] = nil
	end

	local idNetwork = NetworkGetEntityFromNetworkId(vehNet)
	if DoesEntityExist(idNetwork) and not IsPedAPlayer(idNetwork) and GetEntityType(idNetwork) == 2 then
		if GetVehicleNumberPlateText(idNetwork) == vehPlate then
			DeleteEntity(idNetwork)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:UPDATEGARAGES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:updateGarages")
AddEventHandler("garages:updateGarages",function(homeName,homeInfos)
	garageLocates[homeName] = { ["name"] = homeName, ["payment"] = false }

	-- CONFIG
	local configFile = LoadResourceFile("logsystem","garageConfig.json")
	local configTable = json.decode(configFile)
	configTable[homeName] = { ["name"] = homeName, ["payment"] = false }
	SaveResourceFile("logsystem","garageConfig.json",json.encode(configTable),-1)

	-- LOCATES
	local locatesFile = LoadResourceFile("logsystem","garageLocates.json")
	local locatesTable = json.decode(locatesFile)
	locatesTable[homeName] = homeInfos
	SaveResourceFile("logsystem","garageLocates.json",json.encode(locatesTable),-1)

	TriggerClientEvent("garages:updateLocs",-1,homeName,homeInfos)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:REMOVEGARAGES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:removeGarages")
AddEventHandler("garages:removeGarages",function(homeName)
	if garageLocates[homeName] then
		garageLocates[homeName] = nil

		local configFile = LoadResourceFile("logsystem","garageConfig.json")
		local configTable = json.decode(configFile)
		if configTable[homeName] then
			configTable[homeName] = nil
			SaveResourceFile("logsystem","garageConfig.json",json.encode(configTable),-1)
		end

		local locatesFile = LoadResourceFile("logsystem","garageLocates.json")
		local locatesTable = json.decode(locatesFile)
		if locatesTable[homeName] then
			locatesTable[homeName] = nil
			SaveResourceFile("logsystem","garageLocates.json",json.encode(locatesTable),-1)
		end

		TriggerClientEvent("garages:updateRemove",-1,homeName)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ASYNCFUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local configFile = LoadResourceFile("logsystem","garageConfig.json")
	local configTable = json.decode(configFile)

	for k,v in pairs(configTable) do
		garageLocates[k] = v
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerConnect",function(user_id,source)
	local locatesFile = LoadResourceFile("logsystem","garageLocates.json")
	local locatesTable = json.decode(locatesFile)

	TriggerClientEvent("garages:allLocs",source,locatesTable)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDisconnect",function(user_id)
	if searchTimers[user_id] then
		searchTimers[user_id] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHSIGNAL
-----------------------------------------------------------------------------------------------------------------------------------------
exports("vehSignal",function(vehPlate)
	return vehSignal[vehPlate]
end)