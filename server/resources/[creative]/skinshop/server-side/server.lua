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
Tunnel.bindInterface("skinshop",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKOPEN
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkShares()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getFines(user_id) > 0 then
			TriggerClientEvent("Notify",source,"amarelo","Multas pendentes encontradas.",3000)
			return false
		end

		if exports["hud"]:Repose(user_id) or exports["hud"]:Wanted(user_id,source) then
			return false
		end

		return true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATECLOTHES
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateClothes(clothes)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.execute("playerdata/setUserdata",{ user_id = user_id, key = "Clothings", value = json.encode(clothes) })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("skin",function(source,args,rawCommand)
	if exports["chat"]:statusChat(source) then
		local user_id = vRP.getUserId(source)
		if user_id and args[1] then
			if vRP.hasGroup(user_id,"Paramedic") or vRP.hasGroup(user_id,"Moderator") then
				local otherPlayer = vRP.userSource(args[1])
				if otherPlayer then
					vRPC.applySkin(otherPlayer,GetHashKey(args[2]))
					vRP.updateSelectSkin(parseInt(args[1]),GetHashKey(args[2]))
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINSHOP:REMOVEPROPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("skinshop:removeProps")
AddEventHandler("skinshop:removeProps",function(mode)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local otherPlayer = vRPC.nearestPlayer(source)
		if otherPlayer then
			if vRP.hasGroup(user_id,"Police") then
				TriggerClientEvent("skinshop:set"..mode,otherPlayer)
			end
		end
	end
end)