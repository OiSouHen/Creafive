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
Tunnel.bindInterface("admin",cRP)
vCLIENT = Tunnel.getInterface("admin")
-----------------------------------------------------------------------------------------------------------------------------------------
-- GEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("gem",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") and parseInt(args[1]) > 0 and parseInt(args[2]) > 0 then
			local ID = parseInt(args[1])
			local Amount = parseInt(args[2])
			local identity = vRP.userIdentity(ID)
			if identity then
				vRP.execute("accounts/infosUpdategems",{ steam = identity["steam"], gems = Amount })
				TriggerEvent("discordLogs","Gemstones","**Passaporte:** "..ID.."\n**Recebeu:** "..Amount.." Gemas\n**Horário:** "..os.date("%H:%M:%S"),3092790)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("blips",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Moderator") then
			vRPC.blipsAdmin(source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("god",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") then
			if args[1] then
				local nuser_id = parseInt(args[1])
				local otherPlayer = vRP.userSource(nuser_id)
				if otherPlayer then
					vRP.upgradeThirst(nuser_id,100)
					vRP.upgradeHunger(nuser_id,100)
					vRP.downgradeStress(nuser_id,100)
					vRPC.revivePlayer(otherPlayer,200)
				end
			else
				vRP.setArmour(source,100)
				vRPC.revivePlayer(source,200)
				vRP.upgradeThirst(user_id,100)
				vRP.upgradeHunger(user_id,100)
				vRP.downgradeStress(user_id,100)
				TriggerClientEvent("resetHandcuff",source)
				TriggerClientEvent("resetBleeding",source)
				TriggerClientEvent("resetDiagnostic",source)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("item",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") then
			if args[1] and args[2] and itemBody(args[1]) ~= nil then
				vRP.generateItem(user_id,args[1],parseInt(args[2]),true)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRIORITY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("priority",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id and parseInt(args[1]) > 0 then
		if vRP.hasGroup(user_id,"Admin") then
			local nuser_id = parseInt(args[1])
			local identity = vRP.userIdentity(nuser_id)
			if identity then
				TriggerClientEvent("Notify",source,"verde","Prioridade adicionada.",5000)
				vRP.execute("accounts/setPriority",{ steam = identity["steam"], priority = 99 })
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("delete",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id and args[1] then
		if vRP.hasGroup(user_id,"Moderator") then
			local nuser_id = parseInt(args[1])
			vRP.execute("characters/removeCharacters",{ id = nuser_id })
			TriggerClientEvent("Notify",source,"verde","Personagem <b>"..nuser_id.."</b> deletado.",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("nc",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Moderator") then
			vRPC.noClip(source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("kick",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Moderator") and parseInt(args[1]) > 0 then
			TriggerClientEvent("Notify",source,"amarelo","Passaporte <b>"..args[1].."</b> expulso.",5000)
			vRP.kick(args[1],"Expulso da cidade.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ban",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Moderator") and parseInt(args[1]) > 0 and parseInt(args[2]) > 0 then
			local time = parseInt(args[2])
			local nuser_id = parseInt(args[1])
			local identity = vRP.userIdentity(nuser_id)
			if identity then
				vRP.kick(nuser_id,"Banido.")
				vRP.execute("banneds/insertBanned",{ steam = identity["steam"], time = time })
				TriggerClientEvent("Notify",source,"amarelo","Passaporte <b>"..nuser_id.."</b> banido por <b>"..time.." dias.",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNBAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("unban",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Moderator") and parseInt(args[1]) > 0 then
			local nuser_id = parseInt(args[1])
			local identity = vRP.userIdentity(nuser_id)
			if identity then
				vRP.execute("banneds/removeBanned",{ steam = identity["steam"] })
				TriggerClientEvent("Notify",source,"verde","Passaporte <b>"..nuser_id.."</b> desbanido.",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPCDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpcds",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Moderator") then
			local fcoords = vRP.prompt(source,"Cordenadas:","")
			if fcoords == "" then
				return
			end

			local coords = {}
			for coord in string.gmatch(fcoords or "0,0,0","[^,]+") do
				table.insert(coords,parseInt(coord))
			end

			vRP.teleport(source,coords[1] or 0,coords[2] or 0,coords[3] or 0)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cds",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Moderator") then
			local ped = GetPlayerPed(source)
			local coords = GetEntityCoords(ped)
			local heading = GetEntityHeading(ped)

			vRP.prompt(source,"Cordenadas:",mathLegth(coords["x"])..","..mathLegth(coords["y"])..","..mathLegth(coords["z"])..","..mathLegth(heading))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("group",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		--if vRP.hasGroup(user_id,"Admin") and parseInt(args[1]) > 0 and args[2] then
			TriggerClientEvent("Notify",source,"verde","Adicionado <b>"..args[2].."</b> ao passaporte <b>"..args[1].."</b>.",5000)
			vRP.setPermission(args[1],args[2])
		--end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNGROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ungroup",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") and parseInt(args[1]) > 0 and args[2] then
			TriggerClientEvent("Notify",source,"verde","Removido <b>"..args[2].."</b> ao passaporte <b>"..args[1].."</b>.",5000)
			vRP.remPermission(args[1],args[2])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTOME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tptome",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Moderator") and parseInt(args[1]) > 0 then
			local otherPlayer = vRP.userSource(args[1])
			if otherPlayer then
				local ped = GetPlayerPed(source)
				local coords = GetEntityCoords(ped)

				vRP.teleport(otherPlayer,coords["x"],coords["y"],coords["z"])
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpto",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Moderator") and parseInt(args[1]) > 0 then
			local otherPlayer = vRP.userSource(args[1])
			if otherPlayer then
				local ped = GetPlayerPed(otherPlayer)
				local coords = GetEntityCoords(ped)
				vRP.teleport(source,coords["x"],coords["y"],coords["z"])
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpway",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Moderator") then
			vCLIENT.teleportWay(source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("limbo",function(source,args,rawCommand)
	if exports["chat"]:statusChat(source) then
		local user_id = vRP.getUserId(source)
		if user_id and vRP.getHealth(source) <= 101 then
			vCLIENT.teleportLimbo(source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hash",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") then
			local vehicle = vRPC.vehicleHash(source)
			if vehicle then
				vRP.updateTxt("hash.txt",vehicle)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tuning",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") then
			TriggerClientEvent("admin:vehicleTuning",source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("fix",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") then
			local vehicle,vehNet,vehPlate = vRPC.vehList(source,10)
			if vehicle then
				local activePlayers = vRPC.activePlayers(source)
				for _,v in ipairs(activePlayers) do
					async(function()
						TriggerClientEvent("inventory:repairAdmin",v,vehNet,vehPlate)
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMPAREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("limparea",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Moderator") then
			local ped = GetPlayerPed(source)
			local coords = GetEntityCoords(ped)

			local activePlayers = vRPC.activePlayers(source)
			for _,v in ipairs(activePlayers) do
				async(function()
					TriggerClientEvent("syncarea",v,coords["x"],coords["y"],coords["z"],100)
				end)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("players",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Moderator") then
			TriggerClientEvent("Notify",source,"azul","<b>Jogadores Conectados:</b> "..GetNumPlayerIndices(),5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.buttonTxt()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") then
			local ped = GetPlayerPed(source)
			local coords = GetEntityCoords(ped)
			local heading = GetEntityHeading(ped)

			vRP.updateTxt(user_id..".txt",mathLegth(coords.x)..","..mathLegth(coords.y)..","..mathLegth(coords.z)..","..mathLegth(heading))
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANNOUNCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("announce",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") and args[1] then
			TriggerClientEvent("chatME",-1,"^6ALERTA^9Governador^0"..rawCommand:sub(9))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONSOLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("console",function(source,args,rawCommand)
	if source == 0 then
		TriggerClientEvent("chatME",-1,"^6ALERTA^9Governador^0"..rawCommand:sub(9))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICKALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("kickall",function(source,args,rawCommand)
	if source == 0 then
		local playerList = vRP.userList()
		for k,v in pairs(playerList) do
			vRP.kick(k,"Desconectado, a cidade reiniciou.")
			Citizen.Wait(100)
		end

		TriggerEvent("admin:KickAll")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("itemall",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") then
			local playerList = vRP.userList()
			for k,v in pairs(playerList) do
				async(function()
					vRP.generateItem(k,tostring(args[1]),parseInt(args[2]),true)
				end)
			end

			TriggerClientEvent("Notify",source,"verde","Envio concluído.",10000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RACECOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local checkPoints = 0
function cRP.raceCoords(vehCoords,leftCoords,rightCoords)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		checkPoints = checkPoints + 1

		vRP.updateTxt("races.txt","["..checkPoints.."] = {")

		vRP.updateTxt("races.txt","{ "..mathLegth(vehCoords["x"])..","..mathLegth(vehCoords["y"])..","..mathLegth(vehCoords["z"]).." },")
		vRP.updateTxt("races.txt","{ "..mathLegth(leftCoords["x"])..","..mathLegth(leftCoords["y"])..","..mathLegth(leftCoords["z"]).." },")
		vRP.updateTxt("races.txt","{ "..mathLegth(rightCoords["x"])..","..mathLegth(rightCoords["y"])..","..mathLegth(rightCoords["z"]).." }")

		vRP.updateTxt("races.txt","},")
	end
end