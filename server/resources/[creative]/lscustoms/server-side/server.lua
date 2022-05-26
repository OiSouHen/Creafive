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
Tunnel.bindInterface("lscustoms",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkPermission(hasPerm)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getFines(user_id) > 0 then
			TriggerClientEvent("Notify",source,"amarelo","Multas pendentes encontradas.",3000)
			return false
		end

		if exports["hud"]:Wanted(user_id,source) then
			return false
		end

		if not hasPerm then
			return true
		else
			if vRP.hasGroup(user_id,hasPerm) then
				return true
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("lscustoms:attemptPurchase")
AddEventHandler("lscustoms:attemptPurchase",function(type,mod)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if type == "engines" or type == "brakes" or type == "transmission" or type == "suspension" or type == "shield" then
			if vRP.paymentFull(user_id,parseInt(vehicleCustomisationPrices[type][mod])) then
				TriggerClientEvent("lscustoms:purchaseSuccessful",source)
			else
				TriggerClientEvent("lscustoms:purchaseFailed",source)
			end
		else
			if vRP.paymentFull(user_id,parseInt(vehicleCustomisationPrices[type])) then
				TriggerClientEvent("lscustoms:purchaseSuccessful",source)
			else
				TriggerClientEvent("lscustoms:purchaseFailed",source)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("lscustoms:updateVehicle")
AddEventHandler("lscustoms:updateVehicle",function(mods,vehPlate,vehName)
	local userPlate = vRP.userPlate(vehPlate)
	if userPlate then
		vRP.execute("entitydata/setData",{ dkey = "custom:"..userPlate["user_id"]..":"..vehName, value = json.encode(mods) })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
local inVehicle = {}
RegisterServerEvent("lscustoms:inVehicle")
AddEventHandler("lscustoms:inVehicle",function(vehNet,vehPlate)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vehNet == nil then
			if inVehicle[user_id] then
				inVehicle[user_id] = nil
			end
		else
			inVehicle[user_id] = { vehNet,vehPlate }
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDisconnect",function(user_id)
	if inVehicle[user_id] then
		Citizen.Wait(1000)
		TriggerEvent("garages:deleteVehicle",inVehicle[user_id][1],inVehicle[user_id][2])
		inVehicle[user_id] = nil
	end
end)