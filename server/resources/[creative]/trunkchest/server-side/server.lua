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
Tunnel.bindInterface("trunkchest",cRP)
vCLIENT = Tunnel.getInterface("trunkchest")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local vehChest = {}
local vehNames = {}
local vehWeight = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.openChest()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehicle,vehNet,vehPlate,vehName = vRPC.vehList(source,3)
		if vehicle then
			local userPlate = vRP.userPlate(vehPlate)
			if userPlate then
				if vRPC.inVehicle(source) then
					vehWeight[user_id] = 7
					vehChest[user_id] = "vehGloves:"..userPlate["user_id"]..":"..vehName
				else
					vehWeight[user_id] = parseInt(vehicleChest(vehName))
					vehChest[user_id] = "vehChest:"..userPlate["user_id"]..":"..vehName
				end

				vehNames[user_id] = vehName

				local myInventory = {}
				local inventory = vRP.userInventory(user_id)
				for k,v in pairs(inventory) do
					v["amount"] = parseInt(v["amount"])
					v["name"] = itemName(v["item"])
					v["peso"] = itemWeight(v["item"])
					v["index"] = itemIndex(v["item"])
					v["max"] = itemMaxAmount(v["item"])
					v["type"] = itemType(v["item"])
					v["desc"] = itemDescription(v["item"])
					v["key"] = v["item"]
					v["slot"] = k
		
					local splitName = splitString(v["item"],"-")
					if splitName[2] ~= nil then
						if itemDurability(v["item"]) then
							v["durability"] = parseInt(os.time() - splitName[2])
							v["days"] = itemDurability(v["item"])
						else
							v["durability"] = 0
							v["days"] = 1
						end
					else
						v["durability"] = 0
						v["days"] = 1
					end

					myInventory[k] = v
				end

				local myChest = {}
				local result = vRP.getSrvdata(vehChest[user_id])
				for k,v in pairs(result) do
					v["amount"] = parseInt(v["amount"])
					v["name"] = itemName(v["item"])
					v["peso"] = itemWeight(v["item"])
					v["index"] = itemIndex(v["item"])
					v["max"] = itemMaxAmount(v["item"])
					v["type"] = itemType(v["item"])
					v["desc"] = itemDescription(v["item"])
					v["key"] = v["item"]
					v["slot"] = k
		
					local splitName = splitString(v["item"],"-")
					if splitName[2] ~= nil then
						if itemDurability(v["item"]) then
							v["durability"] = parseInt(os.time() - splitName[2])
							v["days"] = itemDurability(v["item"])
						else
							v["durability"] = 0
							v["days"] = 1
						end
					else
						v["durability"] = 0
						v["days"] = 1
					end

					myChest[k] = v
				end

				return myInventory,myChest,vRP.inventoryWeight(user_id),vRP.getWeight(user_id),vRP.chestWeight(result),parseInt(vehWeight[user_id])
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOSTORE
-----------------------------------------------------------------------------------------------------------------------------------------
local noStore = {
	["cheese"] = true,
	["foodburger"] = true,
	["foodjuice"] = true,
	["foodbox"] = true,
	["octopus"] = true,
	["shrimp"] = true,
	["carp"] = true,
	["codfish"] = true,
	["catfish"] = true,
	["goldenfish"] = true,
	["horsefish"] = true,
	["tilapia"] = true,
	["pacu"] = true,
	["pirarucu"] = true,
	["tambaqui"] = true,
	["energetic"] = true,
	["milkbottle"] = true,
	["water"] = true,
	["coffee"] = true,
	["cola"] = true,
	["tacos"] = true,
	["fries"] = true,
	["soda"] = true,
	["orange"] = true,
	["apple"] = true,
	["strawberry"] = true,
	["coffee2"] = true,
	["grape"] = true,
	["tange"] = true,
	["banana"] = true,
	["passion"] = true,
	["tomato"] = true,
	["mushroom"] = true,
	["orangejuice"] = true,
	["tangejuice"] = true,
	["grapejuice"] = true,
	["strawberryjuice"] = true,
	["bananajuice"] = true,
	["passionjuice"] = true,
	["bread"] = true,
	["ketchup"] = true,
	["cannedsoup"] = true,
	["canofbeans"] = true,
	["meat"] = true,
	["fishfillet"] = true,
	["marshmallow"] = true,
	["cookedfishfillet"] = true,
	["cookedmeat"] = true,
	["hamburger"] = true,
	["hamburger2"] = true,
	["pizza"] = true,
	["pizza2"] = true,
	["hotdog"] = true,
	["donut"] = true,
	["chocolate"] = true,
	["sandwich"] = true,
	["absolut"] = true,
	["chandon"] = true,
	["dewars"] = true,
	["hennessy"] = true,
	["nigirizushi"] = true,
	["sushi"] = true,
	["cupcake"] = true,
	["milkshake"] = true,
	["cappuccino"] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREVEHS
-----------------------------------------------------------------------------------------------------------------------------------------
local storeVehs = {
	["ratloader"] = {
		["woodlog"] = true
	},
	["stockade"] = {
		["pouch"] = true
	},
	["trash"] = {
		["glassbottle"] = true,
		["plasticbottle"] = true,
		["elastic"] = true,
		["metalcan"] = true,
		["battery"] = true
	},
	["taco"] = {
		["cheese"] = true,
		["foodburger"] = true,
		["foodjuice"] = true,
		["foodbox"] = true,
		["octopus"] = true,
		["shrimp"] = true,
		["carp"] = true,
		["codfish"] = true,
		["catfish"] = true,
		["goldenfish"] = true,
		["horsefish"] = true,
		["tilapia"] = true,
		["pacu"] = true,
		["pirarucu"] = true,
		["tambaqui"] = true,
		["energetic"] = true,
		["milkbottle"] = true,
		["water"] = true,
		["coffee"] = true,
		["cola"] = true,
		["tacos"] = true,
		["fries"] = true,
		["soda"] = true,
		["orange"] = true,
		["apple"] = true,
		["strawberry"] = true,
		["coffee2"] = true,
		["grape"] = true,
		["tange"] = true,
		["banana"] = true,
		["passion"] = true,
		["tomato"] = true,
		["mushroom"] = true,
		["orangejuice"] = true,
		["tangejuice"] = true,
		["grapejuice"] = true,
		["strawberryjuice"] = true,
		["bananajuice"] = true,
		["passionjuice"] = true,
		["bread"] = true,
		["ketchup"] = true,
		["cannedsoup"] = true,
		["canofbeans"] = true,
		["meat"] = true,
		["fishfillet"] = true,
		["marshmallow"] = true,
		["cookedfishfillet"] = true,
		["cookedmeat"] = true,
		["hamburger"] = true,
		["hamburger2"] = true,
		["pizza"] = true,
		["pizza2"] = true,
		["hotdog"] = true,
		["donut"] = true,
		["chocolate"] = true,
		["sandwich"] = true,
		["absolut"] = true,
		["chandon"] = true,
		["dewars"] = true,
		["hennessy"] = true,
		["nigirizushi"] = true,
		["sushi"] = true,
		["cupcake"] = true,
		["milkshake"] = true,
		["cappuccino"] = true
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateChest(slot,target,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.updateChest(user_id,vehChest[user_id],slot,target,amount) then
			TriggerClientEvent("trunkchest:Update",source,"requestChest")
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.storeItem(nameItem,slot,amount,target)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehName = vehNames[user_id]

		if storeVehs[vehName] then
			if not storeVehs[vehName][nameItem] then
				TriggerClientEvent("trunkchest:Update",source,"requestChest")
				TriggerClientEvent("Notify",source,"amarelo","Armazenamento proibido.",5000)
				return
			end
		end

		if (vehName == "mule" or vehName == "benson" or vehName == "pounder" or vehName == "youga2") then
			if nameItem == "dollars" then
				TriggerClientEvent("trunkchest:Update",source,"requestChest")
				TriggerClientEvent("Notify",source,"amarelo","Armazenamento proibido.",5000)
				return
			end
		else
			if noStore[nameItem] and not storeVehs[vehName] then
				TriggerClientEvent("trunkchest:Update",source,"requestChest")
				TriggerClientEvent("Notify",source,"amarelo","Armazenamento proibido.",5000)
				return
			end
		end

		if vRP.storeChest(user_id,vehChest[user_id],amount,parseInt(vehWeight[user_id]),slot,target) then
			TriggerClientEvent("trunkchest:Update",source,"requestChest")
		else
			local result = vRP.getSrvdata(vehChest[user_id])
			TriggerClientEvent("trunkchest:UpdateWeight",source,vRP.inventoryWeight(user_id),vRP.getWeight(user_id),vRP.chestWeight(result),parseInt(vehWeight[user_id]))
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.takeItem(slot,amount,target)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.tryChest(user_id,vehChest[user_id],amount,slot,target) then
			TriggerClientEvent("trunkchest:Update",source,"requestChest")
		else
			local result = vRP.getSrvdata(vehChest[user_id])
			TriggerClientEvent("trunkchest:UpdateWeight",source,vRP.inventoryWeight(user_id),vRP.getWeight(user_id),vRP.chestWeight(result),parseInt(vehWeight[user_id]))
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.chestClose()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehicle,vehNet = vRPC.vehList(source,3)
		if vehicle then
			if not vRPC.inVehicle(source) then
				local activePlayers = vRPC.activePlayers(source)
				for _,v in ipairs(activePlayers) do
					async(function()
						TriggerClientEvent("player:syncDoorsOptions",v,vehNet,"close")
					end)
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNKCHEST:OPENTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("trunkchest:openTrunk")
AddEventHandler("trunkchest:openTrunk",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehicle,vehNet,vehPlate,vehName,vehBlock,vehHealth = vRPC.vehList(source,3)
		if vehicle then
			local idNetwork = NetworkGetEntityFromNetworkId(vehNet)
			local doorStatus = GetVehicleDoorLockStatus(idNetwork)
		
			if parseInt(doorStatus) <= 1 then
				if not vehBlock and parseInt(vehHealth) > 0 then
					if vRP.userPlate(vehPlate) then
						if not vRPC.inVehicle(source) then
							local activePlayers = vRPC.activePlayers(source)
							for _,v in ipairs(activePlayers) do
								async(function()
									TriggerClientEvent("player:syncDoorsOptions",v,vehNet,"open")
								end)
							end
						end

						vCLIENT.trunkOpen(source)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDisconnect",function(user_id)
	if vehNames[user_id] then
		vehNames[user_id] = nil
	end

	if vehChest[user_id] then
		vehChest[user_id] = nil
	end

	if vehWeight[user_id] then
		vehWeight[user_id] = nil
	end
end)