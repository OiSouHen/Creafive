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
Tunnel.bindInterface("hud",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local callTimers = {}
local wantedTimers = {}
local reposeTimers = {}
GlobalState["Nitro"] = {}
GlobalState["Hours"] = 12
GlobalState["Minutes"] = 0
GlobalState["Weather"] = "CLEAR"
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEATHERLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local weatherList = { "CLEAR","EXTRASUNNY","SMOG","OVERCAST","CLOUDS","CLEARING" }
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYNC
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		GlobalState["Minutes"] = GlobalState["Minutes"] + 1

		if GlobalState["Minutes"] >= 60 then
			GlobalState["Hours"] = GlobalState["Hours"] + 1
			GlobalState["Minutes"] = 0

			if GlobalState["Hours"] >= 24 then
				GlobalState["Hours"] = 0

				repeat
					randWeather = math.random(#weatherList)
				until GlobalState["Weather"] ~= weatherList[randWeather]

				GlobalState["Weather"] = weatherList[randWeather]
			end
		end

		Citizen.Wait(10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("timeset",function(source,args,rawCommand)
	if exports["chat"]:statusChat(source) then
		local user_id = vRP.getUserId(source)
		if user_id then
			if vRP.hasGroup(user_id,"Admin") then
				GlobalState["Hours"] = parseInt(args[1])
				GlobalState["Minutes"] = parseInt(args[2])

				if args[3] then
					GlobalState["Weather"] = args[3]
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATENITRO
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateNitro(vehPlate,nitroFuel)
	if GlobalState["Nitro"][vehPlate] then
		local Nitro = GlobalState["Nitro"]
		Nitro[vehPlate] = nitroFuel
		GlobalState["Nitro"] = Nitro
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WANTED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("Wanted")
AddEventHandler("Wanted",function(source,user_id,seconds)
	if wantedTimers[user_id] then
		wantedTimers[user_id] = wantedTimers[user_id] + seconds
	else
		wantedTimers[user_id] = os.time() + seconds
	end

	TriggerClientEvent("hud:wantedClient",source,wantedTimers[user_id] - os.time())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("Repose")
AddEventHandler("Repose",function(source,user_id,seconds)
	if reposeTimers[user_id] then
		reposeTimers[user_id] = reposeTimers[user_id] + seconds
	else
		reposeTimers[user_id] = os.time() + seconds
	end

	TriggerClientEvent("hud:reposeClient",source,reposeTimers[user_id] - os.time())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WANTED
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Wanted",function(user_id,source)
	local source = parseInt(source)
	local user_id = parseInt(user_id)

	if wantedTimers[user_id] then
		if wantedTimers[user_id] > os.time() then
			if callTimers[user_id] == nil then
				callTimers[user_id] = os.time()
			end

			if callTimers[user_id] <= os.time() and source > 0 then
				callTimers[user_id] = os.time() + 60

				TriggerClientEvent("Notify",source,"amarelo","Você foi denunciado, parece que suas digitais<br>estão no banco de dados do governo como procurado.",5000)

				local ped = GetPlayerPed(source)
				local coords = GetEntityCoords(ped)
				local policeResult = vRP.numPermission("Police")

				for k,v in pairs(policeResult) do
					async(function()
						TriggerClientEvent("NotifyPush",v,{ code = 20, title = "Digitais Encontrada", x = coords["x"], y = coords["y"], z = coords["z"], criminal = "Alerta de procurado", time = "Recebido às "..os.date("%H:%M"), blipColor = 16 })
					end)
				end
			end

			return true
		end
	end

	return false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPOSE
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Repose",function(user_id)
	local user_id = parseInt(user_id)

	if reposeTimers[user_id] then
		if reposeTimers[user_id] > os.time() then
			return true
		end
	end

	return false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerConnect",function(user_id,source)
	if wantedTimers[user_id] then
		if wantedTimers[user_id] > os.time() then
			TriggerClientEvent("hud:wantedClient",source,wantedTimers[user_id] - os.time())
		end
	end

	if reposeTimers[user_id] then
		if reposeTimers[user_id] > os.time() then
			TriggerClientEvent("hud:reposeClient",source,reposeTimers[user_id] - os.time())
		end
	end
end)