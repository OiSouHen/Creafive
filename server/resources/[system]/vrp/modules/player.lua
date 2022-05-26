-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerConnect",function(user_id,source)
	local dataTable = vRP.getDatatable(user_id)
	if dataTable then
		if dataTable["position"] then
			if dataTable["position"]["x"] == nil or dataTable["position"]["y"] == nil or dataTable["position"]["z"] == nil then
				dataTable["position"] = { x = -25.85, y = -147.48, z = 56.95 }
			end
		else
			dataTable["position"] = { x = -25.85, y = -147.48, z = 56.95 }
		end

		vRP.teleport(source,dataTable["position"]["x"],dataTable["position"]["y"],dataTable["position"]["z"])

		if dataTable["skin"] == nil then
			dataTable["skin"] = GetHashKey("mp_m_freemode_01")
		end

		if dataTable["weight"] == nil then
			dataTable["weight"] = 30
		end

		if dataTable["inventory"] == nil then
			dataTable["inventory"] = {}
		end

		if dataTable["health"] == nil then
			dataTable["health"] = 200
		end

		if dataTable["armour"] == nil then
			dataTable["armour"] = 0
		end

		if dataTable["stress"] == nil then
			dataTable["stress"] = 0
		end

		if dataTable["hunger"] == nil then
			dataTable["hunger"] = 100
		end

		if dataTable["thirst"] == nil then
			dataTable["thirst"] = 100
		end

		if dataTable["oxigen"] == nil then
			dataTable["oxigen"] = 100
		end

		if dataTable["experience"] == nil then
			dataTable["experience"] = 0
		end

		if dataTable["permission"] then
			dataTable["permission"] = nil
		end

		vRPC.applySkin(source,dataTable["skin"])
		vRP.setArmour(source,dataTable["armour"])
		vRPC.setHealth(source,dataTable["health"])

		TriggerClientEvent("hud:Stress",source,dataTable["stress"])
		TriggerClientEvent("hud:Hunger",source,dataTable["hunger"])
		TriggerClientEvent("hud:Thirst",source,dataTable["thirst"])
		TriggerClientEvent("hud:Oxigen",source,dataTable["oxigen"])
		TriggerClientEvent("hud:Exp",source,dataTable["experience"])

		TriggerClientEvent("barbershop:apply",source,vRP.userData(user_id,"Barbershop"))
		TriggerClientEvent("skinshop:apply",source,vRP.userData(user_id,"Clothings"))
		TriggerClientEvent("tattoos:apply",source,vRP.userData(user_id,"Tatuagens"))

		local identity = vRP.userIdentity(user_id)
		if identity then
			TriggerClientEvent("vRP:playerActive",source,user_id,identity["name"].." "..identity["name2"])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETEPEDADMIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("tryDeletePedAdmin")
