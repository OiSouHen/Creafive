-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Proxy = module("lib/Proxy")
local Tunnel = module("lib/Tunnel")
vRPC = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vRP = {}
tvRP = {}
vRP.userIds = {}
vRP.userInfos = {}
vRP.userTables = {}
vRP.userSources = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNNER/PROXY
-----------------------------------------------------------------------------------------------------------------------------------------
Proxy.addInterface("vRP",vRP)
Tunnel.bindInterface("vRP",tvRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCORDHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webHook = ""
-----------------------------------------------------------------------------------------------------------------------------------------
-- MYSQL
-----------------------------------------------------------------------------------------------------------------------------------------
local mysqlDriver
local userSql = {}
local mysqlInit = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- CACHE
-----------------------------------------------------------------------------------------------------------------------------------------
local cacheQuery = {}
local cachePrepare = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETIDENTITIES
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getIdentities(source)
	local result = false

	local identifiers = GetPlayerIdentifiers(source)
	for _,v in pairs(identifiers) do
		if string.find(v,"steam") then
			local splitName = splitString(v,":")
			result = splitName[2]
			break
		end
	end

	return result
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REGISTERDRIVERS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.registerDrivers(name,onInit,onPrepare,onQuery)
	if not userSql[name] then
		userSql[name] = { onInit,onPrepare,onQuery }
		mysqlDriver = userSql[name]
		mysqlInit = true

		for _,prepare in pairs(cachePrepare) do
			onPrepare(table.unpack(prepare,1,table.maxn(prepare)))
		end

		for _,query in pairs(cacheQuery) do
			query[2](onQuery(table.unpack(query[1],1,table.maxn(query[1]))))
		end

		cachePrepare = {}
		cacheQuery = {}
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATETXT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.updateTxt(archive,text)
	archive = io.open("resources/logsystem/"..archive,"a")
	if archive then
		archive:write(text.."\n")
	end

	archive:close()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.prepare(name,query)
	if mysqlInit then
		mysqlDriver[2](name,query)
	else
		table.insert(cachePrepare,{ name,query })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUERY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.query(name,params,mode)
	if not mode then mode = "query" end

	if mysqlInit then
		return mysqlDriver[3](name,params or {},mode)
	else
		local r = async()
		table.insert(cacheQuery,{{ name,params or {},mode },r })
		return r:wait()
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXECUTE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.execute(name,params)
	return vRP.query(name,params,"execute")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKBANNED
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.checkBanned(steam)
	local consult = vRP.query("banneds/getBanned",{ steam = steam })
	if consult[1] then
		if consult[1]["time"] >= os.time() then
			vRP.execute("banneds/removeBanned",{ steam = steam })
			return false
		end

		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INFOACCOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.infoAccount(steam)
	local infoAccount = vRP.query("accounts/getInfos",{ steam = steam })
	return infoAccount[1] or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERDATA
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.userData(user_id,key)
	local consult = vRP.query("playerdata/getUserdata",{ user_id = user_id, key = key })
	if consult[1] then
		return json.decode(consult[1]["dvalue"])
	else
		return {}
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEHOMEPOSITION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.updateHomePosition(user_id,x,y,z)
	local dataTable = vRP.getDatatable(user_id)
	if dataTable then
		dataTable["position"] = { x = mathLegth(x), y = mathLegth(y), z = mathLegth(z) }
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERINVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.userInventory(user_id)
	local dataTable = vRP.getDatatable(user_id)
	if dataTable then
		if dataTable["inventory"] == nil then
			dataTable["inventory"] = {}
		end

		return dataTable["inventory"]
	end

	return {}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESELECTSKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.updateSelectSkin(user_id,hash)
	local dataTable = vRP.getDatatable(user_id)
	if dataTable then
		dataTable["skin"] = hash
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETUSERID
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getUserId(source)
	return vRP.userIds[parseInt(source)]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.userList()
	return vRP.userSources
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.userPlayers()
	return vRP.userIds
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETUSERSOURCE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.userSource(user_id)
	return vRP.userSources[parseInt(user_id)]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETDATATABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getDatatable(user_id)
	return vRP.userTables[parseInt(user_id)] or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDROPPED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDropped",function(reason)
	playerDropped(source,reason)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.kick(user_id,reason)
	local userSource = vRP.userSource(user_id)
	if userSource then
		playerDropped(userSource,"Kick/Afk")
		DropPlayer(userSource,reason)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDROPPED
-----------------------------------------------------------------------------------------------------------------------------------------
function playerDropped(source,reason)
	local source = parseInt(source)
	local user_id = vRP.getUserId(source)
	if user_id then
		TriggerEvent("discordLogs","Disconnect","**Source:** "..parseFormat(source).."\n**Passaporte:** "..parseFormat(user_id).."\n**Motivo:** "..reason.."\n**Horário:** "..os.date("%H:%M:%S"),3092790)

		local dataTable = vRP.getDatatable(user_id)
		if dataTable then
			local ped = GetPlayerPed(source)
			local coords = GetEntityCoords(ped)

			dataTable["armour"] = GetPedArmour(ped)
			dataTable["health"] = GetEntityHealth(ped)
			dataTable["position"] = { x = mathLegth(coords["x"]), y = mathLegth(coords["y"]), z = mathLegth(coords["z"]) }

			TriggerEvent("playerDisconnect",user_id,source)
			vRP.execute("playerdata/setUserdata",{ user_id = user_id, key = "Datatable", value = json.encode(dataTable) })
			vRP.userSources[user_id] = nil
			vRP.userTables[user_id] = nil
			vRP.userInfos[user_id] = nil
			vRP.userIds[source] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERCONNECTING
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Queue:playerConnecting",function(source,identifiers,deferrals)
	local steam = vRP.getIdentities(source)
	if steam then
		if not vRP.checkBanned(steam) then
			local infoAccount = vRP.infoAccount(steam)
			if infoAccount then
				if infoAccount["whitelist"] then
					deferrals.done()
				else
					deferrals.done("Envie na sala liberação: "..steam)
				end
			else
				vRP.execute("accounts/newAccount",{ steam = steam })
				deferrals.done("Envie na sala liberação: "..steam)
			end
		else
			deferrals.done("Banido.")
		end
	else
		deferrals.done("Conexão perdida com a Steam.")
	end

	TriggerEvent("Queue:removeQueue",identifiers)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERCHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.characterChosen(source,user_id,model,locate)
	vRP.userIds[source] = user_id
	vRP.userSources[user_id] = source
	local identity = vRP.userIdentity(user_id)
	vRP.userTables[user_id] = vRP.userData(user_id,"Datatable")

	if model ~= nil then
		vRP.userTables[user_id]["inventory"] = {}
		vRP.generateItem(user_id,"water",3,false)
		vRP.generateItem(user_id,"sandwich",3,false)
		vRP.generateItem(user_id,"cellphone",1,false)
		vRP.userTables[user_id]["skin"] = GetHashKey(model)
		vRP.generateItem(user_id,"identity-"..user_id,1,false)

		if locate == "Sul" then
			vRP.userTables[user_id]["position"] = { x = -28.08, y = -145.96, z = 56.99 }
		else
			vRP.userTables[user_id]["position"] = { x = 1935.59, y = 3721.93, z = 32.87 }
		end
	end

	local userBank = vRP.userBank(user_id,"Private")
	if userBank then
		vRP.userInfos[user_id]["bank"] = userBank["value"]
	end

	local infoAccount = vRP.infoAccount(identity["steam"])
	if infoAccount then
		vRP.userInfos[user_id]["premium"] = infoAccount["premium"]
		vRP.userInfos[user_id]["chars"] = infoAccount["chars"]

		PerformHttpRequest(webHook,function(err,text,headers) end,"POST",json.encode({
			content = infoAccount["discord"].." #"..user_id.." "..identity["name"]
		}),{ ["Content-Type"] = "application/json" })
	end

	local Identities = vRP.getIdentities(source)
	if Identities ~= identity["steam"] then
		vRP.kick(user_id,"Expulso da cidade.")
	end

	TriggerEvent("playerConnect",user_id,source)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetGameType("Creative Roleplay")
	SetMapName("www.creative-rp.com")
	SetRoutingBucketEntityLockdownMode(0,"relaxed")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:PRINT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("vRP:Print")
AddEventHandler("vRP:Print",function(message)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		TriggerEvent("discordLogs","Hackers","Passaporte **"..user_id.."** "..message..".",3092790)
	end
end)

vRP.getUserSource = vRP.userSource
