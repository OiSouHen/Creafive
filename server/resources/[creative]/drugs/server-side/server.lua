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
Tunnel.bindInterface("drugs",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local userAmount = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local itemList = {
	{ item = "lean", priceMin = 45, priceMax = 60, randMin = 2, randMax = 5 },
	{ item = "ecstasy", priceMin = 45, priceMax = 60, randMin = 2, randMax = 5 },
	{ item = "cocaine", priceMin = 45, priceMax = 60, randMin = 2, randMax = 5 },
	{ item = "meth", priceMin = 45, priceMax = 60, randMin = 2, randMax = 5 },
	{ item = "joint", priceMin = 45, priceMax = 60, randMin = 2, randMax = 5 },
	{ item = "oxy", priceMin = 55, priceMax = 65, randMin = 1, randMax = 3 },
	{ item = "heroine", priceMin = 100, priceMax = 125, randMin = 1, randMax = 1 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKAMOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkAmount()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(itemList) do
			local randAmount = math.random(v["randMin"],v["randMax"])
			local randPrice = math.random(v["priceMin"],v["priceMax"])
			local consultItem = vRP.getInventoryItemAmount(user_id,v["item"])
			if consultItem[1] >= parseInt(randAmount) then
				userAmount[user_id] = { v["item"],randAmount,randPrice * randAmount }

				return true
			end
		end

		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTMETHOD
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.paymentMethod(gridAmount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.tryGetInventoryItem(user_id,userAmount[user_id][1],userAmount[user_id][2],true) then
			vRP.upgradeStress(user_id,3)
			TriggerClientEvent("player:applyGsr",source)
			vRP.generateItem(user_id,"dollars",userAmount[user_id][3],true)

			if parseInt(gridAmount) >= 5 then
				local ped = GetPlayerPed(source)
				local coords = GetEntityCoords(ped)
				local policeResult = vRP.numPermission("Police")

				for k,v in pairs(policeResult) do
					async(function()
						vRPC.playSound(v,"ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET")
						TriggerClientEvent("NotifyPush",v,{ code = 20, title = "Venda de Drogas", x = coords["x"], y = coords["y"], z = coords["z"], criminal = "Ligação Anônima", time = "Recebido às "..os.date("%H:%M"), blipColor = 16 })
					end)
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDisconnect",function(user_id)
	if userAmount[user_id] then
		userAmount[user_id] = nil
	end
end)