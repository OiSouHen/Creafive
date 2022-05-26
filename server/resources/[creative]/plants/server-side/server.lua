-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPC = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Plants = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTTYPES
-----------------------------------------------------------------------------------------------------------------------------------------
local plantTypes = {
	["weedseed"] = { "Maconha","weedleaf" },
	["cokeseed"] = { "Cocaína","cokeleaf" },
	["mushseed"] = { "Cogumelo","mushroom" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITPLANTS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("initPlants",function(seedType,coords,route,prop,user_id)
	local Number = 0

	repeat
		Number = Number + 1
	until Plants[tostring(Number)] == nil

	Plants[tostring(Number)] = {
		["coords"] = { mathLegth(coords["x"]),mathLegth(coords["y"]),mathLegth(coords["z"]) },
		["time"] = os.time() + 12000,
		["type"] = seedType,
		["fertilizer"] = 0,
		["route"] = route,
		["prop"] = prop,
		["user_id"] = user_id
	}

	TriggerClientEvent("plants:Adicionar",-1,tostring(Number),Plants[tostring(Number)])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS:COLETAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("plants:Coletar")
AddEventHandler("plants:Coletar",function(Number)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and Plants[Number] then
		if vRP.hasGroup(user_id,"Moderator") then
			TriggerClientEvent("Notify",source,"vermelho","Passaporte: "..Plants[Number]["user_id"],5000)
		end

		if os.time() >= Plants[Number]["time"] then
			if (vRP.inventoryWeight(user_id) + itemWeight(plantTypes[Plants[Number]["type"]][2]) * 3) <= vRP.getWeight(user_id) then
				local Type = Plants[Number]["type"]
				Plants[Number] = nil

				TriggerClientEvent("Progress",source,10000)
				TriggerClientEvent("vRP:Cancel",source,true)
				TriggerClientEvent("player:Commands",source,true)
				vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)

				Citizen.Wait(10000)

				vRP.generateItem(user_id,plantTypes[Type][2],3,true)
				TriggerClientEvent("player:Commands",source,false)
				TriggerClientEvent("plants:Remover",-1,Number)
				TriggerClientEvent("vRP:Cancel",source,false)
				vRPC.stopAnim(source,false)

				if Type ~= "mushseed" then
					vRP.generateItem(user_id,"bucket",1,true)
				end
			else
				TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS:ESTAQUIA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("plants:Estaquia")
AddEventHandler("plants:Estaquia",function(Number)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and Plants[Number] then
		if (Plants[Number]["time"] - os.time()) <= 6000 then
			local provPlants = Plants[Number]
			Plants[Number] = nil

			TriggerClientEvent("Progress",source,10000)
			TriggerClientEvent("vRP:Cancel",source,true)
			TriggerClientEvent("player:Commands",source,true)
			vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)

			Citizen.Wait(10000)

			vRP.generateItem(user_id,provPlants["type"],2,true)
			TriggerClientEvent("player:Commands",source,false)
			TriggerClientEvent("plants:Remover",-1,Number)
			TriggerClientEvent("vRP:Cancel",source,false)
			vRPC.stopAnim(source,false)

			if provPlants["type"] ~= "mushseed" then
				vRP.generateItem(user_id,"bucket",1,true)
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Progresso mínimo <b>50%</b> para a <b>Estaquia</b>.",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS:FERTILIZAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("plants:Fertilizar")
AddEventHandler("plants:Fertilizar",function(Number)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and Plants[Number] then
		if Plants[Number]["fertilizer"] < 3 and (Plants[Number]["time"] - os.time()) >= 600 then
			if vRP.tryGetInventoryItem(user_id,"fertilizer",1,true) then
				TriggerClientEvent("Notify",source,"verde","Fertilização completa.",5000)
				Plants[Number]["fertilizer"] = Plants[Number]["fertilizer"] + 1
				Plants[Number]["time"] = Plants[Number]["time"] - 600
			else
				TriggerClientEvent("Notify",source,"amarelo","Necessário possuir <b>1x Fertilizante</b>.",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS:INFORMACOES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("plants:Informacoes")
AddEventHandler("plants:Informacoes",function(Number)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and Plants[Number] then
		local percPlants = 100
		if os.time() < Plants[Number]["time"] then
			local timePlants = parseInt((os.time() - Plants[Number]["time"]) / 120) + 100
			percPlants = timePlants
		end

		TriggerClientEvent("Notify",source,"azul","<b>Tipo:</b> "..plantTypes[Plants[Number]["type"]][1].."<br><b>Progresso:</b> "..percPlants.."%<br><b>Fertilização:</b> "..Plants[Number]["fertilizer"],10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:KICKALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("admin:KickAll")
AddEventHandler("admin:KickAll",function()
	SaveResourceFile("logsystem","plants.json",json.encode(Plants),-1)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ASYNCFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local coordsFile = LoadResourceFile("logsystem","plants.json")
	Plants = json.decode(coordsFile)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerConnect",function(user_id,source)
	TriggerClientEvent("plants:Table",source,Plants)
end)