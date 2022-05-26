-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("chest",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKINTPERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkIntPermissions(chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if chestName == "trayShot" or chestName == "trayDesserts" or chestName == "trayPops" or chestName == "trayPizza" then
			return true
		end

		local consultChest = vRP.query("chests/getChests",{ name = chestName })
		if consultChest[1] then
			if (vRP.hasGroup(user_id,consultChest[1]["perm"]) and not exports["hud"]:Wanted(user_id)) or vRP.hasGroup(user_id,"Police") then
				return true
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADESYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.upgradeSystem(chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local consultChest = vRP.query("chests/getChests",{ name = chestName })
		if consultChest[1] then
			local upgradePrice = 50000

			if vRP.hasGroup(user_id,consultChest[1]["perm"]) then
				if vRP.request(source,"Aumentar <b>25Kg</b> por <b>$"..parseFormat(upgradePrice).."</b> dólares?","Comprar") then
					if vRP.paymentFull(user_id,upgradePrice) then
						vRP.execute("chests/upgradeChests",{ name = chestName })
						TriggerClientEvent("Notify",source,"verde","Compra concluída.",3000)
					else
						TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
					end
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.openChest(chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
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
		local result = vRP.getSrvdata("stackChest:"..chestName)
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

		local consultChest = vRP.query("chests/getChests",{ name = chestName })
		if consultChest[1] then
			return myInventory,myChest,vRP.inventoryWeight(user_id),vRP.getWeight(user_id),vRP.chestWeight(result),consultChest[1]["weight"]
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
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.storeItem(nameItem,slot,amount,target,chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if chestName ~= "trayShot" and chestName ~= "trayDesserts" and chestName ~= "trayPops" and chestName ~= "trayPizza" then
			if noStore[nameItem] then
				TriggerClientEvent("chest:Update",source,"requestChest")
				TriggerClientEvent("Notify",source,"amarelo","Armazenamento proibido.",5000)
				return
			end
		end

		local consultChest = vRP.query("chests/getChests",{ name = chestName })
		if consultChest[1] then
			if vRP.storeChest(user_id,"stackChest:"..chestName,amount,consultChest[1]["weight"],slot,target) then
				TriggerClientEvent("chest:Update",source,"requestChest")
			else
				local result = vRP.getSrvdata("stackChest:"..chestName)
				TriggerClientEvent("chest:UpdateWeight",source,vRP.inventoryWeight(user_id),vRP.getWeight(user_id),vRP.chestWeight(result),consultChest[1]["weight"])

				if parseInt(consultChest[1]["logs"]) >= 1 then
					TriggerEvent("discordLogs",chestName,"**Passaporte:** "..parseFormat(user_id).."\n**Guardou:** "..parseFormat(amount).."x "..itemName(nameItem).."\n**Horário:** "..os.date("%H:%M:%S"),3042892)
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.takeItem(nameItem,slot,amount,target,chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local consultChest = vRP.query("chests/getChests",{ name = chestName })
		if consultChest[1] then
			if vRP.tryChest(user_id,"stackChest:"..chestName,amount,slot,target) then
				TriggerClientEvent("chest:Update",source,"requestChest")
			else
				local result = vRP.getSrvdata("stackChest:"..chestName)
				TriggerClientEvent("chest:UpdateWeight",source,vRP.inventoryWeight(user_id),vRP.getWeight(user_id),vRP.chestWeight(result),consultChest[1]["weight"])

				if parseInt(consultChest[1]["logs"]) >= 1 then
					TriggerEvent("discordLogs",chestName,"**Passaporte:** "..parseFormat(user_id).."\n**Retirou:** "..parseFormat(amount).."x "..itemName(nameItem).."\n**Horário:** "..os.date("%H:%M:%S"),9317187)
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATECHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateChest(slot,target,amount,chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.updateChest(user_id,"stackChest:"..chestName,slot,target,amount) then
			TriggerClientEvent("chest:Update",source,"requestChest")
		end
	end
end