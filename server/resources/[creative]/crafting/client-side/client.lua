-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("crafting")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("invClose",function()
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideNUI" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTCRAFTING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestCrafting",function(data,cb)
	local inventoryCraft,inventoryUser,invPeso,invMaxpeso = vSERVER.requestCrafting(data["craft"])
	if inventoryCraft then
		cb({ inventoryCraft = inventoryCraft, inventario = inventoryUser, invPeso = invPeso, invMaxpeso = invMaxpeso })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONCRAFT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("functionCraft",function(data)
	if MumbleIsConnected() then
		vSERVER.functionCrafting(data["index"],data["craft"],data["amount"],data["slot"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONDESTROY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("functionDestroy",function(data)
	if MumbleIsConnected() then
		vSERVER.functionDestroy(data["index"],data["craft"],data["amount"],data["slot"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("populateSlot",function(data)
	if MumbleIsConnected() then
		TriggerServerEvent("crafting:populateSlot",data["item"],data["slot"],data["target"],data["amount"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSlot",function(data)
	if MumbleIsConnected() then
		TriggerServerEvent("crafting:updateSlot",data["item"],data["slot"],data["target"],data["amount"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("crafting:Update")
AddEventHandler("crafting:Update",function(action)
	SendNUIMessage({ action = action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local craftList = {
	{ 82.45,-1553.26,29.59,"lixeiroShop" },
	{ 287.36,2843.6,44.7,"lixeiroShop" },
	{ -413.68,6171.99,31.48,"lixeiroShop" },
	{ 1272.26,-1712.57,54.76,"ilegalWeapons" },
	{ 46.98,-1748.2,29.64,"legalShop" },
	{ 2747.42,3471.54,55.67,"legalShop" },
	{ 2524.34,4106.46,38.59,"theLostShop" },
	{ 813.34,-752.94,26.77,"pizzaThis" },
	{ -1200.02,-898.15,13.99,"burgerShot" },
	{ 1593.9,6455.35,26.02,"popsDiner" },
	{ -590.37,-1059.77,22.34,"Desserts" },
	{ -818.2,-717.87,23.78,"Triads" },
	{ 128.59,-3008.95,7.04,"mechanicShop" },
	{ 2431.49,4967.31,42.34,"craftHeroine" },
	{ -1870.5,2060.64,135.44,"vinhedoShop" },
	{ -1543.54,79.91,57.00,"playboyShop" },
	{ 415.73,-1508.83,33.8,"salierisShop" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTARGET
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)

	for k,v in pairs(craftList) do
		exports["target"]:AddCircleZone("Crafting:"..k,vector3(v[1],v[2],v[3]),1.0,{
			name = "Crafting:"..k,
			heading = 3374176
		},{
			shop = k,
			distance = 1.0,
			options = {
				{
					event = "crafting:openSystem",
					label = "Abrir",
					tunnel = "shop"
				}
			}
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING:OPENSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("crafting:openSystem",function(shopId)
	if vSERVER.requestPerm(craftList[shopId][4]) then
		SetNuiFocus(true,true)
		SendNUIMessage({ action = "showNUI", name = craftList[shopId][4] })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING:FUELSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("crafting:fuelShop",function()
	SetNuiFocus(true,true)
	SendNUIMessage({ action = "showNUI", name = "fuelShop" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING:OPENSOURCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("crafting:openSource")
AddEventHandler("crafting:openSource",function()
	SetNuiFocus(true,true)
	SendNUIMessage({ action = "showNUI", name = "craftShop" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING:AMMUNATION
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("crafting:Ammunation")
AddEventHandler("crafting:Ammunation",function()
	SetNuiFocus(true,true)
	SendNUIMessage({ action = "showNUI", name = "ammuShop" })
end)