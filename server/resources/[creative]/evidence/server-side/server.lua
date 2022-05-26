-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vCLIENT = Tunnel.getInterface("evidence")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local evidenceNumber = 0
GlobalState["Evidences"] = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPEVIDENCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("evidence:dropEvidence")
AddEventHandler("evidence:dropEvidence",function(evidenceType)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local evidenceItem = 1
		local evidenceColor = {}

		if evidenceType == "yellow" then
			evidenceItem = 1
			evidenceColor = { 244,197,50 }
		elseif evidenceType == "red" then
			evidenceItem = 2
			evidenceColor = { 241,96,96 }
		elseif evidenceType == "green" then
			evidenceItem = 3
			evidenceColor = { 140,212,91 }
		elseif evidenceType == "blue" then
			evidenceItem = 4
			evidenceColor = { 70,140,245 }
		end

		evidenceNumber = evidenceNumber + 1
		local identity = vRP.userIdentity(user_id)
		local userCoords,gridZone = vCLIENT.getPostions(source)
		local Evidences = GlobalState["Evidences"]

		if Evidences[gridZone] == nil then
			Evidences[gridZone] = {}
		end

		Evidences[gridZone][tostring(evidenceNumber)] = { userCoords,tostring("evidence0"..evidenceItem.."-"..identity["serial"]),evidenceColor }

		GlobalState["Evidences"] = Evidences
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEEVIDENCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("evidence:removeEvidence")
AddEventHandler("evidence:removeEvidence",function(evidenceId,gridZone)
	if GlobalState["Evidences"][gridZone] then
		local Evidences = GlobalState["Evidences"]
		Evidences[gridZone][tostring(evidenceId)] = nil
		GlobalState["Evidences"] = Evidences
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PICKUPEVIDENCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("evidence:pickupEvidence")
AddEventHandler("evidence:pickupEvidence",function(evidenceId,gridZone)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if GlobalState["Evidences"][gridZone] then
			if GlobalState["Evidences"][gridZone][tostring(evidenceId)] then
				vRP.giveInventoryItem(user_id,GlobalState["Evidences"][gridZone][tostring(evidenceId)][2],1,true)

				local Evidences = GlobalState["Evidences"]
				Evidences[gridZone][tostring(evidenceId)] = nil
				GlobalState["Evidences"] = Evidences
			end
		end
	end
end)