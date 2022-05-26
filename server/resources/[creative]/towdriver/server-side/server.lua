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
Tunnel.bindInterface("towdriver",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITENSLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local userList = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLESERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.toggleService()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if userList[user_id] then
			userList[user_id] = nil
		else
			userList[user_id] = source
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOWDRIVER:CALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("towdriver:Call")
AddEventHandler("towdriver:Call",function(source,vehName,vehPlate)
	local ped = GetPlayerPed(source)
	local coords = GetEntityCoords(ped)

	for k,v in pairs(userList) do
		async(function()
			TriggerClientEvent("NotifyPush",v,{ code = 51, title = "Registro de Veículo", x = coords["x"], y = coords["y"], z = coords["z"], vehicle = vehicleName(vehName).." - "..vehPlate, time = "Recebido às "..os.date("%H:%M"), blipColor = 33 })
		end)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTMETHOD
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.paymentMethod()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if (vRP.inventoryWeight(user_id) + 3) <= vRP.getWeight(user_id) then
			vRP.generateItem(user_id,"plastic",math.random(4,6),true)
			vRP.generateItem(user_id,"glass",math.random(4,6),true)
			vRP.generateItem(user_id,"rubber",math.random(4,6),true)
			vRP.generateItem(user_id,"aluminum",math.random(3,5),true)
			vRP.generateItem(user_id,"copper",math.random(3,5),true)
		else
			TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOWDRIVER:SERVERTOW
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("towdriver:ServerTow")
AddEventHandler("towdriver:ServerTow",function(veh01,veh02,mode)
	local source = source
	local activePlayers = vRPC.activePlayers(source)
	for _,v in ipairs(activePlayers) do
		async(function()
			TriggerClientEvent("towdriver:ClientTow",v,veh01,veh02,mode)
		end)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDisconnect",function(user_id)
	if userList[user_id] then
		userList[user_id] = nil
	end
end)