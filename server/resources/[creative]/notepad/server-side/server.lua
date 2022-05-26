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
Tunnel.bindInterface("notepad",cRP)
vCLIENT = Tunnel.getInterface("notepad")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local notepedIds = 0
GlobalState["Notepad"] = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATENOTEPAD
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.createNotepad(text)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		notepedIds = notepedIds + 1
		local ped = GetPlayerPed(source)
		local coords = GetEntityCoords(ped)

		local notePad = GlobalState["Notepad"]
		notePad[notepedIds] = { user_id = user_id, id = notepedIds, text = tostring(text), x = coords["x"], y = coords["y"], z = coords["z"] }
		GlobalState["Notepad"] = notePad
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EDITNOTEPAD
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.editNotepad(id,text)
	if GlobalState["Notepad"][id] then
		local notePad = GlobalState["Notepad"]
		notePad[id]["text"] = tostring(text)
		GlobalState["Notepad"] = notePad
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESTROYNOTEPAD
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.destroyNotepad(id)
	if GlobalState["Notepad"][id] then
		local notePad = GlobalState["Notepad"]

		notePad[id] = nil

		GlobalState["Notepad"] = notePad
	end
end