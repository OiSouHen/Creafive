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
Tunnel.bindInterface("engine",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local vehFuels = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTFUEL
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.paymentFuel(fuelPrice,vehPlate,vehFuel)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local gasPrice = parseInt(fuelPrice)
		if vRP.paymentFull(user_id,gasPrice) then
			local activePlayers = vRPC.activePlayers(source)
			for _,v in ipairs(activePlayers) do
				async(function()
					TriggerClientEvent("engine:syncFuel",v,vehPlate,vehFuel)
				end)
			end

			return true
		else
			TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
			return false
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEFUEL
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.vehicleFuel(vehPlate)
	if vehFuels[vehPlate] == nil and vehPlate ~= nil then
		vehFuels[vehPlate] = 50
	end

	return vehFuels[vehPlate]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYFUEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("engine:tryFuel")
AddEventHandler("engine:tryFuel",function(vehPlate,vehFuel)
	vehFuels[vehPlate] = vehFuel
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETFUEL
-----------------------------------------------------------------------------------------------------------------------------------------
exports("engineFuel",function(vehPlate)
	if vehFuels[vehPlate] == nil then
		vehFuels[vehPlate] = 50
	end

	return vehFuels[vehPlate]
end)