AddEventHandler("tryDeletePedAdmin",function(entIndex)
	local idNetwork = NetworkGetEntityFromNetworkId(entIndex[1])
	if DoesEntityExist(idNetwork) and not IsPedAPlayer(idNetwork) and GetEntityType(idNetwork) == 1 then
		DeleteEntity(idNetwork)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETEOBJECT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("tryDeleteObject")
AddEventHandler("tryDeleteObject",function(entIndex)
	local idNetwork = NetworkGetEntityFromNetworkId(entIndex)
	if DoesEntityExist(idNetwork) and not IsPedAPlayer(idNetwork) and GetEntityType(idNetwork) == 3 then
		DeleteEntity(idNetwork)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETEPED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("tryDeletePed")
AddEventHandler("tryDeletePed",function(entIndex)
	local idNetwork = NetworkGetEntityFromNetworkId(entIndex)
	if DoesEntityExist(idNetwork) and not IsPedAPlayer(idNetwork) and GetEntityType(idNetwork) == 1 then
		DeleteEntity(idNetwork)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("gg",function(source,args,rawCommand)
	if exports["chat"]:statusChat(source) then
		local user_id = vRP.getUserId(source)
		if user_id and vRPC.checkDeath(source) then
			vRPC.respawnPlayer(source)

			local dataTable = vRP.getDatatable(user_id)
			if dataTable["inventory"] then
				dataTable["inventory"] = {}
				vRP.upgradeThirst(user_id,100)
				vRP.upgradeHunger(user_id,100)
				vRP.downgradeStress(user_id,100)
			end

			TriggerEvent("inventory:clearWeapons",user_id)
			TriggerClientEvent("dynamic:animalFunctions",source,"deletar")
			TriggerEvent("discordLogs","Airport","**Passaporte:** "..parseFormat(user_id).."\n**Horário:** "..os.date("%H:%M:%S"),3092790)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDAGRADETHIRST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.upgradeThirst(user_id,amount)
	local userSource = vRP.userSource(user_id)
	local dataTable = vRP.getDatatable(user_id)
	if dataTable and userSource then
		if dataTable["thirst"] == nil then
			dataTable["thirst"] = 0
		end

		dataTable["thirst"] = dataTable["thirst"] + amount

		if dataTable["thirst"] > 100 then
			dataTable["thirst"] = 100
		end

		TriggerClientEvent("hud:Thirst",userSource,dataTable["thirst"])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADEHUNGER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.upgradeHunger(user_id,amount)
	local userSource = vRP.userSource(user_id)
	local dataTable = vRP.getDatatable(user_id)
	if dataTable and userSource then
		if dataTable["hunger"] == nil then
			dataTable["hunger"] = 0
		end

		dataTable["hunger"] = dataTable["hunger"] + amount

		if dataTable["hunger"] > 100 then
			dataTable["hunger"] = 100
		end

		TriggerClientEvent("hud:Hunger",userSource,dataTable["hunger"])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADESTRESS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.upgradeStress(user_id,amount)
	local userSource = vRP.userSource(user_id)
	local dataTable = vRP.getDatatable(user_id)
	if dataTable and userSource then
		if dataTable["stress"] == nil then
			dataTable["stress"] = 0
		end

		dataTable["stress"] = dataTable["stress"] + amount

		if dataTable["stress"] > 100 then
			dataTable["stress"] = 100
		end

		TriggerClientEvent("hud:Stress",userSource,dataTable["stress"])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOWNGRADETHIRST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.downgradeThirst(user_id,amount)
	local userSource = vRP.userSource(user_id)
	local dataTable = vRP.getDatatable(user_id)
	if dataTable and userSource then
		if dataTable["thirst"] == nil then
			dataTable["thirst"] = 100
		end

		dataTable["thirst"] = dataTable["thirst"] - amount

		if dataTable["thirst"] < 0 then
			dataTable["thirst"] = 0
		end

		TriggerClientEvent("hud:Thirst",userSource,dataTable["thirst"])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOWNGRADEHUNGER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.downgradeHunger(user_id,amount)
	local userSource = vRP.userSource(user_id)
	local dataTable = vRP.getDatatable(user_id)
	if dataTable and userSource then
		if dataTable["hunger"] == nil then
			dataTable["hunger"] = 100
		end

		dataTable["hunger"] = dataTable["hunger"] - amount

		if dataTable["hunger"] < 0 then
			dataTable["hunger"] = 0
		end

		TriggerClientEvent("hud:Hunger",userSource,dataTable["hunger"])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOWNGRADESTRESS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.downgradeStress(user_id,amount)
	local userSource = vRP.userSource(user_id)
	local dataTable = vRP.getDatatable(user_id)
	if dataTable and userSource then
		if dataTable["stress"] == nil then
			dataTable["stress"] = 0
		end

		dataTable["stress"] = dataTable["stress"] - amount

		if dataTable["stress"] < 0 then
			dataTable["stress"] = 0
		end

		TriggerClientEvent("hud:Stress",userSource,dataTable["stress"])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLIENTFOODS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.clientFoods()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local dataTable = vRP.getDatatable(user_id)
		if dataTable then
			if dataTable["thirst"] == nil then
				dataTable["thirst"] = 100
			end

			if dataTable["hunger"] == nil then
				dataTable["hunger"] = 100
			end

			dataTable["hunger"] = dataTable["hunger"] - 1
			dataTable["thirst"] = dataTable["thirst"] - 1

			if dataTable["thirst"] < 0 then
				dataTable["thirst"] = 0
			end

			if dataTable["hunger"] < 0 then
				dataTable["hunger"] = 0
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLIENTOXIGEN
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.clientOxigen()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local dataTable = vRP.getDatatable(user_id)
		if dataTable then
			if dataTable["oxigen"] == nil then
				dataTable["oxigen"] = 100
			end

			dataTable["oxigen"] = dataTable["oxigen"] - 1
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECHARGEOXIGEN
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.rechargeOxigen()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local dataTable = vRP.getDatatable(user_id)
		if dataTable then
			dataTable["oxigen"] = 100
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETHEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getHealth(source)
	local ped = GetPlayerPed(source)
	return GetEntityHealth(ped)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MODELPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.modelPlayer(source)
	local ped = GetPlayerPed(source)
	if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
		return "mp_m_freemode_01"
	elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
		return "mp_f_freemode_01"
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:RECEIVESALARY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("vRP:receiveSalary")
AddEventHandler("vRP:receiveSalary",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local dataTable = vRP.getDatatable(user_id)
		if dataTable then
			if dataTable["salary"] ~= nil then
				TriggerClientEvent("Notify",source,"verde","Recebeu <b>$"..parseFormat(dataTable["salary"]).."</b> em sua conta bancária.",5000)
				vRP.addBank(user_id,dataTable["salary"],"Private")
				dataTable["salary"] = nil
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:UPDATESALARY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("vRP:updateSalary")
AddEventHandler("vRP:updateSalary",function(user_id,amount)
	local dataTable = vRP.getDatatable(user_id)
	if dataTable then
		if dataTable["salary"] ~= nil then
			dataTable["salary"] = dataTable["salary"] + parseInt(amount)
		else
			dataTable["salary"] = parseInt(amount)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:EXPERIENCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("vRP:Experience")
AddEventHandler("vRP:Experience",function(source,user_id,amount)
	local dataTable = vRP.getDatatable(user_id)
	if dataTable then
		if dataTable["experience"] ~= nil then
			dataTable["experience"] = dataTable["experience"] + parseInt(amount)
		else
			dataTable["experience"] = parseInt(amount)
		end

		TriggerClientEvent("hud:Exp",source,dataTable["experience"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETARMOUR
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.setArmour(source,amount)
	local ped = GetPlayerPed(source)
	local armour = GetPedArmour(ped)

	SetPedArmour(ped,parseInt(armour + amount))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.teleport(source,x,y,z)
	local ped = GetPlayerPed(source)
	SetEntityCoords(ped,x + 0.0001,y + 0.0001,z + 0.0001,0,0,0,0)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEOBJECT
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.CreateObject(model,x,y,z)
	local spawnObjects = 0
	local mHash = GetHashKey(model)
	local Object = CreateObject(mHash,x,y,z,true,true,false)

	while not DoesEntityExist(Object) and spawnObjects <= 1000 do
		spawnObjects = spawnObjects + 1
		Citizen.Wait(1)
	end

	if DoesEntityExist(Object) then
		return true,NetworkGetNetworkIdFromEntity(Object)
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEPED
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.CreatePed(model,x,y,z,heading,typ)
	local spawnPeds = 0
	local mHash = GetHashKey(model)
	local Ped = CreatePed(typ,mHash,x,y,z,heading,true,false)

	while not DoesEntityExist(Ped) and spawnPeds <= 1000 do
		spawnPeds = spawnPeds + 1
		Citizen.Wait(1)
	end

	if DoesEntityExist(Ped) then
		return true,NetworkGetNetworkIdFromEntity(Ped)
	end

	return false
end