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
Tunnel.bindInterface("postit",cRP)
vCLIENT = Tunnel.getInterface("postit")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["Postit"] = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEWPOSTITS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.newPostIts(coords)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local globalPostIts = GlobalState["Postit"]
		local message = vRP.prompt(source,"Texto:","")
		if message ~= "" then
			local distance = vRP.prompt(source,"Distância: (Mínimo: 3 / Máximo: 15)","")
			if distance ~= "" and parseInt(distance) >= 3 and parseInt(distance) <= 15 then
				if vRP.tryGetInventoryItem(user_id,"postit",1,true) then
					table.insert(globalPostIts,{ mathLegth(coords["x"]),mathLegth(coords["y"]),mathLegth(coords["z"]),string.sub(message,1,100),parseInt(distance),user_id,os.time() + 60 })
					GlobalState["Postit"] = globalPostIts
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETEPOSTITS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.deletePostIts(id)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local globalPostIts = GlobalState["Postit"]

		if vRP.hasGroup(user_id,"Moderator") then
			TriggerClientEvent("Notify",source,"verde","Post-It do passaporte <b>"..globalPostIts[id][6].."</b> removido.",10000)
			globalPostIts[id] = nil
			GlobalState["Postit"] = globalPostIts
			TriggerClientEvent("postit:deletePostIts",-1,id)
		else
			if globalPostIts[id][6] == user_id then
				if os.time() <= globalPostIts[id][7] then
					vRP.generateItem(user_id,"postit",1,true)
				end

				globalPostIts[id] = nil
				GlobalState["Postit"] = globalPostIts
				TriggerClientEvent("postit:deletePostIts",-1,id)
			end
		end
	end
end